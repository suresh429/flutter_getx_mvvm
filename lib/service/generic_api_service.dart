// services/generic_api_service.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_getx_mvvm/env/app_env.dart';

class GenericApiService {
  final Dio _dio = Dio();

  // Generic methods for API requests
  // Post
  Future<T> post<T>(
      String endpoint,
      dynamic data,
      T Function(Map<String, dynamic>) fromJson, {
        String? token,
      })
  async {
    try {
      final response = await _dio.post(
        '${AppEnvironment.baseApiUrl}$endpoint',
        data: jsonEncode(data),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed request: ${response.data['message']}',
        );
      }
    } on DioException catch (dioError) {
      print("DioException caught in POST:");
      print("Status code: ${dioError.response?.statusCode}");
      print("Response data: ${dioError.response?.data}");
      print("Request data: $data");
      rethrow;
    } catch (e) {
      print("Unexpected error in POST: $e");
      rethrow;
    }
  }





  // Get
// In your service
  Future<T> get<T>(String endpoint, T Function(Map<String, dynamic>) fromJson,
      {Map<String, dynamic>? params, String? token}) async {
    try {
      final url = '${AppEnvironment.baseApiUrl}$endpoint';

      // Create URI to properly encode query parameters

      final response = await _dio.get(
        url,
        queryParameters: params,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return fromJson(response.data);
      } else {
        final errorMsg = response.data['message'] ?? 'Unknown error';
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Request failed: $errorMsg (${response.statusCode})',
        );
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Error response: ${e.response?.data}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }



  // Put
  Future<T> put<T>(
      String endpoint,
      dynamic data,
      T Function(Map<String, dynamic>) fromJson, {
        String? token,
      }) async {
    try {
      final response = await _dio.put(
        '${AppEnvironment.baseApiUrl}$endpoint',
        data: data != null ? jsonEncode(data) : null,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed request: ${response.data['message']}',
        );
      }
    } catch (e) {
      print("Error occurred during PUT request: $e");
      print("Request data: ${data != null ? jsonEncode(data) : 'No data'}");
      rethrow;
    }
  }

  // Delete
  Future<Map<String, dynamic>> delete(String endpoint, {String? token}) async {
    try {
      final response = await _dio.delete(
        '${AppEnvironment.baseApiUrl}$endpoint',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
          error: 'Failed request: ${response.data['message']}',
        );
      }
    } catch (e) {
      print("Error occurred during DELETE request: $e");
      rethrow;
    }
  }}