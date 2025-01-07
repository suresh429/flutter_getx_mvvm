// services/generic_api_service.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_getx_mvvm/env/app_env.dart';

class GenericApiService {
  final Dio _dio = Dio();

  // Generic methods for API requests
  // Post
  Future<T> post<T>(String endpoint, dynamic data, T Function(Map<String, dynamic>) fromJson, {String? token}) async {
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
    } catch (e) {
      print("Error occurred during POST request: $e");
      rethrow;
    }
  }

  // Get
  Future<T> get<T>(String endpoint, T Function(Map<String, dynamic>) fromJson, {Map<String, dynamic>? params, String? token}) async {
    try {
      final response = await _dio.get(
        '${AppEnvironment.baseApiUrl}$endpoint',
        queryParameters: params,
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
      print("Error occurred during GET request: $e");
      rethrow;
    }
  }

  // Put
  Future<T> put<T>(String endpoint, dynamic data, T Function(Map<String, dynamic>) fromJson, {String? token}) async {
    try {
      if (data == null) {
        throw Exception("Request data is null");
      }

      final response = await _dio.put(
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
    } catch (e) {
      print("Error occurred during PUT request: $e");
      print("Request data: ${jsonEncode(data)}");
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