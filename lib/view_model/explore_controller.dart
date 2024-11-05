import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../model/ExploreModel.dart';
import '../service/api_service.dart';
import '../service/network_checker.dart';
import '../utilites/error_handler.dart';

class RecommendationController extends GetxController {
  final recommendations = <ExploreModel>[].obs;
  final isLoading = false.obs;
  var errorMessage = ''.obs;
  // Instance of ApiService
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  Future<void> fetchData() async {
    if (await NetworkChecker.isConnected()) {
      try {
        isLoading(true);
        final fetchedRecommendations = await _apiService.fetchRecommendations();

        print("Fetched recommendations: $fetchedRecommendations"); // Log fetched data
        recommendations.assignAll(fetchedRecommendations);

        // Check if recommendations are now populated
        print("Recommendations after assignment: ${recommendations}");
      } catch (e) {
        if (e is DioException) {
          errorMessage.value = ErrorHandler.handleError(e);
        } else {
          errorMessage.value = 'An unexpected error occurred: $e';
        }
      } finally {
        isLoading(false);
      }
    } else {
      errorMessage.value = "No internet connection";
    }
  }}