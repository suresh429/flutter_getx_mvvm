import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../view_model/public_profile_controller.dart';

class PublicProfileExpertiseBottom extends StatelessWidget {
  final PublicProfileController controller;
  final BuildContext bottomSheetContext;

  const PublicProfileExpertiseBottom({
    Key? key,
    required this.controller,
    required this.bottomSheetContext,
  }) : super(key: key);

  static const List<String> expertiseList = [
    "Management",
    "Data Analytics",
    "ESG & Sustainability",
    "Sales Leadership",
    "Fundraising",
    "Growth & Scaleup",
    "Operations",
    "Product Development",
    "Entrepreneurship",
    "Charity/NGO",
    "Procurement & Supply Chain",
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final borderColor = Colors.grey.shade400;

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

          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Expertise',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () => Navigator.pop(bottomSheetContext),
                  child: const Icon(Icons.close, size: 24.0),
                ),
              ],
            ),
          ),

          // Chips
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Obx(() {
              final selectedOptions = controller.selectedExpertise;
              final allSelected = selectedOptions.length == expertiseList.length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      // Select All
                      ChoiceChip(
                        label: const Text('Select All'),
                        selected: allSelected,
                        backgroundColor: Colors.transparent,
                        selectedColor: Colors.transparent,
                        side: BorderSide(
                          color: allSelected ? primaryColor : borderColor,
                        ),
                        labelStyle: TextStyle(
                          color: allSelected ? primaryColor : Colors.black,
                        ),
                        onSelected: (_) {
                          if (allSelected) {
                            selectedOptions.clear();
                          } else {
                            selectedOptions.assignAll(expertiseList);
                          }
                        },
                      ),

                      // Individual Chips
                      ...expertiseList.map((item) {
                        final isSelected = selectedOptions.contains(item);
                        return ChoiceChip(
                          label: Text(item),
                          selected: isSelected,
                          backgroundColor: Colors.transparent,
                          selectedColor: Colors.transparent,
                          side: BorderSide(
                            color: isSelected ? primaryColor : borderColor,
                          ),
                          labelStyle: TextStyle(
                            color: isSelected ? primaryColor : Colors.black,
                          ),
                          onSelected: (_) {
                            if (isSelected) {
                              selectedOptions.remove(item);
                            } else {
                              selectedOptions.add(item);
                            }
                          },
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 24),
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
                        final selected = controller.selectedExpertise.toList();
                        print('Selected Areas of Interest: $selected');
                        controller.updateExpertise(selected);
                        Navigator.pop(bottomSheetContext);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
