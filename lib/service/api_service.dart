// services/api_service.dart
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/env/app_env.dart';
import 'package:flutter_getx_mvvm/model/CommonModel.dart';
import 'package:flutter_getx_mvvm/model/ExploreModel.dart';
import 'package:flutter_getx_mvvm/model/LoginModel.dart';
import 'package:flutter_getx_mvvm/payload/fav_payload.dart';
import 'package:flutter_getx_mvvm/payload/invite_payload.dart';
import '../model/ShareModel.dart';
import '../payload/like_unlike_payload.dart';
import '../payload/login_payload.dart';
import '../payload/user_update_payload.dart';


class ApiService {
  final Dio _dio = Dio();
  static const String _login = "login";
  static const String _donationRequest = "donationRequest";
  static const String _addToFav = "donation/request/favourite";
  static const String _inviteTalLeaders = "user/inviteTalLeaders";
  static const String _likeUnlike = "donation/request/like";
  static const String _share = "donationRequest/analytics";
  static const String _user = "user";



  Future<LoginModel> login(LoginPayload payload) async {
    try {
      final response = await _dio.post(
        '${AppEnvironment.baseApiUrl}$_login',
        data: payload.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        throw Exception('Failed to log in: ${response.data['message']}');
      }
    } catch (e) {
      print("Error occurred during login: $e");
      rethrow;
    }
  }


  // invite member
  Future<CommonModel> inviteMember(InvitePayload payload,String? token) async {
    try {
      final response = await _dio.post(
        '${AppEnvironment.baseApiUrl}$_inviteTalLeaders',
        data: payload.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
            'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        throw Exception('Failed to log in: ${response.data['message']}');
      }
    } catch (e) {
      print("Error occurred during login: $e");
      rethrow;
    }
  }

  // like unlike
  Future<CommonModel> likeUnlikeRequest(LikeUnlikePayload payload,String? token) async {
    try {
      final response = await _dio.put(
        '${AppEnvironment.baseApiUrl}$_likeUnlike',
        data: payload.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
            'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        throw Exception('Failed to log in: ${response.data['message']}');
      }
    } catch (e) {
      print("Error occurred during login: $e");
      rethrow;
    }
  }

  // share request
  Future<ShareModel> shareRequest(String? token,String id) async {
    try {
      final response = await _dio.put(
        '${AppEnvironment.baseApiUrl}$_share/$id/share',
      //  data: payload.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
            'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return ShareModel.fromJson(response.data);
      } else {
        throw Exception('Failed to log in: ${response.data['message']}');
      }
    } catch (e) {
      print("Error occurred during login: $e");
      rethrow;
    }
  }

  // manage preferences
  Future<LoginModel> managePreferencesRequest(String? token,String? userId,UserUpdatePayload payload) async {
    try {
      final response = await _dio.put(
        '${AppEnvironment.baseApiUrl}$_user/$userId',
        data: payload.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
            'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        throw Exception('Failed to log in: ${response.data['message']}');
      }
    } catch (e) {
      print("Error occurred during login: $e");
      rethrow;
    }
  }


  // get profile
  Future<LoginModel> getProfile(String? uniqueId) async {
    final response = await _dio.get(
      "${AppEnvironment.baseApiUrl}$_user/$uniqueId",
    );

    final data = response.data['data'] ; // Accessing 'data' directly

    // Map the data to ExploreModel objects
    return data.map((explore) => LoginModel.fromJson(explore));
  }


  // fetch recommendations
  Future<List<ExploreModel>> fetchRecommendations(String? uniqueId) async {
    final response = await _dio.get(
      "${AppEnvironment.baseApiUrl}$_donationRequest",
      queryParameters: {
        'limit': 3,
        'user_id': uniqueId,
        'status': 1,
        'sortBy': 'createdAt',
        'sortOrder': -1,
        'requestType': jsonEncode([
          {'request_type': 'podcast'}
        ]),
        'loginId': uniqueId,
        'languagePreferences': '',
      },
    );
    // Update this line to get the actual list of recommendations
    final data = response.data['data'] as List; // Accessing 'data' directly

    // Map the data to ExploreModel objects
    return data.map((explore) => ExploreModel.fromJson(explore)).toList();
  }


  //  Favorite
  Future<CommonModel> addToFavorite(FavPayload payload,String? token) async {
    try {
      // Prepare the headers with the Bearer token
      final headers = {
        'Authorization':
            'Bearer $token',
      };
      final response = await _dio.post(
        '${AppEnvironment.baseApiUrl}$_addToFav',
        data: payload.toJson(),
        options: Options(headers: headers), // Set the headers here
      );

      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data['data']);
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
      rethrow; // Rethrow error for further handling
    }
  }




// Fetch Explore data with pagination
  Future<List<ExploreModel>> fetchExploreRequests(
      {required String requestTypes,
      required int limit,
      required int offset,
      required int page,
      required String? userId}
      ) async {
    try {

      final queryParameters = {
        'limit': limit,
        'offset': offset,
        'user_id': userId,
        'status': 1,
        'sortBy': 'createdAt',
        'sortOrder': -1,
        'requestType': requestTypes,
        'loginId': userId,
        'languagePreferences': '',

      };


      final response = await _dio.get(
        "${AppEnvironment.baseApiUrl}$_donationRequest",
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
