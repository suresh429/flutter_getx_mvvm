// services/main_repository.dart
import 'package:TALLeaders/env/app_env.dart';
import 'package:TALLeaders/model/CommonModel.dart' hide Data;
import 'package:TALLeaders/model/ConnectReponse.dart' hide Data;
import 'package:TALLeaders/model/DonationRequestResponse.dart';
import 'package:TALLeaders/model/ExploreModel.dart';
import 'package:TALLeaders/model/LoginModel.dart';
import 'package:TALLeaders/model/ShareModel.dart' hide Data;
import 'package:TALLeaders/model/UserModel.dart' hide Data;
import 'package:TALLeaders/model/location_model.dart' hide Datum;
import 'package:TALLeaders/model/vote_leader_model.dart' as vote_leader;
import 'package:TALLeaders/payload/fav_payload.dart';
import 'package:TALLeaders/payload/invite_payload.dart';
import 'package:TALLeaders/payload/like_unlike_payload.dart';
import 'package:TALLeaders/payload/login_payload.dart';
import 'package:TALLeaders/payload/user_update_payload.dart';
import 'package:TALLeaders/utilites/constants_Utils.dart';
import '../model/details_model.dart';
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
  static const String _forgot_password = "forgotpassword";
  static const String _change_password = "changepassword";
  static const String _verifyotp = "verifyotp";

  // Add new endpoint constants
  static const String _voteLeadersAction = "voteLeaders/action";
  static const String _voteLeaders = "users";
  static const String _cities = "cities";
  static const String changeUserName = "change/username";

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

  Future<CommonModel> likeUnlikeRequest(
    LikeUnlikePayload payload,
    String? token,
  ) async {
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

  Future<LoginModel> managePreferencesRequest(
    String? token,
    String? userId,
    UserUpdatePayload payload,
  ) async {
    return await service.put<LoginModel>(
      '$_user/$userId',
      payload.toJson(),
      (data) => LoginModel.fromJson(data),
      token: token,
    );
  }

  // In your repository
  Future<UserModel> getProfile(String uniqueId) async {
    try {
      print('Making API call to user endpoint with ID: $uniqueId');
      return await service.get<UserModel>(
        '$_user/$uniqueId',
        (data) => UserModel.fromJson(data),
      );
    } catch (e) {
      print('Repository error: $e');
      rethrow;
    }
  }

  // get cities
  Future<List<LocationModel>> fetchCities(String? keyword) async {
    final params = {'limit': 10, 'keyword': keyword};
    final data = await service.get<Map<String, dynamic>>(
      _cities,
      (data) => data,
      params: params,
    );
    return (data['data'] as List)
        .map((explore) => LocationModel.fromJson(explore))
        .toList();
  }

  Future<List<ExploreModel>> fetchRecommendations(
    String? uniqueId,
    String requestType,
    String language,
  ) async {
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
    return (data['data'] as List)
        .map((explore) => ExploreModel.fromJson(explore))
        .toList();
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
    return (data['data'] as List)
        .map((item) => ExploreModel.fromJson(item))
        .toList();
  }

  // Fetch donation requests
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
    return (data['data'] as List)
        .map((item) => DonationRequestResponse.fromJson(item))
        .toList();
  }

  Future<CommonModel> reminderPost(String requestId, String? token) async {
    return await service.post<CommonModel>(
      _reminder,
      {"requestId": requestId},
      (data) => CommonModel.fromJson(data),
      token: token,
    );
  }

  Future<DonationRequestResponseData> reminderPut(
    String requestId,
    String? token,
  ) async {
    return await service.put<DonationRequestResponseData>(
      '$_donationRequestResponse/$requestId',
      {"reminderSent": true},
      (data) => DonationRequestResponseData.fromJson(data),
      token: token,
    );
  }

  Future<Map<String, dynamic>> withdraw(String requestId, String? token) async {
    return await service.delete(
      '$_donationRequestResponse/$requestId',
      token: token,
    );
  }

  // Fetch vote leaders
  Future<List<vote_leader.Datum>> fetchVoteLeaders({
    required String profileVerificationStatus,
    required int limit,
    required int offset,
    required String userId,
    required String sortBy,
    required String sortOrder,
  }) async {
    final params = {
      'sourceOfSignup': 'talleaders',
      'isTALLeader': 'true',
      'limit': limit,
      'offset': offset,
      'profileVerificationStatus': profileVerificationStatus,
      'inactiveUsers': 'yes',
      'sortBy': sortBy,
      'sortOrder': sortOrder,
    };

    final data = await service.get<Map<String, dynamic>>(
      _voteLeaders,
      (data) => data,
      params: params,
    );
    return (data['data'] as List)
        .map((item) => vote_leader.Datum.fromJson(item))
        .toList();
  }

  // Like a leader
  Future<CommonModel> likeLeader(String? token, String id) async {
    return await service.put<CommonModel>(
      'user/$id/like',
      null, // No payload
      (data) => CommonModel.fromJson(data),
      token: token,
    );
  }

  // unLike a leader
  Future<CommonModel> unLikeLeader(String? id, String token) async {
    final data = await service.delete('user/$id/unlike', token: token);
    return CommonModel.fromJson(data);
  }

  // Approve or reject a leader
  Future<CommonModel> approveRejectLeader(
    String leaderId,
    Map<String, dynamic> payload,
    String? token,
  ) async {
    return await service.post<CommonModel>(
      '$_voteLeadersAction/$leaderId/approve-reject',
      payload,
      (data) => CommonModel.fromJson(data),
      token: token,
    );
  }

  // update profile
  Future<LoginModel> updateProfileRequest(
    String? token,
    String? userId,
    Map<String, dynamic> payload,
  ) async {
    return await service.put<LoginModel>(
      '$_user/$userId',
      payload,
      (data) => LoginModel.fromJson(data),
      token: token,
    );
  }

  // update profile URL
  Future<LoginModel> updateProfileUrlRequest(
    String? token,
    Map<String, dynamic> payload,
  ) async {
    return await service.post<LoginModel>(
      changeUserName,
      payload,
      (data) => LoginModel.fromJson(data),
      token: token,
    );
  }

  // update public profile
  Future<LoginModel> updatePublicProfileRequest(
    String? token,
    Map<String, dynamic> payload,
    String? userId,
  ) async {
    return await service.put<LoginModel>(
      '$_user/$userId',
      payload,
      (data) => LoginModel.fromJson(data),
      token: token,
    );
  }

  // update Honors and Awards
  Future<LoginModel> updateHonorsAndAwards(
    String? token,
    Map<String, dynamic> payload,
    String? userId,
  ) async {
    return await service.put<LoginModel>(
      '$_user/$userId/achievements',
      payload,
      (data) => LoginModel.fromJson(data),
      token: token,
    );
  }

  // delete Honors and Awards
  Future<Map<String, dynamic>> deleteHonorsAndAwards(
    String? userId,
    String? requestId,
    String? token,
  ) async {
    return await service.delete(
      '$_user/$userId/achievements/$requestId',
      token: token,
    );
  }

  // update Experience
  Future<LoginModel> updateExperience(
    String? token,
    Map<String, dynamic> payload,
    String? userId,
  ) async {
    return await service.put<LoginModel>(
      '$_user/$userId/experience',
      payload,
      (data) => LoginModel.fromJson(data),
      token: token,
    );
  }

  // delete Experience
  Future<Map<String, dynamic>> deleteExperience(
    String? userId,
    String? requestId,
    String? token,
  ) async {
    return await service.delete(
      '$_user/$userId/experience/$requestId',
      token: token,
    );
  }

  // get public profile
  Future<Data> getPublicProfile(String uniqueId) async {
    try {
      print('Making API call to user endpoint with ID: $uniqueId');
      return await service.get<Data>(
        '$_user/$uniqueId',
        (data) => Data.fromJson(data),
      );
    } catch (e) {
      print('Repository error: $e');
      rethrow;
    }
  }

  // change password
  Future<LoginModel> changePassword(
    String? token,
    Map<String, dynamic> payload,
  ) async {
    return await service.post<LoginModel>(
      'change/user/password',
      payload,
      (data) => LoginModel.fromJson(data),
      token: token,
    );
  }

  // change password
  Future<LoginModel> disbandUser(
    String? token,
    Map<String, dynamic> payload,
  ) async {
    return await service.post<LoginModel>(
      'disband/user',
      payload,
      (data) => LoginModel.fromJson(data),
      token: token,
    );
  }

  // details page data
  Future<List<Datum>> getDetailsData({
    required String uniqueId,
    required String requestType,
    required String requestId,
  }) async {
    final params = {
      'requestType': requestType,
      'donationRequestId': requestId,
      'userId': uniqueId,
    };

    final response = await service.get<Map<String, dynamic>>(
      _donationRequestResponse,
      (data) => data,
      params: params,
    );

    print('params : $params');

    if (response['data'] is List) {
      return (response['data'] as List)
          .map((item) => Datum.fromJson(item))
          .toList();
    } else {
      return [];
    }
  }


  // connect logic
  Future<ConnectResponse> connectRequest(
      String? token,
      Map<String, dynamic> payload,
      ) async {
    return await service.post<ConnectResponse>(
      _donationRequestResponse,
      payload,
          (data) => ConnectResponse.fromJson(data),
      token: token,
    );
  }


  // report request
  Future<CommonModel> reportSpam(
      String? token,
      Map<String, dynamic> payload,
      String? reportId,
      ) async {
    return await service.put<CommonModel>(
      '$_donationRequest/$reportId',
      payload,
          (data) => CommonModel.fromJson(data),
      token: token,
    );
  }



  // get find user by email
  Future<LoginModel> findUserEmail(String email) async {
    try {
      print('Making API call to user endpoint with ID: $email');
      return await service.get<LoginModel>(
          '$_user/data/$email',
            (data) => LoginModel.fromJson(data),
            params: {'secondaryEmail': true},
      );
    } catch (e) {
      print('Repository error: $e');
      rethrow;
    }
  }

  // sendPasswordResetOtp
  Future<CommonModel> sendPasswordResetOtp(Map<String, dynamic> payload) async {
    try {
      final res = await service.post<CommonModel>(
        _forgot_password,
        payload,
            (data) => CommonModel.fromJson(data),
      );
      return res;
    } catch (e) {
      print('sendPasswordResetOtp error: $e');
      rethrow;
    }
  }

  // verify OTP
  Future<CommonModel> verifyOtp(Map<String, dynamic> payload) async {
    try {
      final res = await service.post<CommonModel>(
        _verifyotp,
        payload,
            (data) => CommonModel.fromJson(data),
      );
      return res;
    } catch (e) {
      print('sendPasswordResetOtp error: $e');
      rethrow;
    }
  }

  // verify OTP
  Future<CommonModel> resetPassword(Map<String, dynamic> payload) async {
    try {
      final res = await service.post<CommonModel>(
        _change_password,
        payload,
            (data) => CommonModel.fromJson(data),
      );
      return res;
    } catch (e) {
      print('sendPasswordResetOtp error: $e');
      rethrow;
    }
  }
}
