import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import '../payload/login_payload.dart';
import '../service/api_service.dart';
import '../utilites/constants_Utils.dart';

//login screen
class LoginController extends GetxController {
  final storage = GetStorage();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    emailController.text = "chandralekha@touchalife.org";
    passwordController.text = "Youknowbts@7";
  }

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      ConstantsUtils.showErrorSnackbar('Email and password are required.');
      return;
    }

    final payload = LoginPayload(
      account: email,
      password: password,
      rememberMe: true,
      sourceOfLogin: 'talleaders',
    );

    try {
      if (isLoading.value) return;

      isLoading(true);

      final loginResponse = await _apiService.login(payload);

      if (loginResponse.status == 'success' && loginResponse.data != null) {

        await storage.write('isLoggedIn', true ?? false);
        // Save the entire login response to storage
        await storage.write('userData', jsonEncode(loginResponse.toJson()));
        ConstantsUtils.showSuccessSnackbar('Login successful!');
        Get.offNamed('/home');
      } else {
        throw Exception("Login data is missing or invalid");
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

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
