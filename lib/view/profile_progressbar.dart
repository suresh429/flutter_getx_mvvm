import 'package:flutter/material.dart';
import '../model/LoginModel.dart';

class ProfileWithProgressBar extends StatelessWidget {
  final LoginModel data;

  const ProfileWithProgressBar({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int progressPercentage = calculateProfileCompletion(data.data);
    Color progressColor = _getProgressColor(progressPercentage);

    return Stack(
      alignment: Alignment.center,
      children: [
        // Progress background circle
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade200.withOpacity(0.5),
          ),
        ),

        // Progress indicator
        SizedBox(
          width: 56,
          height: 56,
          child: CircularProgressIndicator(
            value: progressPercentage / 100,
            strokeWidth: 3,
            backgroundColor: Colors.transparent,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ),

        // Profile image
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            image: DecorationImage(
              image: NetworkImage(
                data.data?.profileImageUrl ?? 'https://via.placeholder.com/150',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Percentage badge
        Positioned(
          bottom: 0, // Slightly above the very bottom
          left: 0,
          right: 0, // This centers the child horizontally
          child: Center( // Double centering for precision
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Text(
                '$progressPercentage%',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: progressColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _getProgressColor(int percentage) {
    if (percentage < 40) return Colors.red;
    if (percentage < 75) return Colors.orange;
    return Colors.green;
  }

  int calculateProfileCompletion(data) {
    if (data == null) return 0;

    int percentage = 0;
    bool basicInfoComplete = data.currentRole?.isNotEmpty == true &&
        isNameComplete(data.name) &&
        isAddressComplete(data.address);

    if (basicInfoComplete) percentage += 30;
    if (data.aboutMe?.isNotEmpty == true) percentage += 10;
    if (data.experience?.isNotEmpty == true) percentage += 20;
    if (data.functionalExpertise?.isNotEmpty == true) percentage += 20;
    if (data.areasOfInterest?.isNotEmpty == true) percentage += 10;
    if (data.achievements?.isNotEmpty == true) percentage += 10;

    return percentage.clamp(0, 100);
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