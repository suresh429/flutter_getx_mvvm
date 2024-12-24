import 'package:flutter/material.dart';

import '../model/LoginModel.dart';

class ProfileWithProgressBar extends StatelessWidget {
  final LoginModel data;

  ProfileWithProgressBar({required this.data});

  @override
  Widget build(BuildContext context) {
    print("object data : ${data.data?.areasOfInterest}data");

    // Calculate the profile completion percentage
     int progressPercentage = calculateProfileCompletion(data.data);

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Circular Progress Indicator
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              value: progressPercentage / 100, // Convert percentage to 0-1 range
              strokeWidth: 2, // Width of the progress bar
              backgroundColor: Colors.grey.shade300, // Background color of the circle
              valueColor: AlwaysStoppedAnimation<Color>(
                     progressPercentage < 40
                    ? Colors.red // For progress less than 40%
                    : progressPercentage < 75
                    ? Colors.orange // For progress between 40% and 74%
                    : Colors.green, // For progress greater than or equal to 75%
              ), // Progress color

            ),
          ),
          // Circle Avatar with Profile Image
          CircleAvatar(
            backgroundColor: Colors.red,
            backgroundImage: NetworkImage(data.data?.profileImageUrl ?? 'https://via.placeholder.com/150'),
            radius: 22, // Size of the avatar
          ),
          // Percentage Text at the bottom
          Positioned(
            bottom: -3,
            child: Container(
              padding: const EdgeInsets.all(3), // Padding around the text
              decoration: BoxDecoration(
                color: Colors.white, // Background color
                borderRadius: BorderRadius.circular(6), // Corner radius
              ),
              child: Text(
                '${progressPercentage.toInt()}%', // Display percentage
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 7,
                  color: Colors.black,
                  backgroundColor: Colors.white
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method to calculate profile completion
  int calculateProfileCompletion(data) {
    if (data == null) return 0;  // Check if data is null

    int percentage = 0;

    // Check if currentRole, name, address are non-null and not empty
    bool nameRoleCompanyAddressPresent =
        data.currentRole?.isNotEmpty == true &&
            isNameComplete(data.name) &&
            isAddressComplete(data.address);

    if (nameRoleCompanyAddressPresent) percentage += 10;

    // Check if other fields are non-null and not empty
    if (data.aboutMe?.isNotEmpty == true) percentage += 10;
    if (data.experience?.isNotEmpty == true) percentage += 20;
    if (data.functionalExpertise?.isNotEmpty == true) percentage += 20;
    if (data.areasOfInterest?.isNotEmpty == true) percentage += 20;
    if (data.achievements?.isNotEmpty == true) percentage += 20;

    return percentage;
  }


  bool isNameComplete(name) {
    return name?.firstName?.isNotEmpty == true ||
        name?.middleName?.isNotEmpty == true ||
        name?.lastName?.isNotEmpty == true;
  }

  bool isAddressComplete(address) {
    return address?.line1?.isNotEmpty == true ||
        address?.city?.isNotEmpty == true ||
        address?.state?.isNotEmpty == true;
  }

}
