import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/ExploreModel.dart';
import '../model/LoginModel.dart';
import '../payload/invite_payload.dart';
import '../service/ConnectivityService.dart';
import '../service/main_repository.dart';
import '../utilites/constants_Utils.dart';
import '../utilites/error_handler.dart';

class RecommendationController extends GetxController {
  final databaseReviews = FirebaseDatabase.instance.ref('conversations');
  final recommendations = <ExploreModel>[].obs;
  final isLoading = false.obs;
  var errorMessage = ''.obs;
  late String requestType = '';
  late String requestLanguage = '';

  final MainRepository repository = MainRepository();
  final ConnectivityService connectivityService = Get.put(ConnectivityService());
  final storage = GetStorage();
  late LoginModel? loginResponse;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();

  var firstNameError = RxnString();
  var lastNameError = RxnString();
  var emailError = RxnString();

  @override
  Future<void> onInit() async {
    super.onInit();

    initializeController();
  }

  void listenCommentCount(ExploreModel explore) {
    databaseReviews.child(explore.id).onValue.listen((event) {
      int count = 0;
      final dataSnapshot = event.snapshot;
      if (dataSnapshot.exists) {
        count = dataSnapshot.children.length;
      }
      explore.commentsCount.value = count;
      print('Comment count updated for ${explore.id}: $count'); // Debugging log
    });
  }


  // initialize
  Future<void> initializeController() async {
    loginResponse = await ConstantsUtils.getStoredLoginResponse();
    if (loginResponse?.data?.uniqueId != null) {
      // Proceed with fetching profile data only if uniqueId is available
      await getProfileData(loginResponse?.data?.uniqueId);
    }

    // Fetch data initially if connected
    if (connectivityService.isConnected.value) {
      fetchData(loginResponse?.data?.uniqueId);
    }

    // Listen to connectivity changes
    connectivityService.isConnected.listen((isConnected) async {
      if (isConnected) {
        // Attempt to fetch data if connection is restored
        await fetchData(loginResponse?.data?.uniqueId);
      } else {
        errorMessage.value =
        'No internet connection. Please check your network settings.';
      }
    });
  }

  // get profile
  Future<void> getProfileData(String? uniqueId) async {
    // Check connectivity before making API request
    if (!connectivityService.isConnected.value) {
      errorMessage.value =
      'No internet connection. Please check your network settings.';
      return; // Skip API call if no internet
    }

    try {
      isLoading(true);
      errorMessage.value = ''; // Reset previous errors

      // Debugging: Print statement before the API call
      print('Calling getProfile with uniqueId: $uniqueId');

      // Fetch profile data from the API
      final getProfile = await repository.getProfile(uniqueId!);

      // Debugging: Print statement after the API call
      print('Profile Data: ${getProfile.data}');

      // Check if the data is not null
      // Extract and set requestType and requestLanguage
      requestType = ConstantsUtils.buildRequestTypeData(getProfile.data.talLeaderPreferences);
      requestLanguage = getProfile.data.languagePreferences.join(',') ?? '';

      // Debugging: Print the parsed values
      print('requestType: $requestType');
      print('requestLanguage: $requestLanguage');
        } catch (e) {
      // Use the updated error handler
      String errorMsg = await ErrorHandler.handleError(e);
      errorMessage.value = errorMsg;
    } finally {
      isLoading(false);
    }
  }

  // validation
  void setErrorMessages(String firstName, String lastName, String email) {
    firstNameError.value = firstName.isEmpty ? 'First Name is required' : null;
    lastNameError.value = lastName.isEmpty ? 'Last Name is required' : null;
    emailError.value = email.isEmpty ? 'Email is required' : null;
  }

  // invite member
  Future<void> inviteMember(BuildContext context) async {
    final firstName = firstNameController.text;
    final lastName = lastNameController.text;
    final email = emailController.text;

    if (firstName.isEmpty || lastName.isEmpty || email.isEmpty) {
      setErrorMessages(firstName, lastName, email);
      return;
    }

    final payload = InvitePayload(
      email: email,
      firstName: firstName,
      lastName: lastName,
    );

    try {
      if (isLoading.value) return;

      isLoading(true);

      final dataResponse = await repository.inviteMember(
          payload, loginResponse?.data?.tokenDetail?.token);

      if (dataResponse.status == 'success' && dataResponse.data != null) {
        ConstantsUtils.showSuccessSnackbar(dataResponse.message);
        Navigator.pop(context);
      } else {
        throw Exception("data is missing or invalid");
      }
    } catch (e) {
      String errorMsg = await ErrorHandler.handleError(e);
      ConstantsUtils.showErrorSnackbar(errorMsg);
    } finally {
      isLoading(false);
    }
  }

  // Method to fetch data from API
  Future<void> fetchData(String? uniqueId) async {
    // Check connectivity before making API request
    if (!connectivityService.isConnected.value) {
      errorMessage.value =
      'No internet connection. Please check your network settings.';
      return; // Skip API call if no internet
    }

    try {
      isLoading(true);
      errorMessage.value = ''; // Reset previous errors

      // Fetch recommendations from the API
      final fetchedRecommendations =
      await repository.fetchRecommendations(uniqueId, requestType, requestLanguage);
      recommendations.assignAll(fetchedRecommendations);

      // 🔥 Attach Firebase comment count listeners
      for (var item in fetchedRecommendations) {
        listenCommentCount(item);
      }

    } catch (e) {
      // Use the updated error handler
      String errorMsg = await ErrorHandler.handleError(e);
      errorMessage.value = errorMsg;
    } finally {
      isLoading(false);
    }
  }
}