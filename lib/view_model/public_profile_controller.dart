import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/model/AreaOption.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../model/LoginModel.dart' hide Experience, Achievement;
import '../model/achievement.dart';
import '../model/experience_model.dart';
import '../service/ConnectivityService.dart';
import '../service/main_repository.dart';
import '../utilites/constants_Utils.dart';
import '../utilites/error_handler.dart';
import 'bottom_nav_controller.dart';

class PublicProfileController extends GetxController {
  final storage = GetStorage();
  Rx<LoginModel?> loginResponse = Rx<LoginModel?>(
    null,
  ); // Initialize with a default value
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  final MainRepository repository = MainRepository(); // API service instance
  final ConnectivityService connectivityService =
      Get.find<ConnectivityService>(); // Connectivity service instance

  // Observable variables
  final ImagePicker _picker = ImagePicker();
  var pickedImageFile = Rx<File?>(null);

  final RxString firstNameError = ''.obs;
  final RxString lastNameError = ''.obs;
  final RxString currentRoleCompanyError = ''.obs;
  final RxString cityError = ''.obs;
  final RxString linkedinError = ''.obs;
  final RxString twitterError = ''.obs;
  final RxString facebookError = ''.obs;

  final RxString name = 'suresh'.obs;
  final RxString bio = 'bts'.obs;
  final RxString location = 'hyd,telangana'.obs;
  RxString selectedExperienceId = ''.obs;
  final RxList<Experience> experiences = <Experience>[].obs;
  RxMap<String, Experience> experienceOptionMap = <String, Experience>{}.obs;

  final RxList<Achievement> honorsAwards = <Achievement>[].obs;

  final RxList<String> expertise = <String>[].obs;
  final RxList<String> selectedExpertise = <String>[].obs;

  final RxList<String> areaOfInterest = <String>[].obs;
  final RxList<String> selectedAreaOfInterest = <String>[].obs;

  final RxString publicProfileUrl =
      'https://ejggygfyfyfyffyfyfyfyfyfyfyfyfyfxamplegggggugjghfyfyfyfyfyfyuugug.com/profile/johndoe'
          .obs;
  final RxString coverBgImage = ''.obs;
  final RxString profileImageUrl = ''.obs;
  final RxString aboutMe = ''.obs;
  RxBool isAboutExpanded = false.obs;
  final RxList<String> companyRoleOptions = <String>[].obs;
  final RxBool isCurrentlyWorking = false.obs;

  //
  final TextEditingController profileUrlController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyRoleController = TextEditingController();
  final TextEditingController currentRoleController = TextEditingController();
  final TextEditingController currentCompanyController =
      TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController linkedinController = TextEditingController();
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController aboutMeController =
      TextEditingController(); // Added for description
  final TextEditingController roleController =
      TextEditingController(); // Added for description
  final TextEditingController companyController =
      TextEditingController(); // Added for description
  // Added for description
  final TextEditingController endDateController =
      TextEditingController(); // Added for description

  final TextEditingController awardTitleController =
      TextEditingController(); // Added for description
  final TextEditingController awardIssuedBy =
      TextEditingController(); // Added for description
  final TextEditingController awardDescription =
      TextEditingController(); // Added for description

  final GlobalKey<FormState> honorFormKey = GlobalKey<FormState>();
  final experienceFormKey = GlobalKey<FormState>();

  // Initialize with some mock data
  @override
  void onInit() {
    super.onInit();
    initializeController();
  }

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        pickedImageFile.value = File(image.path);
        profileImageUrl.value = image.path; // for local display fallback
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // initialize
  Future<void> initializeController() async {
    final response = await ConstantsUtils.getStoredLoginResponse();
    if (response != null) {
      loginResponse.value = response; // ✅ CORRECT WAY

      await getProfileData(loginResponse.value?.data?.uniqueId ?? '');
    } else {
      errorMessage.value = 'Failed to load login response';
    }
  }

