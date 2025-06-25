import 'package:flutter/material.dart';

class ManageAccountScreen extends StatefulWidget {
  @override
  _ManageAccountScreenState createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  int? _selectedOption; // Tracks the selected radio button

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introductory text
            Text(
              'If you want to take a break from TALGiving, you can deactivate your account.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 8),
            Text(
              'If you want to permanently delete your account, let us know.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            SizedBox(height: 16),

            // Deactivate My Account Box
            _buildBoxView(
              label: 'Deactivate My Account',
              description:
              'Deactivating your account can be temporary. Your profile will be disabled, and your name and photos will be removed from the things you have shared. You have the option to reactivate by simply signing in again.',
              value: 1,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
            SizedBox(height: 16),

            // Delete My Account Box
            _buildBoxView(
              label: 'Delete My Account',
              description:
              'When you delete your TALGiving account, you won\'t be able to retrieve the content or information you have shared. You can recover your data by signing up again using the same email address, but you will need to reverify your email address.',
              value: 2,
              groupValue: _selectedOption,
              onChanged: (value) {
                setState(() {
                  _selectedOption = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBoxView({
    required String label,
    required String description,
    required int value,
    required int? groupValue,
    required ValueChanged<int?>? onChanged,
  }) {
    final isSelected = value == groupValue;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: isSelected ? Colors.red : Colors.grey,
          width: isSelected ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
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
              Radio<int?>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: Colors.red,
                fillColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.selected)) {
                      return Colors.red;
                    }
                    return Colors.grey;
                  },
                ),
              ),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 48), // Aligns with radio button
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
