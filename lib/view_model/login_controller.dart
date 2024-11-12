import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../payload/login_payload.dart';
import '../service/api_service.dart';


class LoginController extends GetxController {

  final storage = GetStorage(); // Access GetStorage

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

    // Basic validation
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

      // Call the login method in ApiService with your specific payload
      await _apiService.login(payload);

      // Assume login is successful and save login status
      storage.write('isLoggedIn', true);

      // If login is successful, navigate to home screen
      Get.snackbar('Success', 'Login successful!');
      Get.offNamed('/home'); // Navigate to home screen
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: ${e.toString()}');
      print("ERROR  :   $e");
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
