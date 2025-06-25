import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../view_model/manage_account_controller.dart';

class ManageAccountScreen extends StatefulWidget {
  @override
  _ManageAccountScreenState createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  final ManageAccountController controller = Get.put(ManageAccountController());
  int? _selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Account'),
      ),
      body: Form(
        key: controller.disbandFormKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'If you want to take a break from TALLeaders, you can deactivate your account.'
                    'If you want to permanently delete your account, let us know.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),

              // Deactivate My Account Box
              _buildBoxView(
                label: 'Deactivate My Account',
                description:
                'Deactivating your account can be temporary. Your profile will be disabled, and your name and photos will be removed from the things you have shared. You have the option to reactivate by simply signing in again.',
                value: 1,
              ),
              const SizedBox(height: 16),

              // Delete My Account Box
              _buildBoxView(
                label: 'Delete My Account',
                description:
                'When you delete your TALLeaders account, you won\'t be able to retrieve the content or information you have shared. You can recover your data by signing up again using the same email address, but you will need to reverify your email address.',
                value: 2,
              ),
              const SizedBox(height: 24),

              // Password Field
              TextFormField(
                controller: controller.passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    if (controller.disbandFormKey.currentState?.validate() ?? false) {
                      if (_selectedOption == 1) {
                        controller.disbandUser('deactivated');
                      } else if (_selectedOption == 2) {
                        controller.disbandUser('deleted');
                      } else {
                        Get.snackbar('Error', 'Please select an option',
                            backgroundColor: Colors.red.withOpacity(0.7),
                            colorText: Colors.white);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Submit', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBoxView({
    required String label,
    required String description,
    required int value,
  }) {
    final isSelected = value == _selectedOption;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isSelected ? Colors.red : Colors.grey,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Radio<int>(
                value: value,
                groupValue: _selectedOption,
                onChanged: (selected) {
                  setState(() {
                    _selectedOption = selected;
                  });
                },
                activeColor: Colors.red,
              ),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48),
            child: Text(
              description,
              style: const TextStyle(fontSize:12, color: Colors.grey, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
