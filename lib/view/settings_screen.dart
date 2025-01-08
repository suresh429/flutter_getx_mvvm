import 'package:flutter/material.dart';

import 'manage_account_screen.dart';
import 'password_change_screen.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Change Password'),
            onTap: () {
              // Navigate to Change Password Screen using Get
              Get.to(() => ChangePasswordScreen());
            },
          ),
          ListTile(
            title: Text('Manage Account'),
            onTap: () {
              // Navigate to Manage Account Screen using Get
              Get.to(() => ManageAccountScreen());
            },
          ),
        ],
      ),
    );
  }
}
