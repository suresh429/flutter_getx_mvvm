// services/main_repository.dart
import 'package:flutter_getx_mvvm/model/CommonModel.dart';
import 'package:flutter_getx_mvvm/model/DonationRequestResponse.dart';
import 'package:flutter_getx_mvvm/model/ExploreModel.dart';
import 'package:flutter_getx_mvvm/model/LoginModel.dart';
import 'package:flutter_getx_mvvm/model/ShareModel.dart';
import 'package:flutter_getx_mvvm/model/UserModel.dart';
import 'package:flutter_getx_mvvm/payload/fav_payload.dart';
import 'package:flutter_getx_mvvm/payload/invite_payload.dart';
import 'package:flutter_getx_mvvm/payload/like_unlike_payload.dart';
import 'package:flutter_getx_mvvm/payload/login_payload.dart';
import 'package:flutter_getx_mvvm/payload/user_update_payload.dart';

import 'generic_api_service.dart';

class MainRepository {

  final GenericApiService service = GenericApiService();

  static const String _login = "login";
  static const String _donationRequest = "donationRequest";
  static const String _donationRequestResponse = "donationRequestResponses";
  static const String _addToFav = "donation/request/favourite";
  static const String _inviteTalLeaders = "user/inviteTalLeaders";
  static const String _likeUnlike = "donation/request/like";
  static const String _share = "donationRequest/analytics";
  static const String _user = "user";
  static const String _reminder = "donationRequest/reminder/donee";




  // Specific API methods using the generic methods
  Future<LoginModel> login(LoginPayload payload) async {
    return await service.post<LoginModel>(
      _login,
      payload.toJson(),
          (data) => LoginModel.fromJson(data),
    );
  }

  Future<CommonModel> inviteMember(InvitePayload payload, String? token) async {
    return await service.post<CommonModel>(
      _inviteTalLeaders,
      payload.toJson(),
          (data) => CommonModel.fromJson(data),
      token: token,
    );
  }

  Future<CommonModel> likeUnlikeRequest(LikeUnlikePayload payload, String? token) async {
    return await service.post<CommonModel>(
      _likeUnlike,
      payload.toJson(),
          (data) => CommonModel.fromJson(data),
      token: token,
    );
  }

  Future<ShareModel> shareRequest(String? token, String id) async {
    final emptyPayload = {};
    return await service.put<ShareModel>(
      '$_share/$id/share',
      emptyPayload,
          (data) => ShareModel.fromJson(data),
      token: token,
    );
  }

  Future<LoginModel> managePreferencesRequest(String? token, String? userId, UserUpdatePayload payload) async {
    return await service.put<LoginModel>(
      '$_user/$userId',
      payload.toJson(),
          (data) => LoginModel.fromJson(data),
      token: token,
    );
  }

  Future<UserModel> getProfile(String? uniqueId) async {
    return await service.get<UserModel>(
      '$_user/$uniqueId',
          (data) => UserModel.fromJson(data),
    );
  }

  Future<List<ExploreModel>> fetchRecommendations(String? uniqueId, String requestType, String language) async {
    final params = {
      'limit': 3,
      'user_id': uniqueId,
      'status': 1,
      'sortBy': 'createdAt',
      'sortOrder': -1,
      'requestType': requestType,
      'loginId': uniqueId,
      'languagePreferences': language,
    };
    final data = await service.get<Map<String, dynamic>>(
      _donationRequest,
          (data) => data,
      params: params,
    );
    return (data['data'] as List).map((explore) => ExploreModel.fromJson(explore)).toList();
  }

  Future<CommonModel> addToFavorite(FavPayload payload, String? token) async {
    return await service.post<CommonModel>(
      _addToFav,
      payload.toJson(),
          (data) => CommonModel.fromJson(data['data']),
      token: token,
    );
  }

  Future<List<ExploreModel>> fetchExploreRequests({
    required String requestTypes,
    required int limit,
    required int offset,
    required int page,
    required String? userId,
    required String title,
  }) async {
    final favSearchValue = title == 'My Favorites' ? 'true' : '';
    final status = title == 'My Favorites' ? '' : '1';
    final params = {
      'limit': limit,
      'offset': offset,
      'user_id': userId,
      'status': status,
      'sortBy': 'createdAt',
      'sortOrder': -1,
      'requestType': requestTypes,
      'loginId': userId,
      'fav_search': favSearchValue,
    };
    final data = await service.get<Map<String, dynamic>>(
      _donationRequest,
          (data) => data,
      params: params,
    );
    return (data['data'] as List).map((item) => ExploreModel.fromJson(item)).toList();
  }

  Future<List<DonationRequestResponse>> fetchActivityRequests({
    required String requestTypes,
    required int limit,
    required int offset,
    required String? userId,
    required String requestStatus,
  }) async {
    final params = {
      'limit': limit.toString(),
      'offset': offset.toString(),
      'userId': userId ?? '',
      'requestType': requestTypes,
      'requestStatus': requestStatus,
    };
    final data = await service.get<Map<String, dynamic>>(
      _donationRequestResponse,
          (data) => data,
      params: params,
    );
    return (data['data'] as List).map((item) => DonationRequestResponse.fromJson(item)).toList();
  }

  Future<CommonModel> reminderPost(String requestId, String? token) async {
    return await service.post<CommonModel>(
      _reminder,
      {"requestId": requestId},
          (data) => CommonModel.fromJson(data),
      token: token,
    );
  }

  Future<DonationRequestResponseData> reminderPut(String requestId, String? token) async {
    return await service.put<DonationRequestResponseData>(
      '$_donationRequestResponse/$requestId',
      {"reminderSent": true},
          (data) => DonationRequestResponseData.fromJson(data),
      token: token,
    );
  }


}