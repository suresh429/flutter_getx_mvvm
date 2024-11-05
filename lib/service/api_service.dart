// services/api_service.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_getx_mvvm/model/ExploreModel.dart';
import 'package:flutter_getx_mvvm/model/LoginModel.dart';

import '../model/user.dart';
import '../payload/login_payload.dart';

class ApiService {
  final Dio _dio = Dio();
  final String baseUrl = "https://jsonplaceholder.typicode.com/users";
  final String baseUrl1 = "https://touch-a-life-dev.web.app/api/v1/";

// New method for user login
  Future<LoginModel> login(LoginPayload payload) async {
    final response = await _dio.post(
      '${baseUrl1}login', // Adjust this URL as per your API endpoint
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

  Future<List<ExploreModel>> fetchRecommendations() async {
    final response = await _dio.get(
      "${baseUrl1}donationRequest",
      queryParameters: {
        'limit': 3,
        'user_id': '645230409a97be6b22c7081e',
        'status': 1,
        'sortBy': 'createdAt',
        'sortOrder': -1,
        'requestType': jsonEncode([{'request_type': 'podcast'}]),
        'loginId': '645230409a97be6b22c7081e',
        'languagePreferences': '',
      },
    );
    // Update this line to get the actual list of recommendations
    final data = response.data['data'] as List; // Accessing 'data' directly

    // Map the data to ExploreModel objects
    return data.map((explore) => ExploreModel.fromJson(explore)).toList();
  }



  Future<List<User>> fetchUsers() async {
    final response = await _dio.get(baseUrl);
    return (response.data as List).map((user) => User.fromJson(user)).toList();
  }

  Future<User> createUser(User user) async {
    final response = await _dio.post(
      baseUrl,
      data: user.toJson(),
    );
    return User.fromJson(response.data);
  }

  Future<User> updateUser(User user) async {
    final response = await _dio.put(
      '$baseUrl/${user.id}',
      data: user.toJson(),
    );
    return User.fromJson(response.data);
  }

  Future<void> deleteUser(int id) async {
    await _dio.delete('$baseUrl/$id');
  }
}
