import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:TALLeaders/model/LoginModel.dart' hide Experience;
import 'package:TALLeaders/view_model/public_profile_controller.dart';
import '../model/experience_model.dart';

class PublicProfileExperienceBottomSheet extends StatefulWidget {
  final PublicProfileController controller;
  final BuildContext bottomSheetContext;
  final Experience? editItem;

  const PublicProfileExperienceBottomSheet({
    Key? key,
    required this.controller,
    required this.bottomSheetContext,
    this.editItem,
  }) : super(key: key);

  @override
  State<PublicProfileExperienceBottomSheet> createState() =>
      _PublicProfileExperienceBottomSheetState();
}

class _PublicProfileExperienceBottomSheetState
    extends State<PublicProfileExperienceBottomSheet> {
  bool isCurrentlyWorking = false;

  @override
  void initState() {
    super.initState();
    final item = widget.editItem;

    // Always reset picked image
    widget.controller.pickedImageFile.value = null;
    if (item != null) {
      widget.controller.roleController.text = item.role ?? '';
      widget.controller.companyController.text = item.company ?? '';
      isCurrentlyWorking = item.status == 1 || item.status == 2;

      if (item.experienceStartDate != null) {
        widget.controller.startDateController.text = DateFormat(
          'dd-MMM-yyyy',
        ).format(
          DateTime.fromMillisecondsSinceEpoch(item.experienceStartDate!),
        );
      }

      if (!isCurrentlyWorking && item.experienceEndDate != null) {
        widget.controller.endDateController.text = DateFormat(
          'dd-MMM-yyyy',
        ).format(DateTime.fromMillisecondsSinceEpoch(item.experienceEndDate!));
      }
      // Set company logo url for edit
      widget.controller.companyLogoUrl.value = item.logoUrl ?? '';
    } else {
      widget.controller.clearExperienceControllers();
      isCurrentlyWorking = false;
      widget.controller.companyLogoUrl.value = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: widget.controller.experienceFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.editItem != null
                              ? 'Edit Experience'
                              : 'Add Experience',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(widget.bottomSheetContext),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(widget.controller.roleController, 'Role'),
                    const SizedBox(height: 12),
                    _buildTextField(widget.controller.companyController, 'Company'),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          value: isCurrentlyWorking,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (value) {
                            setState(() {
                              isCurrentlyWorking = value ?? false;
                            });
                          },
                        ),
                        const Expanded(
                          child: Text("I am currently working in this role."),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDateField(
                            widget.controller.startDateController,
                            'Start Date',
                            context,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDateField(
                            widget.controller.endDateController,
                            'End Date',
                            context,
                            isDisabled: isCurrentlyWorking,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Company Logo (optional)',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Obx(() {
                      final pickedFile = widget.controller.pickedImageFile.value;
                      Widget imageWidget;
                      if (pickedFile != null) {
                        imageWidget = Image.file(
                          pickedFile,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        );
                      } else if (widget.controller.companyLogoUrl.value.isNotEmpty) {
                        imageWidget = Image.network(
                          widget.controller.companyLogoUrl.value,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 80,
                              height: 80,
                              color: Colors.grey[300],
                              child: Image.asset(
                                'assets/profile_placeholder.png',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      } else {
                        imageWidget = Container(
                          width: 80,
                          height: 80,
                          color: Colors.grey[300],
                          child: Image.asset(
                            'assets/profile_placeholder.png',
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      return Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: imageWidget,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () async {
                                // For add: only pick image, for edit: pick and upload
                                final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
                                if (picked != null) {
                                  widget.controller.pickedImageFile.value = File(picked.path);
                                  if (widget.editItem != null && widget.editItem!.id != null) {
                                    // For edit, upload immediately
                                    await widget.controller.pickAndUploadImage(
                                      "CompanyLogo",
                                      companyId: widget.editItem!.id,
                                    );
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),

                    const SizedBox(height: 24),
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
                          if (widget.controller.experienceFormKey.currentState!
                              .validate()) {
                            widget.controller.addOrUpdateExperince(
                              expId: widget.editItem?.id,
                              bottomSheetContext: widget.bottomSheetContext,
                              status: isCurrentlyWorking ? 1 : 0,
                              editItem: widget.editItem,
                              localImageFilePath: widget.controller.pickedImageFile.value?.path,
                            );
                          }
                        },
                        child: Text(
                          widget.editItem != null ? 'Update' : 'Add',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    if (widget.editItem != null) ...[
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          label: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                          onPressed: () {
                            widget.controller.deleteExperince(widget.editItem!.id!);
                            Navigator.pop(widget.bottomSheetContext);
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
            ),
            Obx(() => widget.controller.isLoading.value
                ? Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
      ),
      validator:
          (value) =>
              (value == null || value.trim().isEmpty)
                  ? '$hint is required'
                  : null,
    );
  }

  Widget _buildDateField(
    TextEditingController controller,
    String hint,
    BuildContext context, {
    bool isDisabled = false,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      enabled: !isDisabled,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: const Icon(Icons.calendar_today),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
      ),
      validator: (value) {
        if (!isDisabled && (value == null || value.trim().isEmpty)) {
          return '$hint is required';
        }
        return null;
      },
      onTap: () async {
        if (!isDisabled) {
          final picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1950),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            controller.text = DateFormat('dd-MMM-yyyy').format(picked);
          }
        }
      },
    );
  }
}
