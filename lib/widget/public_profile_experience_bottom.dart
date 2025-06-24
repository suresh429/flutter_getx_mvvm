import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_getx_mvvm/model/LoginModel.dart';
import 'package:flutter_getx_mvvm/view_model/public_profile_controller.dart';

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

    if (item != null) {
      widget.controller.roleController.text = item.role ?? '';
      widget.controller.companyController.text = item.company ?? '';
      if (item.experienceStartDate != null) {
        widget.controller.startDateController.text =
            DateFormat('dd-MMM-yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(item.experienceStartDate!));
      }
      if (item.experienceEndDate != null) {
        widget.controller.endDateController.text =
            DateFormat('dd-MMM-yyyy').format(
                DateTime.fromMillisecondsSinceEpoch(item.experienceEndDate!));
      }
      isCurrentlyWorking = item.status == 1;
    } else {
      widget.controller.clearExperienceControllers();
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: widget.controller.experienceFormKey, // ✅ Use controller key
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.editItem != null ? 'Edit Experience' : 'Add Experience',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    const Expanded(child: Text("I am currently working in this role.")),
                  ],
                ),
                const SizedBox(height: 12),

                Row(
                  children: [
                    Expanded(
                      child: _buildDateField(
                          widget.controller.startDateController, 'Start Date', context),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildDateField(
                          widget.controller.endDateController, 'End Date', context),
                    ),
                  ],
                ),
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
                      if (widget.controller.experienceFormKey.currentState!.validate()) {
                        widget.controller.addOrUpdateExperince(
                          expId: widget.editItem?.id,
                          bottomSheetContext: widget.bottomSheetContext,
                          status: isCurrentlyWorking ? 1 : 2,
                        );
                        Navigator.pop(widget.bottomSheetContext);
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
                      label: const Text("Delete", style: TextStyle(color: Colors.red)),
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
                ]
              ],
            ),
          ),
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
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
      validator: (value) =>
      (value == null || value.trim().isEmpty) ? '$hint is required' : null,
    );
  }

  Widget _buildDateField(
      TextEditingController controller, String hint, BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: const Icon(Icons.calendar_today),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
      validator: (value) =>
      (value == null || value.trim().isEmpty) ? '$hint is required' : null,
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1950),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          controller.text = DateFormat('dd-MMM-yyyy').format(picked);
        }
      },
    );
  }
}
