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

    // subtitle + button text
    final subtitle = title == "Recover Email"
        ? "Enter your registered email (provided during the registration process) and click Continue to recover your TALLeaders email id."
        : "Enter your touchalife email id and we will send you the instructions to reset your password.";

    final buttonTitle = title == "Recover Email"
        ? "Continue"
        : "Request Password Reset";

    // determine if email recovery
    final bool isRecoverEmail = title.toLowerCase().contains('email');

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          // ----------------- ACCOUNT FOUND UI -----------------
          if (controller.isAccountFound.value && controller.userData.value != null) {
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

          // ----------------- DEFAULT INPUT UI -----------------
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

              // Input field
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
                onPressed: controller.isLoading.value ? null : controller.findUserEmail,
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

// util
String maskEmail(String email) {
  final parts = email.split('@');
  if (parts.length < 2) return email;
  final local = parts[0];
  final domain = parts[1];
  final masked = local.length > 2 ? "${local.substring(0, 2)}***" : "$local***";
  return "$masked@$domain";
}
