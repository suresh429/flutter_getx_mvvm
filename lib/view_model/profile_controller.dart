import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../model/LoginModel.dart' hide Name, Address;
import '../service/ConnectivityService.dart';
import '../service/main_repository.dart';
import '../utilites/constants_Utils.dart' show ConstantsUtils;
import '../utilites/error_handler.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  var userId = ''.obs;
  var token = ''.obs;
  var firstName = ''.obs;
  var lastName = ''.obs;
  var dob = ''.obs; // Store as string in 'dd-MMM-yyyy' format
  var username = ''.obs;
  var email = ''.obs;
  var mobile = ''.obs;
  var city = ''.obs;
  var address = ''.obs;
  var profileImageUrl = ''.obs;
  var selectedCountryCode = CountryCode(code: 'IN', dialCode: '+91').obs;
  final RxString gender = 'Female'.obs;
  final List<String> genderOptions = ['Female', 'Male', 'Other'];
  final ImagePicker _picker = ImagePicker();
  var pickedImageFile = Rx<File?>(null);

  Rx<LoginModel?> loginResponse = Rx<LoginModel?>(null);
  final ConnectivityService connectivityService = Get.put(ConnectivityService());
  final storage = GetStorage();
  final MainRepository repository = MainRepository();

  final cityTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initializeController();
    cityTextController.text = city.value;
  }

  // Initialize controller and fetch profile data
  Future<void> initializeController() async {
    loginResponse.value = await ConstantsUtils.getStoredLoginResponse();
    if (loginResponse.value != null) {
      userId.value = loginResponse.value?.data?.uniqueId ?? '';
      token.value = loginResponse.value?.data?.tokenDetail?.token ?? '';
      print('User ID: ${userId.value}');
      await getProfileData(userId.value);
    } else {
      errorMessage.value = 'Failed to load login response';
    }
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

      final profile = await repository.getProfile(uniqueId);
      print('Profile received: ${profile.data.name.firstName}');

      // Update reactive variables with API data
      profileImageUrl.value = profile.data.profileImageUrl?? '';
      firstName.value = profile.data.name.firstName ?? '';
      lastName.value = profile.data.name.lastName ?? '';
      dob.value = DateFormat('dd-MMM-yyyy').format(
          DateTime.fromMillisecondsSinceEpoch(profile.data.dob)
      );
          setGenderFromApi(profile.data.gender);
      username.value = profile.data.username ?? '';
      email.value = profile.data.email ?? '';
      mobile.value = profile.data.phone ?? '';
      city.value = '${profile.data.address.city ?? ''}, ${profile.data.address.state ?? ''}, ${profile.data.address.country ?? ''}';

      // Sync cityTextController with city value
      cityTextController.text = city.value;

      // Extract country code and phone number
      if (profile.data.phone.isNotEmpty) {
        // Default to India (+91) if no country code is found
        String defaultCode = '+91';
        String defaultCountry = 'IN';

        // Try to extract country code (first 2-4 digits after +)
        RegExp regex = RegExp(r'^(\+\d{1,2})(\d+)$');
        Match? match = regex.firstMatch(profile.data.phone);

        if (match != null) {
          String extractedCode = match.group(1)!;
          String extractedNumber = match.group(2)!;

          // Update country code
          selectedCountryCode.value = CountryCode(
            code: defaultCountry, // You might want to map this properly
            dialCode: extractedCode,
          );

          // Update phone number without country code
          mobile.value = extractedNumber;
        } else {
          // If no country code found, assume it's the default
          mobile.value = profile.data.phone!.replaceAll(defaultCode, '');
        }
      } else {
        mobile.value = '';
      }

      print('Profile data loaded successfully');
    } catch (e) {
      print('Profile fetch error: $e');
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
      List<String> cityNames = cities.map((city) {
        final cityName = city.name ?? '';
        final state = city.stateName ?? '';
        final country = city.countryName ?? '';
        return [cityName, state, country].where((s) => s.isNotEmpty).join(', ');
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

  // Set gender from API response
  void setGenderFromApi(String? apiGender) {
    final genderMap = {
      'f': 'Female',
      'm': 'Male',
      'o': 'Other',
    };

    gender.value = genderMap[apiGender?.toLowerCase()] ?? 'Female';

    // Ensure the value exists in genderOptions
    if (!genderOptions.contains(gender.value)) {
      gender.value = genderOptions.first;
    }
  }

  // Handle country code change
  void onCountryChange(CountryCode? code) {
    if (code != null) {
      selectedCountryCode.value = code;
    }
  }


  // update user profile
  Future<void> updateUserProfile() async {
    try {
      isLoading(true);
      errorMessage.value = '';

      final Map<String, dynamic> userProfileBody = {
        "name": {
          "first_name": firstName.value,
          "last_name": lastName.value,
        },
        "email": email.value,
        "username": username.value,
        "phone": '${selectedCountryCode.value.dialCode}${mobile.value.trim()}',
        "dob": DateFormat('dd-MMM-yyyy').parse(dob.value).millisecondsSinceEpoch,
        "gender": gender.value.toLowerCase()[0], // "Female" → "f"
        "imageUrl": profileImageUrl.value,
        "address": {
          "city": ConstantsUtils.extractCity(city.value),
          "state": ConstantsUtils.extractState(city.value),
          "country": ConstantsUtils.extractCountry(city.value),
        }
      };

      final response = await repository.updateProfileRequest(token.value,userId.value, userProfileBody);
      if (response.statusCode == 200) {
        print('Profile updated successfully');
        ConstantsUtils.showToast('Profile updated successfully');
      } else {
        print('Update failed: ${response.message}');
        errorMessage.value = response.message ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }


  // Submit form data
  void submitForm() {
    print({
      'firstName': firstName.value,
      'lastName': lastName.value,
      'dob': dob.value,
      'gender': gender.value,
      'username': username.value,
      'email': email.value,
      'mobile': '${selectedCountryCode.value.dialCode}${mobile.value}',
      'city': city.value,
    });
    // Add logic to submit data to API if needed
    updateUserProfile();
  }

  @override
  void onClose() {
    cityTextController.dispose();
    super.onClose();
  }
}