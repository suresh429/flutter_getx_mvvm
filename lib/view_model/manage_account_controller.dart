import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/model/AreaOption.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../env/app_env.dart';
import '../model/LoginModel.dart';
import '../model/achievement.dart';
import '../model/experience_model.dart';
import '../service/ConnectivityService.dart';
import '../service/main_repository.dart';
import '../utilites/constants_Utils.dart';
import '../utilites/error_handler.dart';
import 'bottom_nav_controller.dart';

class ManageAccountController extends GetxController {
  final storage = GetStorage();
  Rx<LoginModel?> loginResponse = Rx<LoginModel?>(null,); // Initialize with a default value
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  final MainRepository repository = MainRepository(); // API service instance
  final ConnectivityService connectivityService = Get.find<ConnectivityService>(); // Connectivity service instance


  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> disbandFormKey = GlobalKey<FormState>();


  // Initialize with some mock data
  @override
  void onInit() {
    super.onInit();
    initializeController();
  }


  // initialize
  Future<void> initializeController() async {
    final response = await ConstantsUtils.getStoredLoginResponse();
    if (response != null) {
      loginResponse.value = response; // ✅ CORRECT WAY
    } else {
      errorMessage.value = 'Failed to load login response';
    }
  }


  Future<void> changePassword() async {

    try {
      isLoading(true);
      errorMessage.value = '';


      // Build the request body
      final Map<String, dynamic> changePasswordBody = {
        "accessToken": loginResponse.value?.data?.tokenDetail?.token,
        "currentPassword": currentPasswordController.text.trim(),
        "newPassword": newPasswordController.text.trim(),
        "userId": loginResponse.value?.data?.uniqueId,
      };


      final response = await repository.changePassword(
        loginResponse.value?.data?.tokenDetail?.token,
        changePasswordBody,
      );

      if (response.statusCode == 200) {
        ConstantsUtils.showToast('Password Changed successfully');
        // ✅ Clear local storage (logout user)
        await storage.erase();
       // loginResponse.value = null;

        // ✅ Clear password fields
        currentPasswordController.clear();
        newPasswordController.clear();
        confirmPasswordController.clear();

        // ✅ Navigate to login screen (replace with your route name or LoginScreen)
        Get.offAllNamed('/login');


      } else {
        errorMessage.value = response.message ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }

  Future<void> disbandUser(String type) async {

    try {
      isLoading(true);
      errorMessage.value = '';


      // Build the request body
      final Map<String, dynamic> requestBody = {
        "password": currentPasswordController.text.trim(),
        "type": type,
        "userId": loginResponse.value?.data?.uniqueId,
      };


      final response = await repository.disbandUser(
        loginResponse.value?.data?.tokenDetail?.token,
        requestBody,
      );

      if (response.statusCode == 200) {
        ConstantsUtils.showToast('Account has been $type  successfully');
        // ✅ Clear local storage (logout user)
        await storage.erase();
        // loginResponse.value = null;

        // ✅ Clear password fields
        passwordController.clear();

        // ✅ Navigate to login screen (replace with your route name or LoginScreen)
        Get.offAllNamed('/login');


      } else {
        errorMessage.value = response.message ?? 'Update failed';
      }
    } catch (e) {
      errorMessage.value = await ErrorHandler.handleError(e);
    } finally {
      isLoading(false);
    }
  }




  @override
  void dispose() {
    super.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
  }
}
