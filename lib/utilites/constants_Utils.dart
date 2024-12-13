import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs_lite.dart';
import 'package:flutter_getx_mvvm/model/LoginModel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ConstantsUtils{

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

static void launchURL(String url,BuildContext context) async {
  final theme = Theme.of(context);
  try {
    await launchUrl(
      Uri.parse(url),
      options: LaunchOptions(
        barColor: theme.colorScheme.surface,
        onBarColor: theme.colorScheme.onSurface,
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
}