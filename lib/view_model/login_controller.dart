import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';
import '../payload/login_payload.dart';
import '../service/main_repository.dart';
import '../utilites/constants_Utils.dart';
import '../utilites/error_handler.dart';

class LoginController extends GetxController {
  final storage = GetStorage();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  final MainRepository repository = MainRepository();

  @override
  void onInit() {
    super.onInit();
    emailController.text = "chandralekha@touchalife.org";
    passwordController.text = "Saybts@7";
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

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

      final loginResponse = await repository.login(payload);
      if (loginResponse.status == 'success' && loginResponse.data != null) {
        await storage.write('isLoggedIn', true);
        await storage.write('userData', jsonEncode(loginResponse.toJson()));
        ConstantsUtils.showSuccessSnackbar('Login successful!');
        Get.offNamed('/home');
      } else {
        ConstantsUtils.showErrorSnackbar("Login failed: Invalid response.");
      }
    } on DioException catch (dioError) {
      final statusCode = dioError.response?.statusCode;
      final responseData = dioError.response?.data;

      print('Login failed with status $statusCode');
      print('Response data: $responseData');

      if (statusCode == 500) {
        ConstantsUtils.showErrorSnackbar("Server error. Please try again later.");
      } else if (statusCode != null) {
        final message = (responseData != null && responseData['message'] != null)
            ? responseData['message']
            : "An error occurred";
        ConstantsUtils.showErrorSnackbar(message);
      } else {
        ConstantsUtils.showErrorSnackbar("Unexpected network error");
      }
    } catch (e) {
      String errorMsg = await ErrorHandler.handleError(e);
      ConstantsUtils.showErrorSnackbar(errorMsg);
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
