import 'package:flutter/material.dart';

import '../model/LoginModel.dart';
import '../model/achievement.dart';
import '../view_model/public_profile_controller.dart';

class PublicProfileHonorBottom extends StatelessWidget {
  final PublicProfileController controller;
  final BuildContext bottomSheetContext;
  final Achievement? editItem;
  final int? editIndex;

  const PublicProfileHonorBottom({
    Key? key,
    required this.controller,
    required this.bottomSheetContext,
    this.editItem,
    this.editIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Prepopulate if editing
    if (editItem != null) {
      controller.awardTitleController.text = editItem!.awardTitle ?? '';
      controller.awardIssuedBy.text = editItem!.awardIssuedBy ?? '';
      controller.awardDescription.text = editItem!.awardDescription ?? '';
    }

    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        child: Form(
          key: controller.honorFormKey,
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

              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      editItem != null ? 'Edit Honor & Award' : 'Add Honor & Award',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(bottomSheetContext),
                      child: const Icon(Icons.close, size: 24.0, color: Colors.black),
                    ),
                  ],
                ),
              ),

              // Form fields
              SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildValidatedTextField(
                      controller.awardTitleController,
                      'Award title',
                    ),
                    const SizedBox(height: 16),
                    _buildValidatedTextField(
                      controller.awardIssuedBy,
                      'Issued by',
                    ),
                    const SizedBox(height: 12),
                    _buildValidatedTextField(
                      controller.awardDescription,
                      'Description',
                    ),
                    const SizedBox(height: 16),

                    // Submit Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (controller.honorFormKey.currentState?.validate() ?? false) {
                            controller.addOrUpdateHonorsAndAwards(
                              awardId: editItem?.id,
                              bottomSheetContext: bottomSheetContext,
                            );
                          }
                        },
                        child: Text(
                          editItem != null ? 'Update' : 'Add',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    // 🗑️ Delete Button when editing
                    if (editItem != null) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          label: const Text("Delete", style: TextStyle(color: Colors.red)),
                          onPressed: () {
                            controller.deleteHonorsAndAwards(editItem!.id);
                            Navigator.pop(bottomSheetContext);
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildValidatedTextField(TextEditingController textController, String hintText) {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }
}
