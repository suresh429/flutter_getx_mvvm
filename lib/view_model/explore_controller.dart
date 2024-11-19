import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/payload/fav_payload.dart';
import 'package:get/get.dart';
import '../model/ExploreModel.dart';
import '../service/api_service.dart';
import '../service/network_checker.dart';
import '../utilites/constants.dart';
import '../utilites/error_handler.dart';

class ExploreController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var errorMessage = ''.obs;

  // Observable list to hold explore data
  final exploreData = <ExploreModel>[].obs;

  // Loading state for each tab
  final isLoading = <int, bool>{}.obs;

  // Tab controller
  late TabController tabController;

  // Track the selected tab index
  var selectedIndex = 0.obs;

  // Track the current page for each tab (pagination)
  var tabPage = <int, int>{}.obs;

  // Store if there is more data to fetch for each tab
  var tabHasMore = <int, bool>{}.obs;

  // Store data for each tab
  var tabData = <int, List<ExploreModel>>{}.obs;

  // Scroll controllers for each tab
  final scrollControllers = <int, ScrollController>{}.obs;

  final List<String> tabTitles = [
    "All",
    "Mentoring",
    "Board Member",
    "Event Speaker",
    "Podcast",
  ];

  final ApiService apiService =
      ApiService(); // Create an instance of ApiService

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabTitles.length, vsync: this);

    // Initialize scroll controllers for each tab
    for (int i = 0; i < tabTitles.length; i++) {
      scrollControllers[i] = ScrollController();
      scrollControllers[i]?.addListener(() {
        // Check if the user has scrolled to the bottom
        if (scrollControllers[i]?.position.pixels ==
            scrollControllers[i]?.position.maxScrollExtent) {
          fetchDataForTab(i);
        }
      });

      // Initialize pagination state for each tab
      tabPage[i] ??= 1;
      tabHasMore[i] ??= true;
      tabData[i] ??= [];
      isLoading[i] ??= false;
    }

    // Load data for the initially selected tab ("All" or index 0)
    fetchDataForTab(0);

    // Update selectedIndex whenever the tab changes
    tabController.addListener(() {
      final newIndex = tabController.index;
      if (newIndex != selectedIndex.value) {
        resetPaginationForTab(newIndex); // Reset pagination when switching tabs
      }
      selectedIndex.value = newIndex;
      fetchDataForTab(newIndex);
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  // Method to get the request type data based on the tab title
  String getRequestTypeData(String tabTitle) {
    switch (tabTitle) {
      case "Podcast":
        return buildRequestTypeData(["podcast"]);
      case "Mentoring":
        return buildRequestTypeData(["mentoring"]);
      case "Board Member":
        return buildRequestTypeData(["board member"]);
      case "Event Speaker":
        return buildRequestTypeData(["eventSpeaker"]);
      default:
        return buildRequestTypeData(
            ["board member", "podcast", "mentoring", "eventSpeaker"]);
    }
  }

  // Method to fetch data for a specific tab and page
  Future<void> fetchDataForTab(int tabIndex) async {
    if (isLoading[tabIndex] == true || !tabHasMore[tabIndex]!) {
      return; // Don't fetch if already loading or no more data
    }

    // Set loading state to true for the specific tab
    isLoading[tabIndex] = true;

    // Get the request type data based on the selected tab
    String requestTypeData = getRequestTypeData(tabTitles[tabIndex]);

    // Calculate the offset for pagination: offset = (page - 1) * limit
    int offset = (tabPage[tabIndex]! - 1) * 5; // Assuming 'limit' is 5

    try {
      // Fetch data from the API for the selected tab and page
      List<ExploreModel> fetchedData = await apiService.fetchExploreRequests(
        requestTypes: requestTypeData, // Pass the specific tab type as a list
        limit: 5, // Assuming a limit of 5 items per page
        offset: offset, // Pass the calculated offset
        page: tabPage[tabIndex]!, // Pass the current page number
      );

      // Update loading state after the data is fetched
      isLoading[tabIndex] = false;

      if (fetchedData.isEmpty) {
        tabHasMore[tabIndex] = false; // No more data for this tab
      } else {
        // Get the current data for this tab
        final currentData = tabData[tabIndex] ?? [];

        // Filter out duplicates based on a unique identifier, such as `id`
        final uniqueData = fetchedData.where((newItem) {
          return !currentData
              .any((existingItem) => existingItem.id == newItem.id);
        }).toList();

        // Append only unique items to the current list
        tabData[tabIndex]?.addAll(uniqueData);

        // Increment the page for the next fetch
        tabPage[tabIndex] = tabPage[tabIndex]! + 1;
      }
    } catch (e) {
      // Update loading state after the data is fetched
      isLoading[tabIndex] = false;
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }


  // add to fav
  Future<void> addToFav(List<String> requestId, String type, String userId) async {
    if (await NetworkChecker.isConnected()) {
      final payload = FavPayload(
        requestId: requestId,
        type: type,
        userId: userId,
      );
      if (kDebugMode) {
        print("payload  :   $payload");
      }
      try {
        // isLoading(true);

        // Call the login method in ApiService with your specific payload
        await apiService.addToFavorite(payload);

      } catch (e) {
        if (e is DioException) {
          errorMessage.value = await ErrorHandler.handleError(e);
        } else {
          errorMessage.value = 'An unexpected error occurred: $e';
        }

      } finally {
        // isLoading(false);
      }
    } else {
      errorMessage.value = "No internet connection";
    }

    Get.snackbar('',errorMessage.value);
  }


  // Reset pagination when switching to a new tab
  void resetPaginationForTab(int tabIndex) {
    tabPage[tabIndex] = 1;
    tabHasMore[tabIndex] = true;
    tabData[tabIndex]?.clear(); // Clear data to start fresh when switching tabs
  }
}
