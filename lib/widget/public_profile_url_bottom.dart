import 'package:flutter/material.dart';
import 'package:TALLeaders/view_model/public_profile_controller.dart'
    hide PublicProfileController;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:TALLeaders/view_model/public_profile_controller.dart';

import '../env/app_env.dart';

class PublicProfileUrlBottom extends StatelessWidget {
  final PublicProfileController controller;

  const PublicProfileUrlBottom({Key? key, required this.controller})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Label and Close Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Update Public Profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Username Input with Prefix
            Row(
              children: [
                Text(
                  "${AppEnvironment.baseWebUrl}public-profile/",
                  style: const TextStyle(fontSize:10, color: Colors.black),
                ),
                Expanded(
                  child: TextField(
                    controller: controller.profileUrlController,
                    style: const TextStyle(fontSize: 10),
                    maxLines: 1, // For single-line input
                    decoration: const InputDecoration(
                      isDense: true, // Reduces height
                      hintText: 'User Name',
                      hintStyle: TextStyle(fontSize: 10),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                      floatingLabelBehavior: FloatingLabelBehavior.never, // Prevents floating
                    ),
                  ),
                ),

              ],
            ),
            const SizedBox(height: 16),
            // Note Section
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Note: Your custom URL must contain 3-100 letters or numbers. Please do not use spaces, symbols, or special characters.',
                    style: TextStyle(fontSize: 12, color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '* Once edited cannot change until the next 30 days',
                    style: TextStyle(fontSize: 12, color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Update Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  controller.updateUserProfileUrl();
                  Navigator.pop(context);
                },
                child: const Text(
                  'Update',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