  // Fetch profile data from API
  Future<void> getProfileData(String? uniqueId) async {
    if (uniqueId == null || uniqueId.isEmpty) {
      errorMessage.value = 'Invalid user ID';
      return;
    }

    if (!connectivityService.isConnected.value) {
      errorMessage.value = 'No internet connection';
      return;
    }

    try {
      isLoading(true);
      errorMessage.value = '';

      print('Fetching profile for ID: $uniqueId');

      final response = await repository.getProfile(uniqueId);
      print('Profile received: ${response.data.experience.length}');

      name.value =
          "${response.data?.name?.firstName} ${response.data?.name?.lastName}" ??
          '';

      ///final experiences1 = response.data?.experience ?? [];

      location.value =
          "${response.data?.address?.city}, ${response.data?.address?.state}, ${response.data?.address?.country} " ??
          'Unknown City';
      coverBgImage.value = response.data?.coverImageUrl ?? '';
      profileImageUrl.value = response.data?.profileImageUrl ?? '';

      publicProfileUrl.value = response.data?.username ?? '';
      profileUrlController.text = publicProfileUrl.value;

      // PROFILE DATA
      firstNameController.text = response.data?.name?.firstName ?? '';
      lastNameController.text = response.data?.name?.lastName ?? '';
      currentRoleController.text = response.data?.currentRole ?? '';
      locationController.text = location.value;
      linkedinController.text = response.data?.linkedInProfileUrl ?? '';
      twitterController.text = response.data?.twitterProfileUrl ?? '';
      facebookController.text = response.data?.facebookProfileUrl ?? '';

      // ABOUT
      aboutMe.value = response.data?.aboutMe ?? '';
      aboutMeController.text = aboutMe.value;

      // EXPERIENCES
      final rawList = response.data.experience;

      if (rawList.isNotEmpty && rawList.first is Map<String, dynamic>) {
        // If raw JSON, deserialize
        experiences.value =
            rawList
                .map((e) => Experience.fromJson(e as Map<String, dynamic>))
                .toList();
      } else {
        // Already deserialized
        experiences.value = List<Experience>.from(rawList);
      }
      print('experiences.length ${experiences.length}');

      // Step 1: Get all experiences
      final allExperiences = experiences.toList();

      // Step 2: Filter experiences with status 1 or 2
      final filtered =
          allExperiences
              .where((exp) => exp.status == 1 || exp.status == 2)
              .toList();

      // Step 3: Create dropdown options and map
      final Map<String, Experience> optionMap = {};
      for (final exp in filtered) {
        final key = '${exp.role} - ${exp.company}';
        optionMap[key] = exp;
      }

      // Step 4: Assign dropdown and map
      companyRoleOptions.assignAll(optionMap.keys.toList());
      experienceOptionMap.assignAll(optionMap);

      // Step 5: Default selection ONLY if status == 2
      final defaultExperience = experiences.firstWhereOrNull(
        (exp) => exp.status == 2,
      );
      if (defaultExperience != null) {
        final key = '${defaultExperience.role} - ${defaultExperience.company}';
        companyRoleController.text = key;
      } else {
        companyRoleController.clear();
      }

      // bio
      if (defaultExperience != null &&
          defaultExperience.role != null &&
          defaultExperience.company != null &&
          defaultExperience.role!.trim().isNotEmpty &&
          defaultExperience.company!.trim().isNotEmpty) {
        bio.value = '${defaultExperience.role}\n${defaultExperience.company}';
      } else {
        bio.value = 'N/A';
      }
      // HONORS AND AWARDS
      final rawHonorList = response.data?.achievements;

      if (rawHonorList != null) {
        if (rawHonorList.isNotEmpty &&
            rawHonorList.first is Map<String, dynamic>) {
          // If raw JSON, deserialize
          honorsAwards.value =
              rawHonorList
                  .map((e) => Achievement.fromJson(e as Map<String, dynamic>))
                  .toList();
        } else {
          // Already deserialized
          honorsAwards.value = List<Achievement>.from(rawHonorList);
        }
      }
      print('honorsAwards.length ${honorsAwards.length}');

      // EXPERTISE
      expertise.value = response.data?.functionalExpertise ?? [];
      selectedExpertise.clear();
      selectedExpertise.addAll(expertise);

      // AREA OF INTEREST
      areaOfInterest.value = response.data?.areasOfInterest ?? [];
      selectedAreaOfInterest.clear();
      selectedAreaOfInterest.addAll(areaOfInterest);

      update();

      print('Profile data loaded successfully');
    } catch (e) {
      print('Profile fetch error: $e');
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateUserProfileData() async {
    // Reset all error messages
    firstNameError.value = '';
    lastNameError.value = '';
    currentRoleCompanyError.value = '';
    cityError.value = '';
    linkedinError.value = '';
    twitterError.value = '';
    facebookError.value = '';

    if (firstNameController.text.trim().isEmpty) {
      firstNameError.value = 'First Name is required';
      return;
    }

    if (lastNameController.text.trim().isEmpty) {
      lastNameError.value = 'Last Name is required';
      return;
    }

    final addressText = locationController.text.trim();
    if (addressText.isEmpty) {
      cityError.value = 'Please select city';
      return;
    } else if (ConstantsUtils.checkString(addressText)) {
      cityError.value = 'Please select city and state';
      return;
    }

    final linkedin = linkedinController.text.trim();
    if (linkedin.isEmpty) {
      linkedinError.value = 'LinkedIn URL is required';
      return;
    } else if (!ConstantsUtils.isValidUrl(linkedin)) {
      linkedinError.value = 'Please enter a valid LinkedIn URL';
      return;
    }

    final twitter = twitterController.text.trim();
    if (twitter.isNotEmpty && !ConstantsUtils.isValidUrl(twitter)) {
      twitterError.value = 'Please enter valid Twitter URL';
      return;
    }

    final facebook = facebookController.text.trim();
    if (facebook.isNotEmpty && !ConstantsUtils.isValidUrl(facebook)) {
      facebookError.value = 'Please enter valid Facebook URL';
      return;
    }

    try {
      isLoading(true);
      errorMessage.value = '';

      String city = '';
      String state = '';
      String country = '';

      final address = locationController.text.trim();
      final parts = address.split(',');

      if (parts.length >= 3) {
        city = parts[0].trim();
        state = parts[1].trim();
        country = parts[2].trim();
      }

      // Match experience ID from selected dropdown value
      final selectedText = companyRoleController.text.trim();
      String? selectedExperienceId;

      final matchedExperience = experiences.firstWhereOrNull((exp) {
        final role = exp.role?.trim() ?? '';
        final company = exp.company?.trim() ?? '';
        return (exp.status == 1 || exp.status == 2) &&
            "$role, $company" == selectedText;
      });


      if (matchedExperience != null) {
        selectedExperienceId = matchedExperience.id;
      }

      // Build the request body
      final Map<String, dynamic> profileUpdateBody = {
        "name": {
          "first_name": firstNameController.text.trim(),
          "last_name": lastNameController.text.trim(),
        },
        "linkedInProfileUrl": linkedinController.text.trim(),
        "twitterProfileUrl": twitterController.text.trim(),
        "facebookProfileUrl": facebookController.text.trim(),
        "address": {"city": city, "state": state, "country": country},
        "imageUrl": profileImageUrl.value,
      };

      final response = await repository.updatePublicProfileRequest(
        loginResponse.value?.data?.tokenDetail?.token,
        profileUpdateBody,
        loginResponse.value?.data?.uniqueId,
      );

      if (response.statusCode == 200) {
        await storage.write('userData', jsonEncode(response.toJson()));
        loginResponse.value = response;

        // ✅ Important: Reflect updated data in UI
        // After updating
        name.value =
            '${response.data?.name?.firstName} ${response.data?.name?.lastName}';
        location.value =
            '${response.data?.address?.city}, ${response.data?.address?.state}, ${response.data?.address?.country}';

        ConstantsUtils.showToast('Profile updated successfully');
        final BottomNavController bottomNav = Get.find<BottomNavController>();
        bottomNav.loginResponse.value = response;

        // Update reactive Experience
        updateExperinceStatus();
      } else {
        errorMessage.value = response.message ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateUserProfileUrl() async {
    final username = profileUrlController.text.trim();
    if (username.isEmpty) {
      Get.snackbar('Error', 'Please enter a username');
      return;
    }

    try {
      isLoading(true);
      errorMessage.value = '';

      final Map<String, dynamic> userProfileBody = {
        "account": loginResponse.value?.data?.email,
        "username": username,
        "access_token": loginResponse.value?.data?.tokenDetail?.token,
      };

      final response = await repository.updateProfileUrlRequest(
        loginResponse.value?.data?.tokenDetail?.token,
        userProfileBody,
      );

      if (response.statusCode == 200) {
        await storage.write('userData', jsonEncode(response.toJson()));
        loginResponse.value = response;

        // ✅ Important: Reflect updated username in UI
        publicProfileUrl.value = response.data?.username ?? '';
        profileUrlController.text = publicProfileUrl.value;

        // Update reactive loginResponse
        final BottomNavController bottomNav = Get.find<BottomNavController>();
        bottomNav.loginResponse.value = response; // 🔁 this refreshes UI

        ConstantsUtils.showToast('Username updated successfully');
      } else {
        errorMessage.value = response.message ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateExperinceStatus() async {
    try {
      isLoading(true);
      errorMessage.value = '';

      final String selectedExpId = selectedExperienceId.value;

      if (selectedExpId.isEmpty) {
        errorMessage.value = 'No experience selected';
        return;
      }

      final Map<String, dynamic> userProfileBody = {
        "experience": {
          "status": 2,
        },
        "experienceId": selectedExpId, // ✅ use the selected ID
      };

      final response = await repository.updateExperience(
        loginResponse.value?.data?.tokenDetail?.token,
        userProfileBody,
        loginResponse.value?.data?.uniqueId,
      );

      if (response.statusCode == 200) {
        await storage.write('userData', jsonEncode(response.toJson()));
        loginResponse.value = response;
        experiences.value = response.data?.experience ?? [];

        final BottomNavController bottomNav = Get.find<BottomNavController>();
        bottomNav.loginResponse.value = response;

       // ConstantsUtils.showToast('Experience updated successfully');
      } else {
        errorMessage.value = response.message ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }


  // Methods for About section
  Future<void> updateAboutMe() async {
    final aboutMeText = aboutMeController.text.trim();
    if (aboutMeText.isEmpty) {
      Get.snackbar('Error', 'Please enter a About me');
      return;
    }

    try {
      isLoading(true);
      errorMessage.value = '';

      final Map<String, dynamic> userProfileBody = {"aboutMe": aboutMeText};

      final response = await repository.updatePublicProfileRequest(
        loginResponse.value?.data?.tokenDetail?.token,
        userProfileBody,
        loginResponse.value?.data?.uniqueId,
      );

      if (response.statusCode == 200) {
        await storage.write('userData', jsonEncode(response.toJson()));
        loginResponse.value = response;

        // ✅ Important: Reflect updated about in UI
        aboutMe.value = response.data?.aboutMe ?? '';
        aboutMeController.text = aboutMe.value;

        // Update reactive loginResponse
        final BottomNavController bottomNav = Get.find<BottomNavController>();
        bottomNav.loginResponse.value = response; // 🔁 this refreshes UI

        ConstantsUtils.showToast('About updated successfully');
      } else {
        errorMessage.value = response.message ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }

  // Methods for Expertise section
  Future<void> updateExpertise(List<String> selected) async {
    try {
      isLoading(true);
      errorMessage.value = '';

      final Map<String, dynamic> userProfileBody = {
        "functionalExpertise": selected,
      };

      final response = await repository.updatePublicProfileRequest(
        loginResponse.value?.data?.tokenDetail?.token,
        userProfileBody,
        loginResponse.value?.data?.uniqueId,
      );

      if (response.statusCode == 200) {
        await storage.write('userData', jsonEncode(response.toJson()));
        loginResponse.value = response;

        // ✅ Important: Reflect updated about in UI
        if (response.data?.functionalExpertise != null) {
          expertise.value =
              (response.data!.functionalExpertise as List).cast<String>();
        }

        // Update reactive loginResponse
        final BottomNavController bottomNav = Get.find<BottomNavController>();
        bottomNav.loginResponse.value = response; // 🔁 this refreshes UI

        ConstantsUtils.showToast('Expertise updated successfully');
      } else {
        errorMessage.value = response.message ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }

  // Methods for Area of Interest section
  Future<void> updateAreaOfInterest(List<String> selected) async {
    try {
      isLoading(true);
      errorMessage.value = '';

      final Map<String, dynamic> userProfileBody = {
        "areasOfInterest": selected,
      };

      final response = await repository.updatePublicProfileRequest(
        loginResponse.value?.data?.tokenDetail?.token,
        userProfileBody,
        loginResponse.value?.data?.uniqueId,
      );

      if (response.statusCode == 200) {
        await storage.write('userData', jsonEncode(response.toJson()));
        loginResponse.value = response;

        // ✅ Important: Reflect updated about in UI
        if (response.data?.areasOfInterest != null) {
          areaOfInterest.value =
              (response.data!.areasOfInterest as List).cast<String>();
        }

        // Update reactive loginResponse
        final BottomNavController bottomNav = Get.find<BottomNavController>();
        bottomNav.loginResponse.value = response; // 🔁 this refreshes UI

        ConstantsUtils.showToast('Areas Of Interest updated successfully');
      } else {
        errorMessage.value = response.message ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }

  // Methods for Honors and Awards section
  Future<void> addOrUpdateHonorsAndAwards({
    String? awardId,
    required BuildContext bottomSheetContext,
  }) async {
    try {
      isLoading(true);
      errorMessage.value = '';

      final Map<String, dynamic> userProfileBody = {
        "achievement": {
          "awardTitle": awardTitleController.text.trim(),
          "awardIssuedBy": awardIssuedBy.text.trim(),
          "awardDescription": awardDescription.text.trim(),
        },
        if (awardId != null) "achievementId": awardId,
      };

      final response = await repository.updateHonorsAndAwards(
        loginResponse.value?.data?.tokenDetail?.token,
        userProfileBody,
        loginResponse.value?.data?.uniqueId,
      );

      if (response.statusCode == 200) {
        await storage.write('userData', jsonEncode(response.toJson()));
        loginResponse.value = response;
        honorsAwards.value = response.data?.achievements ?? [];

        // Clear fields
        awardTitleController.clear();
        awardIssuedBy.clear();
        awardDescription.clear();

        final BottomNavController bottomNav = Get.find<BottomNavController>();
        bottomNav.loginResponse.value = response;

        Navigator.pop(bottomSheetContext);

        ConstantsUtils.showToast('Honors and Awards updated successfully');
      } else {
        errorMessage.value = response.message ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }

  // Method to delete an honor or award
  Future<void> deleteHonorsAndAwards(String? awardId) async {
    try {
      isLoading(true);
      errorMessage.value = '';

      final response = await repository.deleteHonorsAndAwards(
        loginResponse.value?.data!.uniqueId,
        awardId,
        loginResponse.value?.data?.tokenDetail?.token,
      );

      if (response['status'] == 'success' && response['data'] != null) {
        honorsAwards.removeWhere((request) => request.id == awardId);
        ConstantsUtils.showToast('Honors and Awards delete successfully');
      } else {
        errorMessage.value = response['message'] ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }

  // Methods for Experience section
  Future<void> addOrUpdateExperince({
    String? expId,
    required BuildContext bottomSheetContext,
    required int status,
    Experience? editItem, // Pass existing item if editing
  })
  async {
    try {
      isLoading(true);
      errorMessage.value = '';

      final isEditing = expId != null;

      // Determine if the user is currently working
      final isChecked = status == 1 || status == 2;

      // Parse and convert dates to milliseconds
      final startMillis = ConstantsUtils.convertDobToTimestamp(
        startDateController.text.trim(),
      );
      final endMillis =
          isChecked
              ? 0
              : ConstantsUtils.convertDobToTimestamp(
                endDateController.text.trim(),
              );

      // Determine the final status
      int finalStatus;
      if (isEditing && isChecked && (editItem?.status == 2)) {
        finalStatus = 2; // Preserve status == 2 from backend
      } else {
        finalStatus =
            isChecked ? 1 : 0; // 1 = currently working, 0 = not working
      }

      // Create request payload
      final Map<String, dynamic> userProfileBody = {
        "experience": {
          "company": companyController.text.trim(),
          "experienceEndDate": endMillis,
          "experienceStartDate": startMillis,
          "logoUrl": '',
          "role": roleController.text.trim(),
          "status": finalStatus,
        },
        if (expId != null) "experienceId": expId,
      };

      // Send update request
      final response = await repository.updateExperience(
        loginResponse.value?.data?.tokenDetail?.token,
        userProfileBody,
        loginResponse.value?.data?.uniqueId,
      );

      if (response.statusCode == 200) {
        await storage.write('userData', jsonEncode(response.toJson()));
        loginResponse.value = response;
        experiences.value = response.data?.experience ?? [];

        // Clear input fields
        roleController.clear();
        companyController.clear();
        startDateController.clear();
        endDateController.clear();

        // Update main bottom nav controller
        final BottomNavController bottomNav = Get.find<BottomNavController>();
        bottomNav.loginResponse.value = response;

        // Close bottom sheet
        Navigator.pop(bottomSheetContext);

        ConstantsUtils.showToast('Experience updated successfully');
      } else {
        errorMessage.value = response.message ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }

  // Method to delete an honor or award
  Future<void> deleteExperince(String expId) async {
    try {
      isLoading(true);
      errorMessage.value = '';

      final response = await repository.deleteExperience(
        loginResponse.value?.data!.uniqueId,
        expId,
        loginResponse.value?.data?.tokenDetail?.token,
      );

      if (response['status'] == 'success' && response['data'] != null) {
        experiences.removeWhere((request) => request.id == expId);
        ConstantsUtils.showToast('Experience delete successfully');
      } else {
        errorMessage.value = response['message'] ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }

  // fetch cities based on keyword
  Future<List<String>> fetchCities(String? keyword) async {
    if (!connectivityService.isConnected.value) {
      errorMessage.value = 'No internet connection';
      return [];
    }

    if (keyword == null || keyword.trim().isEmpty) {
      return [];
    }

    try {
      // isLoading(true);
      errorMessage.value = '';

      print('Fetching cities for keyword: $keyword');

      final cities = await repository.fetchCities(keyword);

      // Assuming the API returns a list of city objects with a 'name' field
      // Adjust based on your actual API response structure
      List<String> cityNames =
          cities.map((city) {
            final cityName = city.name ?? '';
            final state = city.stateName ?? '';
            final country = city.countryName ?? '';
            return [
              cityName,
              state,
              country,
            ].where((s) => s.isNotEmpty).join(', ');
          }).toList();

      print('Fetched cities: $cityNames');
      return cityNames;
    } catch (e) {
      print('City fetch error: $e');
      errorMessage.value = await ErrorHandler.handleError(e);
      return [];
    } finally {
      // isLoading(false);
    }
  }

  void clearExperienceControllers() {
    roleController.clear();
    companyController.clear();
    startDateController.clear();
    endDateController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    profileUrlController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    companyRoleController.dispose();
    currentRoleController.dispose();
    currentCompanyController.dispose();
    startDateController.dispose();
    locationController.dispose();
    linkedinController.dispose();
    twitterController.dispose();
    facebookController.dispose();
    aboutMeController.dispose();
    roleController.dispose();
    companyController.dispose();
    endDateController.dispose();
    awardDescription.dispose();
    awardTitleController.dispose();
    awardIssuedBy.dispose();
  }
}
