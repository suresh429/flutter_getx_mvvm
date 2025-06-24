import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_model/public_profile_controller.dart';

class PublicProfileAreaInterestBottom extends StatelessWidget {
  final PublicProfileController controller;
  final BuildContext bottomSheetContext;

  const PublicProfileAreaInterestBottom({
    Key? key,
    required this.controller,
    required this.bottomSheetContext,
  }) : super(key: key);

  static const List<String> areaOfInterestsList = [
    "No Poverty",
    "Zero Hunger",
    "Good Health and Well-being",
    "Quality Education",
    "Gender Equality",
    "Clean Water and Sanitation",
    "Affordable and Clean Energy",
    "Decent Work and Economic Growth",
    "Industry, Innovation and Infrastructure",
    "Reduced Inequality",
    "Sustainable Cities and Communities",
    "Responsible Consumption and Production",
    "Climate Action",
    "Life Below Water",
    "Life on Land",
    "Peace, Justice and Strong Institutions",
    "Partnerships to achieve the Goal",
  ];

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final borderColor = Colors.grey.shade400;

    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Column(
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
                        'Area of Interest',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(bottomSheetContext),
                        child: const Icon(Icons.close, size: 24.0, color: Colors.black),
                      ),
                    ],
                  ),
                ),

                // Content
                Expanded(
                  child: SingleChildScrollView(
                    controller: scrollController,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Obx(() {
                      final selectedOptions = controller.selectedAreaOfInterest;

                      return Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: areaOfInterestsList.map((item) {
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
                        }).toList(),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 16),

                // Save Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
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
                        final selected = controller.selectedAreaOfInterest.toList();
                        controller.updateAreaOfInterest(selected);
                        Navigator.pop(bottomSheetContext);
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
