import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';

import '../payload/login_payload.dart';
import '../service/main_repository.dart';
import '../utilites/constants_Utils.dart';
import '../utilites/error_handler.dart';
import '../model/LoginModel.dart';

class LoginController extends GetxController {
  var domain = '@touchalife.org';
  final storage = GetStorage();


  final newPasswordController = TextEditingController();
  final reenterPasswordController = TextEditingController();
  final otpController = TextEditingController();
  final recoverEmailController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
   var isPasswordHidden = true.obs;

  var isAccountFound = false.obs;
  var userData = Rxn<LoginModel>();

  var isLoading = false.obs;
  final MainRepository repository = MainRepository();

  @override
  void onInit() {
    super.onInit();

    // Pre-fill for testing (optional)
    emailController.text = "chandralekha";
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
      account: '$email$domain',
      password: password,
      rememberMe: true,
      sourceOfLogin: 'talleaders',
    );

    try {
      if (isLoading.value) return;

      isLoading(true);
      final loginResponse = await repository.login(payload);

      if (loginResponse.status == 'success' && loginResponse.data != null) {
        // ✅ Defensive: ensure token is not null
        final token = loginResponse.data?.tokenDetail?.token;
        final userId = loginResponse.data?.uniqueId;

        if (token == null || userId == null) {
          ConstantsUtils.showErrorSnackbar('Login response is incomplete.');
          return;
        }

        // ✅ Store and navigate
        await storage.write('isLoggedIn', true);
        await storage.write('userData', jsonEncode(loginResponse.toJson()));
        ConstantsUtils.showSuccessSnackbar('Login successful!');
        Get.offNamed('/main');
      } else {
        ConstantsUtils.showErrorSnackbar("Login failed: Invalid response.");
      }
    } on DioException catch (dioError) {
      final statusCode = dioError.response?.statusCode;
      final responseData = dioError.response?.data;

      debugPrint('Login failed with status $statusCode');
      debugPrint('Response data: $responseData');

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
    } catch (e, stack) {
      debugPrint('Unexpected login error: $e\n$stack');
      String errorMsg = await ErrorHandler.handleError(e);
      ConstantsUtils.showErrorSnackbar(errorMsg);
    } finally {
      isLoading(false);
    }
  }

  Future<void> findUserEmail() async {
    if (recoverEmailController.text.trim().isEmpty) {
      Get.snackbar("Validation", "Please enter email");
      return;
    }
    try {
      isLoading.value = true;
      final email = recoverEmailController.text.trim();

      // 🔥 Directly get parsed LoginModel
      final response = await repository.findUserEmail(email);

      if (response.status == "success" && response.data != null) {
        userData.value = response;
        isAccountFound.value = true;
      } else {
        Get.snackbar("Error", response.message ?? "No account found with this email");
        isAccountFound.value = false;
      }


    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }


  Future<void> sendPasswordResetOtp(String fullEmail) async {
    try {
      isLoading.value = true;

      final body = {
        "email": fullEmail,
        "sourceOfSignup": "talleaders"
      };

      print("Sending password reset with payload: $body");

      final result = await repository.sendPasswordResetOtp(body);

      if (result.status == "success") {
        Get.snackbar("Success", "OTP sent to $fullEmail");
        // Navigate to OTP screen if you want
         Get.toNamed('/verifyOtp', arguments: {'email': fullEmail});
      } else {
        Get.snackbar("Error", result.message ?? "Failed to send reset OTP");
      }
    } catch (e) {
      print("sendPasswordReset error: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> verifyOtp(String fullEmail) async {
    if (otpController.text.trim().isEmpty) {
      Get.snackbar("Validation", "Please enter OTP");
      return;
    }

    final payload = {
      "email": fullEmail,
      "otp": otpController.text.trim(),
      "phone": null
    };

    print("Verifying OTP with payload: $payload");

    try {
      isLoading.value = true;
      final result = await repository.verifyOtp(payload);

      if (result.statusCode==200) {
        Get.snackbar("Success", result.message ?? "OTP verified");
        // ✅ Navigate to reset password screen or home
        print("Navigating to reset password screen");
        Get.toNamed('/resetPassword', arguments: {"email": fullEmail, "otp": otpController.text.trim()});
      } else {
        Get.snackbar("Error", result.message ?? "Invalid OTP. Please try again.");
      }
    } catch (e) {
      print("verifyOtp error: $e");
      Get.snackbar("Error", "Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> resetPassword(String email, String otp) async {
    final newPassword = newPasswordController.text.trim();
    final rePassword = reenterPasswordController.text.trim();

    // 🔥 Kotlin-like validation
    if (newPassword.isEmpty) {
      Get.snackbar("Validation", "Please enter new password");
      return;
    }
    if (newPassword.length < 8) {
      Get.snackbar("Validation", "Please enter minimum 8 characters password");
      return;
    }
    if (!validatePassword(newPassword)) {
      Get.snackbar("Validation", "The password does not meet all the requirements");
      return;
    }
    if (rePassword.isEmpty) {
      Get.snackbar("Validation", "Please re-enter your password");
      return;
    }
    if (newPassword != rePassword) {
      Get.snackbar("Validation", "Password didn't match");
      return;
    }

    // 🔥 Prepare request payload
    final body = {
      "email": email,
      "otp": otp,
      "password": newPassword
    };

    try {
      isLoading.value = true;

      print("Sending reset password payload: $body");
      final result = await repository.resetPassword(body);

      if (result.status?.toLowerCase() == "success") {
        Get.snackbar("Success", result.message ?? "Password Changed Successfully");
        // ✅ unfocus keyboard so TextField stops using controller
        FocusManager.instance.primaryFocus?.unfocus();

        // ✅ small delay to let Flutter detach widgets
        await Future.delayed(const Duration(milliseconds: 150));

        Get.offAllNamed('/login');
      } else {
        Get.snackbar("Error", result.message ?? "Failed to change password");
      }
    } catch (e) {
      print("resetPassword error: $e");
      Get.snackbar("Error", "Something went wrong: ${e.toString()}");
    } finally {
      isLoading.value = false;
    }
  }

  bool validatePassword(String password) {
    // replicates your validate1() in Kotlin
    final pattern = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*#?&]{8,}$');
    return pattern.hasMatch(password);
  }


  void clearFoundState() {
    isAccountFound.value = false;
    userData.value = null;
    recoverEmailController.clear();
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    reenterPasswordController.dispose();
    otpController.dispose();
    recoverEmailController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
