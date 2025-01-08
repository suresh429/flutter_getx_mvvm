import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Password Text Field (always visible)
            _buildPasswordField(
              controller: _currentPasswordController,
              label: 'Current Password',
              isPasswordVisible: true, // Always visible
              onVisibilityChanged: (value) {
                // No need for visibility toggle here
              },
            ),
            SizedBox(height: 16),
            _buildPasswordField(
              controller: _newPasswordController,
              label: 'New Password',
              isPasswordVisible: _isNewPasswordVisible,
              onVisibilityChanged: (value) {
                setState(() {
                  _isNewPasswordVisible = value;
                });
              },
            ),
            SizedBox(height: 16),
            _buildPasswordField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              isPasswordVisible: _isConfirmPasswordVisible,
              onVisibilityChanged: (value) {
                setState(() {
                  _isConfirmPasswordVisible = value;
                });
              },
            ),
            SizedBox(height: 32),
            // Submit Button with same width as TextFields
            SizedBox(
              width: double.infinity, // Make the button take up the full width
              child: ElevatedButton(
                onPressed: () {
                  // Handle Submit
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Red background color
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text('Submit', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
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
    return TextField(
      controller: controller,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: label,
        hintText: label,
        suffixIcon: label.contains('Password')
            ? IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            onVisibilityChanged(!isPasswordVisible);
          },
        )
            : null,
      ),
    );
  }
}
