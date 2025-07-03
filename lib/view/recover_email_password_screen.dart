import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilites/colors.dart';
import '../view_model/login_controller.dart';

class RecoverEmailPasswordScreen extends StatelessWidget {
  const RecoverEmailPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.find();
    final args = Get.arguments as Map<String, dynamic>?;
    final title = args != null && args.containsKey('title') ? args['title'] : 'Recover';

    final subtitle = title == "Recover Email"
        ? "Enter your registered email (provided during the registration process) and click Continue to recover your TALLeaders email id."
        : "Enter your touchalife email id and we will send you the instructions to reset your password.";

    final buttonTitle = title == "Recover Email"
        ? "Continue"
        : "Request Password Reset";

    final bool isRecoverEmail = title.toLowerCase().contains('email');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          if (controller.isAccountFound.value && controller.userData.value != null && isRecoverEmail) {
            // ✅ Only show account details if recovering email
            final user = controller.userData.value;
            final maskedEmail = maskEmail(user?.data?.email ?? "");

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    controller.clearFoundState();
                    Get.back();
                  },
                ),
                const SizedBox(height: 10),
                Text("${user?.data?.name?.firstName ?? ''} ${user?.data?.name?.lastName ?? ''}",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(maskedEmail, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => openDialogInbox(maskedEmail),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 45),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  child: const Text("Continue", style: TextStyle(color: Colors.white)),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  controller.clearFoundState();
                  Get.back();
                },
              ),
              const SizedBox(height: 20),
              Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 20),

              TextField(
                controller: controller.recoverEmailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: const OutlineInputBorder(),
                  suffix: isRecoverEmail
                      ? null
                      : Text(controller.domain, style: const TextStyle(color: Colors.grey)),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: controller.isLoading.value ? null : () {
                  if (isRecoverEmail) {
                    _handleRecoverEmail(controller);
                  } else {
                    _handleRecoverPassword(controller);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                ),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(buttonTitle, style: const TextStyle(color: Colors.white)),
              ),
            ],
          );
        }),
      ),
    );
  }

  void _handleRecoverEmail(LoginController controller) async {
    if (controller.recoverEmailController.text.trim().isEmpty) {
      Get.snackbar("Validation", "Please enter email");
      return;
    }
    await controller.findUserEmail();
  }

  void _handleRecoverPassword(LoginController controller) async {
    final input = controller.recoverEmailController.text.trim();
    if (input.isEmpty) {
      Get.snackbar("Validation", "Please enter email");
      return;
    }
    if (input.contains("@")) {
      Get.snackbar("Validation", "Please enter email without domain");
      return;
    }

    final fullEmail = "$input${controller.domain}";
    await controller.sendPasswordResetOtp(fullEmail);
  }

  void openDialogInbox(String maskedEmail) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text("Check your inbox"),
        content: Text("We sent your TALLeader account email to $maskedEmail"),
        actions: [
          TextButton(
            onPressed: () {
              Get.offAllNamed('/login');
            },
            child: const Text("Go to Login"),
          ),
        ],
      ),
    );
  }
}

String maskEmail(String email) {
  final parts = email.split('@');
  if (parts.length < 2) return email;
  final local = parts[0];
  final domain = parts[1];
  final masked = local.length > 2 ? "${local.substring(0, 2)}***" : "$local***";
  return "$masked@$domain";
}
