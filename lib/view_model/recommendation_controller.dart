import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/ExploreModel.dart';
import '../service/api_service.dart';
import '../utilites/error_handler.dart';

class RecommendationController extends GetxController {
  final recommendations = <ExploreModel>[].obs;
  final isLoading = false.obs;
  var errorMessage = ''.obs;

  final ApiService _apiService = ApiService();
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    // Fetch data initially
    fetchData();

    // Listen to connectivity changes
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) async {
      if (result != ConnectivityResult.none) {
        await fetchData();  // Attempt to fetch data if connection is restored
      } else {
        errorMessage.value = 'No internet connection. Please check your network settings.';
      }
    });
  }

  // Method to fetch data from API
  Future<void> fetchData() async {
    // Check connectivity before making API request
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      errorMessage.value = 'No internet connection. Please check your network settings.';
      return; // Skip API call if no internet
    }

    try {
      isLoading(true);
      errorMessage.value = ''; // Reset previous errors

      // Fetch recommendations from the API
      final fetchedRecommendations = await _apiService.fetchRecommendations();
      recommendations.assignAll(fetchedRecommendations);
    } catch (e) {
      // Use the updated error handler
      String errorMsg = await ErrorHandler.handleError(e);
      errorMessage.value = errorMsg;
    } finally {
      isLoading(false);
    }
  }
}
