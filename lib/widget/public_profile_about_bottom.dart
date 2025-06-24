import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/view_model/public_profile_controller.dart';

class PublicProfileAboutBottom extends StatelessWidget {
  final PublicProfileController controller;
  final BuildContext bottomSheetContext;

  const PublicProfileAboutBottom({
    Key? key,
    required this.controller,
    required this.bottomSheetContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: 40.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          // Close button
          // Header Row with Close Button and Title
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'About',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                InkWell(
                  onTap: () => Navigator.pop(bottomSheetContext),
                  child: const Icon(
                    Icons.close,
                    size: 24.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          // Scrollable content
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Multi-line Description TextField
                _buildTextFieldWithLabel(
                  controller.aboutMeController,
                  label: 'Description',
                  maxLines: null,
                ),
                const SizedBox(height: 16),
                // Save Button
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
                      // Example action: Save description and close
                      controller.updateAboutMe();
                      Navigator.pop(bottomSheetContext);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16), // Extra space at bottom
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextFieldWithLabel(TextEditingController controller, {
    required String label,
    int? maxLines,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines ?? null, // allow unlimited lines
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: 12),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}
