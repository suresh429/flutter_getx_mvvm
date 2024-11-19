// services/api_service.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/env/app_env.dart';
import 'package:flutter_getx_mvvm/model/CommonResponse.dart';
import 'package:flutter_getx_mvvm/model/ExploreModel.dart';
import 'package:flutter_getx_mvvm/model/LoginModel.dart';
import 'package:flutter_getx_mvvm/payload/fav_payload.dart';
import '../payload/login_payload.dart';

class ApiService {
  final Dio _dio = Dio();

//  login
  Future<LoginModel> login(LoginPayload payload) async {
    final response = await _dio.post(
      '${AppEnvironment.baseApiUrl}login',
      // Adjust this URL as per your API endpoint
      data: payload.toJson(),
    );

    if (response.statusCode == 200) {
      // Assuming your API returns a User object in the response
      return LoginModel.fromJson(
          response.data['data']); // Adjust according to your response structure
    } else {
      throw Exception('Failed to log in: ${response.data['message']}');
    }
  }

  // fetch recommendations
  Future<List<ExploreModel>> fetchRecommendations() async {
    final response = await _dio.get(
      "${AppEnvironment.baseApiUrl}donationRequest",
      queryParameters: {
        'limit': 3,
        'user_id': '645230409a97be6b22c7081e',
        'status': 1,
        'sortBy': 'createdAt',
        'sortOrder': -1,
        'requestType': jsonEncode([
          {'request_type': 'podcast'}
        ]),
        'loginId': '645230409a97be6b22c7081e',
        'languagePreferences': '',
      },
    );
    // Update this line to get the actual list of recommendations
    final data = response.data['data'] as List; // Accessing 'data' directly

    // Map the data to ExploreModel objects
    return data.map((explore) => ExploreModel.fromJson(explore)).toList();
  }


  //  Favorite
  Future<CommonResponse> addToFavorite(FavPayload payload) async {
    try {

      // Prepare the headers with the Bearer token
      final headers = {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjQ1MjMwNDA5YTk3YmU2YjIyYzcwODFlIiwiaWF0IjoxNzMxNTY0NTYyLCJleHAiOjE4MTc5NjQ1NjJ9.mFNDi40dM7eBOrBAekXlwUQevQpbceVtyv_3gpuZCmg',
      };
      final response = await _dio.post(
        '${AppEnvironment.baseApiUrl}donation/request/favourite',
        data: payload.toJson(),
        options: Options(headers: headers), // Set the headers here
      );

      if (response.statusCode == 200) {
        return CommonResponse.fromJson(response.data['data']);
      } else {
        // Print the whole response to inspect errors more closely
        throw Exception('Failed to add to favorites: ${response.data}');
      }
    } catch (e) {
      // Handle Dio-specific errors
      if (e is DioException) {
        print('Dio error: ${e.response?.data}'); // Log Dio error details
      } else {
        print('Error: $e');
      }
      rethrow;  // Rethrow error for further handling
    }
  }

// Fetch recommendations with pagination
  Future<List<ExploreModel>> fetchExploreRequests(
      {required String requestTypes,
      required int limit,
      required int offset,
      required int page}) async {
    try {
      // URL-encode the requestType string (important for spaces and special characters)
      /* const requestType = '[{"request_type":"board member"}]';
      final encodedRequestType = Uri.encodeComponent(requestType);*/
      final queryParameters = {
        'limit': limit,
        'offset': offset,
        'user_id': '645230409a97be6b22c7081e',
        'status': 1,
        'sortBy': 'createdAt',
        'sortOrder': -1,
        'requestType': requestTypes,
        'loginId': '645230409a97be6b22c7081e',
        'languagePreferences': '',
        //'page': page,
      };

      print("Query Parameters: $queryParameters");

      final response = await _dio.get(
        "${AppEnvironment.baseApiUrl}donationRequest",
        queryParameters: queryParameters,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

     // print("Response Body: ${response.data}");
      debugPrint(response.data.toString(), wrapWidth: 1024);
      print(response.realUri.toString());
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final responseData = data['data'] as List<dynamic>;

        return responseData.map((item) => ExploreModel.fromJson(item)).toList();
      } else {
        throw Exception(
            'Failed to fetch explore requests: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load Requests: $e');
    }
  }
}
