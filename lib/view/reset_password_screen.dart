import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilites/colors.dart';
import '../utilites/constants_Utils.dart';
import '../view_model/login_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find();
    final args = Get.arguments as Map<String, dynamic>?;

    final email = args?['email'] ?? "";
    final otp = args?['otp'] ?? "";

    print("Received email: $email, OTP: $otp");

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Reset Password",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Enter a new password below to change your password",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),

                // New Password
                Obx(() => TextField(
                  controller: controller.newPasswordController,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        controller.isPasswordHidden.toggle();
                      },
                    ),
                  ),
                )),
                const SizedBox(height: 15),

                // Re-enter Password
                Obx(() => TextField(
                  controller: controller.reenterPasswordController,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: InputDecoration(
                    labelText: 'Re-Enter Password',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        controller.isPasswordHidden.toggle();
                      },
                    ),
                  ),
                )),

                const SizedBox(height: 20),

                // Submit button
                Obx(() {
                  return ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () => controller.resetPassword(email, otp),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 45),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'Reset Password',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
