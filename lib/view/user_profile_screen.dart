import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:intl/intl.dart';
import '../view_model/profile_controller.dart';
import '../widget/city_auto_completefield.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section with Stack
              Container(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Name and Address Section
                    Container(
                      margin: const EdgeInsets.only(top: 80),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Column(
                          children: [
                            Text(
                              '${controller.firstName.value} ${controller.lastName.value}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            controller.city.value.isNotEmpty
                                ? Text(
                              controller.city.value,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                              textAlign: TextAlign.center,
                            )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                    // Profile Avatar with edit icon
                    Positioned(
                      top: 30,
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: controller.pickedImageFile.value != null
                                ? FileImage(controller.pickedImageFile.value!)
                                : (controller.profileImageUrl.value.isNotEmpty &&
                                controller.profileImageUrl.value.startsWith('http'))
                                ? NetworkImage(controller.profileImageUrl.value)
                                : const AssetImage('assets/profile_placeholder.png') as ImageProvider,
                            backgroundColor: Colors.white,
                          ),
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
                              onPressed: () {
                                // Implement image picker logic
                               controller.pickImage();
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 10, color: Colors.grey[200]),
              // Form Fields Section
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      if (controller.errorMessage.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            controller.errorMessage.value,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'First Name*',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: UnderlineInputBorder(),
                        ),
                        style: const TextStyle(fontSize: 16),
                        initialValue: controller.firstName.value,
                        onChanged: (value) =>
                        controller.firstName.value = value,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Last Name*',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: UnderlineInputBorder(),
                        ),
                        style: const TextStyle(fontSize: 16),
                        initialValue: controller.lastName.value,
                        onChanged: (value) =>
                        controller.lastName.value = value,
                      ),
                      const SizedBox(height: 16),
                      // Date of Birth with Date Picker
                      GestureDetector(
                        onTap: () async {
                          DateTime currentDate = DateTime.now();
                          DateTime initialDate = controller.dob.value.isNotEmpty
                              ? DateFormat('dd-MMM-yyyy')
                              .parse(controller.dob.value)
                              : currentDate;
                          DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: initialDate,
                            firstDate: DateTime(1900),
                            lastDate: currentDate,
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: const ColorScheme.light(
                                    primary: Colors.blue,
                                    onPrimary: Colors.white,
                                    onSurface: Colors.black,
                                  ),
                                  dialogBackgroundColor: Colors.white,
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (picked != null) {
                            controller.dob.value =
                                DateFormat('dd-MMM-yyyy').format(picked);
                          }
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Date of birth*',
                              labelStyle: TextStyle(color: Colors.grey),
                              border: UnderlineInputBorder(),
                              suffixIcon: Icon(
                                Icons.calendar_today,
                                color: Colors.grey,
                              ),
                            ),
                            style: const TextStyle(fontSize: 16),
                            controller: TextEditingController(
                                text: controller.dob.value),
                            onChanged: (value) =>
                            controller.dob.value = value,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Gender Dropdown
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          labelText: 'Gender*',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: UnderlineInputBorder(),
                        ),
                        value: controller.gender.value,
                        items: controller.genderOptions.map((String gender) {
                          return DropdownMenuItem<String>(
                            value: gender,
                            child: Text(gender),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            controller.gender.value = newValue;
                          }
                        },
                        style:
                        const TextStyle(fontSize: 16, color: Colors.black),
                        dropdownColor: Colors.white,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'User Name',
                          labelStyle: TextStyle(color: Colors.grey),
                          border: UnderlineInputBorder(),
                        ),
                        style: const TextStyle(fontSize: 16),
                        initialValue: controller.username.value,
                        onChanged: (value) =>
                        controller.username.value = value,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Enter email',
                          enabled: false,
                          labelStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.check, color: Colors.green),

                        ),
                        style: const TextStyle(fontSize: 16),
                        initialValue: controller.email.value,
                        onChanged: (value) =>
                        controller.email.value = value,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: CountryCodePicker(
                              onChanged: controller.onCountryChange,
                              initialSelection: controller.selectedCountryCode.value.code,
                              favorite: const ['+91', '+1'],
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: false,
                              alignLeft: false,
                              padding: const EdgeInsets.all(0),
                              countryFilter: const ['IN', 'US'], // ✅ Only show India and US
                              boxDecoration: BoxDecoration(
                                border: Border.all(color: Colors.transparent),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Mobile number',
                                labelStyle: TextStyle(color: Colors.grey),
                                border: UnderlineInputBorder(),
                                contentPadding: EdgeInsets.only(left: 8.0),
                              ),
                              style: const TextStyle(fontSize: 16),
                              initialValue: controller.mobile.value,
                              keyboardType: TextInputType.phone,
                              onChanged: (value) => controller.mobile.value = value,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      CityDropdownField(),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: controller.submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text(
                          'Submit',
                          style:
                          TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}