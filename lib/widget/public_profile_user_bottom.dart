import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_model/public_profile_controller.dart';
import 'city_auto_completefield.dart';

class PublicProfileUserBottom extends StatelessWidget {
  final PublicProfileController controller;

  const PublicProfileUserBottom({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final roleItems = [
      'Google - Developer',
      'Apple - Designer',
      'Microsoft - PM',
    ];
    final locationItems = ['Hyderabad', 'Bangalore', 'Chennai'];

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close,
                    size: 24.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Obx(() {
                          ImageProvider imageProvider;
                          if (controller.pickedImageFile.value != null) {
                            imageProvider = FileImage(
                              controller.pickedImageFile.value!,
                            );
                          } else if (controller
                                  .profileImageUrl
                                  .value
                                  .isNotEmpty &&
                              controller.profileImageUrl.value.startsWith(
                                'http',
                              )) {
                            imageProvider = NetworkImage(
                              controller.profileImageUrl.value,
                            );
                          } else {
                            imageProvider = const AssetImage(
                              'assets/profile_placeholder.png',
                            );
                          }

                          return CircleAvatar(
                            radius: 45,
                            backgroundImage: imageProvider,
                            backgroundColor: Colors.white,
                          );
                        }),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.edit, size: 16),
                            onPressed: () => controller.pickImage(),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildTextField('First Name', controller.firstNameController),
                  const SizedBox(height: 16),
                  _buildTextField('Last Name', controller.lastNameController),
                  const SizedBox(height: 16),
                  Obx(
                        () => DropdownButtonFormField<String>(
                      value: controller.companyRoleOptions.contains(controller.companyRoleController.text)
                          ? controller.companyRoleController.text
                          : null,
                      decoration: const InputDecoration(
                        labelText: 'Current Company, Current Role',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 12,
                        ),
                      ),
                      items: controller.companyRoleOptions.map((item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                      onChanged: (selected) {
                        if (selected != null) {
                          controller.companyRoleController.text = selected;

                          /// ✅ Here you get the experience ID:
                          final selectedExp = controller.experienceOptionMap[selected];
                          controller.selectedExperienceId.value = selectedExp?.id ?? '';
                          debugPrint('Selected experienceId: ${controller.selectedExperienceId.value}');

                        }
                      },
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 16),
                  CityDropdownField(
                    textController: controller.locationController,
                    selectedCity: controller.location,
                    fetchSuggestions: controller.fetchCities,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Social Links',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildTextField('LinkedIn', controller.linkedinController),
                  const SizedBox(height: 16),
                  _buildTextField('Twitter', controller.twitterController),
                  const SizedBox(height: 16),
                  _buildTextField('Facebook', controller.facebookController),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: ()  {
                         controller.updateUserProfileData();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        suffixIcon: suffixIcon,
      ),
      style: const TextStyle(fontSize: 14),
    );
  }

  Widget _buildDropdownFieldWithLabel({
    required String label,
    required List<String> items,
    required TextEditingController controller,
  }) {
    // Only assign value if it's a valid option
    final validValue = items.contains(controller.text) ? controller.text : null;

    return DropdownButtonFormField<String>(
      value: validValue,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
      ),
      items:
          items.map((item) {
            return DropdownMenuItem<String>(value: item, child: Text(item));
          }).toList(),
      onChanged: (selected) {
        if (selected != null) controller.text = selected;
      },
      style: const TextStyle(fontSize: 14, color: Colors.black),
    );
  }
}
