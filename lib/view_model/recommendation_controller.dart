import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_getx_mvvm/payload/like_unlike_payload.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/ExploreModel.dart';
import '../model/LoginModel.dart';
import '../payload/invite_payload.dart';
import '../service/api_service.dart';
import '../utilites/constants_Utils.dart';
import '../utilites/error_handler.dart';

class RecommendationController extends GetxController {
  final recommendations = <ExploreModel>[].obs;
  final isLoading = false.obs;
  var errorMessage = ''.obs;
  late String requestType='';
  late String requestLanguage='';

  final ApiService _apiService = ApiService();
  final Connectivity _connectivity = Connectivity();
  final storage = GetStorage();
  late LoginModel? loginResponse;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  var firstNameError = RxnString();
  var lastNameError = RxnString();
  var emailError = RxnString();

  @override
  Future<void> onInit() async {
    super.onInit();

    initializeController();

  }

  // initialize
  Future<void> initializeController() async {
    loginResponse = await ConstantsUtils.getStoredLoginResponse();
    if (loginResponse?.data?.uniqueId != null) {
      // Proceed with fetching profile data only if uniqueId is available
      await getProfileData(loginResponse?.data?.uniqueId);
    }


    // Fetch data initially
    fetchData(loginResponse?.data?.uniqueId);

    // Listen to connectivity changes
    _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        await fetchData(loginResponse?.data
            ?.uniqueId); // Attempt to fetch data if connection is restored
      } else {
        errorMessage.value =
        'No internet connection. Please check your network settings.';
      }
    });


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

      requestType =  ConstantsUtils.buildRequestTypeData(getProfile.data.talLeaderPreferences);
      requestLanguage = getProfile.data.languagePreferences.join(',') ?? '';

    } catch (e) {
      // Use the updated error handler
      String errorMsg = await ErrorHandler.handleError(e);
      errorMessage.value = errorMsg;
    } finally {
      isLoading(false);
    }
  }


  // validation
  void setErrorMessages(String firstName, String lastName, String email) {
    firstNameError.value = firstName.isEmpty ? 'First Name is required' : null;
    lastNameError.value = lastName.isEmpty ? 'Last Name is required' : null;
    emailError.value = email.isEmpty ? 'Email is required' : null;
  }


  // invite member
  Future<void> inviteMember(BuildContext context) async {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;

    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
      setErrorMessages(firstName, lastName, email);
      return;
    }

    final payload = InvitePayload(
      email: email,
      firstName: firstName,
      lastName: lastName,
    );

    try {
      if (isLoading.value) return;

      isLoading(true);

      final dataResponse = await _apiService.inviteMember(
          payload, loginResponse?.data?.tokenDetail?.token);

      if (dataResponse.status == 'success' && dataResponse.data != null) {
        ConstantsUtils.showSuccessSnackbar(dataResponse.message);
        Navigator.pop(context);
      } else {
        throw Exception("data is missing or invalid");
      }
    } catch (e) {
      String errorMessage;
      if (e is DioException) {
        errorMessage = 'Network error occurred. Please try again later.';
      } else {
        errorMessage = e.toString();
      }
      ConstantsUtils.showErrorSnackbar(errorMessage);
    } finally {
      isLoading(false);
    }
  }


  // Method to fetch data from API
  Future<void> fetchData(String? uniqueId) async {
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

      // Fetch recommendations from the API
      final fetchedRecommendations =
          await _apiService.fetchRecommendations(uniqueId,requestType,requestLanguage);
      recommendations.assignAll(fetchedRecommendations);
    } catch (e) {
      // Use the updated error handler
      String errorMsg = await ErrorHandler.handleError(e);
      errorMessage.value = errorMsg;
    } finally {
      isLoading(false);
    }
  }
}
