import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';

import '../payload/login_payload.dart';
import '../service/api_service.dart';
import '../utilites/error_handler.dart';

class LoginController extends GetxController {
  final storage = GetStorage();

  // Text controllers for email and password
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // Observable for managing loading state
  var isLoading = false.obs;

  // Instance of ApiService
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    // Set default text when initializing
    emailController.text = "chandralekha@touchalife.org";
    passwordController.text = "Youknowbts@7";
  }

  // Method to handle login API call
  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Email and password are required.');
      return;
    }

    final payload = LoginPayload(
      account: email,
      password: password,
      rememberMe: true,
      sourceOfLogin: 'talleaders',
    );

    try {
      isLoading(true);

      // Call the API login method
      await _apiService.login(payload);

      // On success, save login status
      storage.write('isLoggedIn', true);

      Get.snackbar('Success', 'Login successful!');
      Get.offNamed('/home');
    } catch (e) {
      // Use the updated error handler
      String errorMessage = await ErrorHandler.handleError(e);
      print('DioException caught: $errorMessage');
      Get.snackbar('Error', errorMessage);  // Show the error message
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
