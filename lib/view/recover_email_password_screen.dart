import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../env/app_env.dart';
import '../utilites/colors.dart';
import '../utilites/constants_Utils.dart';
import '../view_model/login_controller.dart';

class RecoverEmailPasswordScreen extends StatelessWidget {
  const RecoverEmailPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    final args = Get.arguments as Map<String, dynamic>?;
    final title = args != null && args.containsKey('title') ? args['title'] : 'Recover';

    // determine subtitle
    final String subtitle = title == "Recover Email"
        ? "Enter your registered email (provided during the registration process) and click Continue to recover your TALLeaders email id."
        : "Enter your touchalife email id and we will send you the instructions to reset your password.";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: Get.back,
              ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                subtitle,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 40),

            // Email Field
            TextField(
             // controller: controller.emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: const OutlineInputBorder(),
                suffix: title == "Recover Email"
                    ? null
                    : Text(
                  controller.domain,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Button
            Obx(() {
              final buttonTitle = title == "Recover Email"
                  ? "Continue"
                  : "Request Password Reset";

              return ElevatedButton(
                onPressed: controller.isLoading.value ? null : controller.login,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                  buttonTitle,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }),

          ],
        ),
      ),
    );
  }
}
