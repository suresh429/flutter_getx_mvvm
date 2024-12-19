import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_getx_mvvm/payload/user_update_payload.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/AreaOption.dart';
import '../model/CategoryModel.dart';
import '../model/LoginModel.dart';
import '../service/api_service.dart';
import '../utilites/constants_Utils.dart';
import '../utilites/error_handler.dart';

class ManagePreferencesController extends GetxController {
  final storage = GetStorage();

  late LoginModel? loginResponse;
  final isLoading = false.obs;
  var errorMessage = ''.obs;

  final ApiService _apiService = ApiService();

  final categories = <Category>[
    Category(
      title: 'Board Member',
      subtitle:
          'Empower nonprofits to unlock their potential & amplify their impact as a Board Member.',
      image: 'assets/board_member.png',
    ),
    Category(
      title: 'Event Speaker',
      subtitle:
          'Enable nonprofits & individuals to reimagine possibilities & unlock growth as a Mentor.',
      image: 'assets/event_speaker.png',
    ),
    Category(
      title: 'Mentoring',
      subtitle:
          'Share your expertise & knowledge as a thought leader by featuring on nonprofits’ Podcasts.',
      image: 'assets/mentoring.png',
    ),
    Category(
      title: 'Podcast',
      subtitle:
          'Offer invaluable insights as an Event Speaker, inspiring the audience to take social action.',
      image: 'assets/podcast.png',
    ),
  ].obs;

  final areasOfInterest = <AreaOption>[
    AreaOption("No Poverty"),
    AreaOption("Zero Hunger"),
    AreaOption("Good Health and Well-being"),
    AreaOption("Quality Education"),
    AreaOption("Gender Equality"),
    AreaOption("Clean Water and Sanitation"),
    AreaOption("Affordable and Clean Energy"),
    AreaOption("Decent Work and Economic Growth"),
    AreaOption("Industry, Innovation and Infrastructure"),
    AreaOption("Reduced Inequality"),
    AreaOption("Sustainable Cities and Communities"),
    AreaOption("Responsible Consumption and Production"),
    AreaOption("Climate Action"),
    AreaOption("Life Below Water"),
    AreaOption("Life on Land"),
    AreaOption("Peace, Justice and Strong Institutions"),
    AreaOption("Partnership for the Goals"),
  ].obs;

  final languages = ['Any', 'English', 'Hindi', 'Telugu'].obs;

  var selectedCategoriesIndices = <int>[].obs;
  var selectedLanguages = <String>[].obs;
  var selectedAreasOfInterest = <AreaOption>[].obs;

  bool get isPodcastSelected => selectedCategoriesIndices
      .any((index) => categories[index].title == "Podcast");

  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }

  void _initializeController() async {
    loginResponse = await ConstantsUtils.getStoredLoginResponse();
    if (loginResponse?.data?.uniqueId != null) {
      // Proceed with fetching profile data only if uniqueId is available
      await getProfileData(loginResponse?.data?.uniqueId);
    }
  }

  // set categories
  void setInitialAppCategories(List<String> talLeaderPreferences) {
    final storedCategories = talLeaderPreferences ?? [];
    // Clear previously selected indices before assigning new ones
    selectedCategoriesIndices.clear();

    // Find the indices of selected categories and assign them to selectedCategoriesIndices
    selectedCategoriesIndices.assignAll(
      categories
          .asMap() // Convert the list to a map of index-value pairs
          .entries
          .where((entry) {
            // Perform case-insensitive comparison
            bool isMatch = storedCategories.any((storedCategory) =>
                storedCategory.toLowerCase() ==
                entry.value.title.toLowerCase());
            return isMatch;
          }) // Filter categories based on titles
          .map((entry) => entry.key) // Get the index (key)
          .toList(),
    );
  }

  // set languages
  void setInitialLanguages(List<String> languagePreferences) {
    final storedLanguages = languagePreferences ?? [];

    // Clear previously selected languages before assigning new ones
    selectedLanguages.clear();

    // Find the selected languages and assign them to selectedLanguages
    selectedLanguages.addAll(
      languages.where((language) {
        // Check if the language exists in the stored preferences (case-insensitive)
        bool isMatch = storedLanguages.any((storedLanguage) =>
            storedLanguage.toLowerCase() == language.toLowerCase());
        return isMatch;
      }).toList(),
    );
  }

  // set Areas
  void setInitialAreasOfInterest(List<String>? areasOfInterests) {
    final storedAreas = areasOfInterests ?? [];
    selectedAreasOfInterest.assignAll(
      areasOfInterest.where((area) => storedAreas.contains(area.name)).toList(),
    );
  }

  void toggleCategorySelection(int index) {
    if (selectedCategoriesIndices.contains(index)) {
      selectedCategoriesIndices.remove(index);
    } else {
      selectedCategoriesIndices.add(index);
    }
  }

  void toggleLanguageSelection(String language) {
    if (selectedLanguages.contains(language)) {
      selectedLanguages.remove(language);
    } else {
      selectedLanguages.add(language);
    }
  }

  void toggleAreaSelection(AreaOption area) {
    if (selectedAreasOfInterest.contains(area)) {
      selectedAreasOfInterest.remove(area);
    } else {
      selectedAreasOfInterest.add(area);
    }
  }

  // update preferences
  Future<void> updateUserPreferences(List<String> selectedCategoryNames,
      List<String> selectedLanguageNames, List<String> selectedAreas) async {
    final payload = UserUpdatePayload(
      areasOfInterest: selectedAreas,
      languagePreferences: selectedLanguageNames,
      talLeaderPreferences: selectedCategoryNames,
    );

    try {
      if (isLoading.value) return;

      isLoading(true);

      final dataResponse = await _apiService.managePreferencesRequest(
          loginResponse?.data?.tokenDetail?.token,
          loginResponse?.data?.uniqueId,
          payload);

      if (dataResponse.status == 'success' && dataResponse.data != null) {
        // Save the entire login response to storage
        await storage.write('userData', jsonEncode(dataResponse.toJson()));
        ConstantsUtils.showSuccessSnackbar(dataResponse.message);
      } else {
        throw Exception("data is missing or invalid");
      }
    } catch (e) {
      String errorMessage;
      if (e is ErrorHandler) {
        errorMessage = e.toString();
      } else {
        errorMessage = e.toString();
      }
      ConstantsUtils.showErrorSnackbar(errorMessage);
    } finally {
      isLoading(false);
    }
  }

  // get profile
  Future<void> getProfileData(String? uniqueId) async {
    // Check connectivity before making API request
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      errorMessage.value =
          'No internet connection. Please check your network settings.';
      return; // Skip API call if no internet
    }

    try {
      isLoading(true);
      errorMessage.value = ''; // Reset previous errors

      // Fetch profile data from the API
      final getProfile = await _apiService.getProfile(uniqueId);

      setInitialAppCategories(getProfile.data.talLeaderPreferences);
      setInitialLanguages(getProfile.data.languagePreferences);
      setInitialAreasOfInterest(getProfile.data.areasOfInterest);

      // Example storage operation
      // await storage.write('userData', jsonEncode(getProfile.toJson()));
    } catch (e) {
      // Use the updated error handler
      String errorMsg = await ErrorHandler.handleError(e);
      errorMessage.value = errorMsg;
    } finally {
      isLoading(false);
    }
  }
}
