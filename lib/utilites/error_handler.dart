import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';  // Ensure this package is imported


class ErrorHandler {
  // Generic error handling method to work for both Login and Recommendation controllers
  static Future<String> handleError(dynamic error) async {
    // First, check if there is no internet connection
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return 'No internet connection. Please check your network settings.';
    }

    // Handle DioException if connectivity is available
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return 'Connection timeout. Please try again.';
        case DioExceptionType.sendTimeout:
          return 'Send timeout. Please try again.';
        case DioExceptionType.receiveTimeout:
          return 'Receive timeout. Please try again.';
        case DioExceptionType.badResponse:
          return 'Bad response: ${error.response?.statusCode} ${error.response?.statusMessage}';
        case DioExceptionType.cancel:
          return 'Request cancelled.';
        case DioExceptionType.unknown:
          return 'No internet connection. Please check your network settings.';
        default:
          return 'An unexpected error occurred: ${error.message}';
      }
    }

    // For other types of errors, return a generic error message
    return 'An unexpected error occurred: $error';
  }
}
