import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs_lite.dart';
import 'package:flutter_getx_mvvm/model/LoginModel.dart';
import 'package:flutter_getx_mvvm/model/UserModel.dart';
import 'package:flutter_getx_mvvm/utilites/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';


class ConstantsUtils{

  static String extractCity(String fullAddress) {
    return fullAddress.split(',').first.trim();
  }

  static String extractState(String fullAddress) {
    List<String> parts = fullAddress.split(',');
    return parts.length > 1 ? parts[1].trim() : '';
  }

  static String extractCountry(String fullAddress) {
    List<String> parts = fullAddress.split(',');
    return parts.length > 2 ? parts[2].trim() : '';
  }



static void showSuccessSnackbar(String? message) {
  Get.snackbar(
    'Success',
    message.toString(),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.green,
    colorText: Colors.white,
      margin: const EdgeInsets.all(15)
  );
}

static void showErrorSnackbar(String message) {
  Get.snackbar(
    'Error',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.red,
    colorText: Colors.white,
      margin: const EdgeInsets.all(15)
  );
}

static void showInfoSnackbar(String message) {
  Get.snackbar(
    'Info',
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black,
    colorText: Colors.white,
      margin: const EdgeInsets.all(15)
  );
}

static void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT, // or Toast.LENGTH_LONG
    gravity: ToastGravity.BOTTOM, // TOP, CENTER, or BOTTOM
    backgroundColor: Colors.black87,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

static void launchURL(String url,BuildContext context) async {
  final theme = Theme.of(context);
  try {
    await launchUrl(
      Uri.parse(url),
      options: LaunchOptions(
        barColor: theme.colorScheme.surface,
        onBarColor: Colors.black,
        barFixingEnabled: false,
      ),
    );
  } catch (e) {
    // If the URL launch fails, an exception will be thrown. (For example, if no browser app is installed on the Android device.)
    debugPrint(e.toString());
  }
}



static String calculateTimeLeft(int startDate, int dueDate) {
// Get the current time
  final currentTime = DateTime.now().millisecondsSinceEpoch;

// Calculate the remaining time in milliseconds
  final timeLeft = dueDate - currentTime;

  if (timeLeft > 0) {
// Convert milliseconds to Duration
    final duration = Duration(milliseconds: timeLeft);

// Get days, hours, and minutes left
    final daysLeft = duration.inDays;
    final hoursLeft = duration.inHours % 24;
    final minutesLeft = duration.inMinutes % 60;

    if (daysLeft > 1) {
      return "$daysLeft days left";
    } else if (daysLeft == 1) {
      return "1 day left";
    } else if (hoursLeft >= 1) {
      return "$hoursLeft hours left";
    } else {
      return "$minutesLeft minutes left";
    }
  } else {
    return "0 days left"; // or "Expired" if you prefer
  }
}

// Helper method to format request types into the expected string format
static String buildRequestTypeData(List<String> requestTypes) {
// Convert each request type to the desired JSON-like format and join with commas
  return jsonEncode(
    requestTypes.map((type) => {"request_type": type}).toList(),
  );
}

static Future<LoginModel?> getStoredLoginResponse() async {
  var storage = GetStorage();

// Retrieve the stored user data
  var userData = storage.read('userData');

  if (userData != null) {
    try {
// Decode the JSON string to Map
      var decodedData = jsonDecode(userData);

// Return the LoginModel object
      return LoginModel.fromJson(decodedData);
    } catch (e) {
      print("Error decoding userData: $e");
    }
  }

// Return null if no data found
  return null;
}


// calculate profile progress
  int calculateProfileCompletion(data) {
    if (data == null) return 0;

    int percentage = 0;

    bool nameRoleCompanyAddressPresent =
         data.currentRole?.isNotEmpty == true &&
            isNameComplete(data.name) &&
            isAddressComplete(data.address);

    if (nameRoleCompanyAddressPresent) percentage += 10;
    if (data.aboutMe?.isNotEmpty == true) percentage += 10;
    if (data.experience.isNotEmpty) percentage += 20;
    if (data.functionalExpertise.isNotEmpty) percentage += 20;
    if (data.areasOfInterest.isNotEmpty) percentage += 20;
    if (data.achievements.isNotEmpty) percentage += 20;

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


  static String formatDate(String? dateString) {
    DateTime parsedDate = DateTime.parse(dateString!); // Parse the ISO 8601 date
    String formattedDate = DateFormat("dd-MMM-yyyy").format(parsedDate); // Format it
    return formattedDate;
  }


  static int convertDobToTimestamp(String dobString) {
    try {
      final parsedDate = DateFormat('dd-MMM-yyyy').parse(dobString);
      return parsedDate.millisecondsSinceEpoch;
    } catch (e) {
      print('Invalid DOB format: $e');
      return 0; // Or throw
    }
  }


  static String mapGenderToCode(String genderText) {
    switch (genderText.toLowerCase()) {
      case 'female':
        return 'f';
      case 'male':
        return 'm';
      case 'other':
        return 'o';
      default:
        return 'f'; // Default fallback
    }
  }


  static String convertMilliToDateInEducation(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final formatter = DateFormat('dd MMM yyyy'); // Example: Jun 2025
    return formatter.format(date);
  }

  static String getFormattedExperienceRange(int? start, int? end) {
    if (start == null || start == 0) return '';
    final formattedStart = convertMilliToDateInEducation(start);
    final formattedEnd = (end == null || end == 0)
        ? 'Present'
        : convertMilliToDateInEducation(end);
    final durationText = getDuration(start, end ?? DateTime.now().millisecondsSinceEpoch);
    return '$formattedStart - $formattedEnd · $durationText';
  }

  static String getDuration(int startMillis, int endMillis) {
    final start = DateTime.fromMillisecondsSinceEpoch(startMillis);
    final end = DateTime.fromMillisecondsSinceEpoch(endMillis);

    int years = end.year - start.year;
    int months = end.month - start.month;
    int days = end.day - start.day;

    if (days < 0) {
      months -= 1;
      final previousMonth = DateTime(end.year, end.month, 0);
      days += previousMonth.day; // Days in the previous month
    }

    if (months < 0) {
      years -= 1;
      months += 12;
    }

    final y = years > 0 ? "$years yr${years > 1 ? 's' : ''}" : "";
    final m = months > 0 ? "$months mo${months > 1 ? 's' : ''}" : "";
    final d = days > 0 ? "$days day${days > 1 ? 's' : ''}" : "";

    return [y, m, d].where((e) => e.isNotEmpty).join(" ");
  }

  static bool isValidUrl(String url) {
    final urlPattern = RegExp(
        r'^(https?:\/\/)' // http or https
        r'(([a-zA-Z0-9\-]+\.)+[a-zA-Z]{2,})' // domain name
        r'(:\d+)?' // optional port
        r'(\/[^\s\/]+)+\/?$' // path
    );
    return urlPattern.hasMatch(url);
  }

  static bool checkString(String location) {
    final parts = location.split(',');
    print('checkSize: ${parts.length}');
    return parts.length != 3;
  }

  static String capitalizeFirst(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }

  static String formatDateTime(DateTime date) {
    final DateFormat formatter = DateFormat('MMMM dd, yyyy, h:mm a');
    return formatter.format(date);
  }


  static String convertMillisecondsToFormattedDate(int? milliseconds) {
    if (milliseconds == null || milliseconds == 0) return 'N/A';
    final date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final formatter = DateFormat('dd-MMM-yyyy');
    return formatter.format(date);
  }

  static String convertMillisecondsToFormattedDate2(int? milliseconds) {
    if (milliseconds == null || milliseconds == 0) return 'N/A';
    final date = DateTime.fromMillisecondsSinceEpoch(milliseconds);
    final formatter = DateFormat('MMM dd, yyyy');
    return formatter.format(date);
  }
}