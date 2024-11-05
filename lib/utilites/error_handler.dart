// utils/error_handler.dart
import 'package:dio/dio.dart';

class ErrorHandler {
  static String handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please try again.';
      case DioExceptionType.sendTimeout:
        return 'Send timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout. Please try again.';
      case DioExceptionType.badResponse:
        if (error.response != null) {
          return 'Error: ${error.response?.statusCode} - ${error.response?.statusMessage}';
        } else {
          return 'Unexpected response error occurred.';
        }
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.unknown:
      default:
        return 'An unexpected error occurred: ${error.message}';
    }
  }
}
