import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilites/colors.dart';
import '../view_model/login_controller.dart';

class EmailOtpVerifyScreen extends StatelessWidget {
  const EmailOtpVerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find();
    final args = Get.arguments as Map<String, dynamic>?;
    final email = args != null && args.containsKey('email') ? args['email'] : '';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Check your Email",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Please enter the verification code we sent to:",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  maskEmail(email),
                  style: const TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: controller.otpController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  decoration: const InputDecoration(
                    labelText: 'Enter OTP',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          controller.sendPasswordResetOtp(email);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: ColorUtils.colorPrimary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: const Text(
                          'Resend OTP',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () => controller.verifyOtp(email),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorUtils.colorPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text('Verify'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  String maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length < 2) return email;
    final local = parts[0];
    final domain = parts[1];
    final masked = local.length > 2 ? "${local.substring(0, 2)}***" : "$local***";
    return "$masked@$domain";
  }
}
