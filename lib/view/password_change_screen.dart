import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/manage_account_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ManageAccountController controller = Get.put(ManageAccountController());

  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.passwordFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPasswordField(
                controller: controller.currentPasswordController,
                label: 'Current Password',
                isPasswordVisible: true,
                onVisibilityChanged: (_) {},
              ),
              const SizedBox(height: 16),
              _buildPasswordField(
                controller: controller.newPasswordController,
                label: 'New Password',
                isPasswordVisible: _isNewPasswordVisible,
                onVisibilityChanged: (visible) {
                  setState(() => _isNewPasswordVisible = visible);
                },
              ),
              const SizedBox(height: 16),
              _buildPasswordField(
                controller: controller.confirmPasswordController,
                label: 'Confirm Password',
                isPasswordVisible: _isConfirmPasswordVisible,
                onVisibilityChanged: (visible) {
                  setState(() => _isConfirmPasswordVisible = visible);
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.passwordFormKey.currentState?.validate() ?? false) {
                      controller.changePassword();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text('Submit', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String label,
    required bool isPasswordVisible,
    required Function(bool) onVisibilityChanged,
  }) {
    final ManageAccountController manageController = Get.find<ManageAccountController>();

    return TextFormField(
      controller: controller,
      obscureText: !isPasswordVisible,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }

        if (label == 'New Password') {
          final password = value.trim();
          final passwordRegex = RegExp(
              r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');

          if (!passwordRegex.hasMatch(password)) {
            return 'Password must be 8+ characters, include\nuppercase, lowercase, number, and symbol';
          }
        }

        if (label == 'Confirm Password' &&
            value.trim() != manageController.newPasswordController.text.trim()) {
          return 'Passwords do not match';
        }

        return null;
      },

      decoration: InputDecoration(
        labelText: label,
        hintText: label,
        border: const OutlineInputBorder(),
        suffixIcon: label.contains('Password')
            ? IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () => onVisibilityChanged(!isPasswordVisible),
        )
            : null,
      ),
    );
  }
}
