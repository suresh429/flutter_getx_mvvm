import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/ExploreModel.dart';
import '../model/LoginModel.dart';
import '../payload/fav_payload.dart';
import '../payload/like_unlike_payload.dart';
import '../service/ConnectivityService.dart';
import '../service/main_repository.dart';
import '../utilites/constants_Utils.dart';
import '../utilites/error_handler.dart';

class ExploreController extends GetxController with GetSingleTickerProviderStateMixin {
  final databaseReviews = FirebaseDatabase.instance.ref('conversations');

  RxString title = ''.obs;
  var subtitle = ''.obs;
  final errorMessage = ''.obs;
  final exploreData = <ExploreModel>[].obs; // Observable list to hold explore data
  final isLoading = <int, bool>{}.obs; // Loading state for each tab
  late TabController tabController;
  late LoginModel? loginResponse;
  var selectedIndex = 0.obs; // Track the selected tab index
  var tabPage = <int, int>{}.obs; // Track the current page for each tab
  var tabHasMore =
      <int, bool>{}.obs; // Store if there is more data to fetch for each tab
  var tabData = <int, List<ExploreModel>>{}.obs; // Store data for each tab
  final scrollControllers =
      <int, ScrollController>{}.obs; // Scroll controllers for each tab

  final MainRepository repository = MainRepository(); // API service instance
  final ConnectivityService connectivityService = Get.find<ConnectivityService>(); // Connectivity service instance

  final List<String> tabTitles = [
    "All",
    "Mentoring",
    "Board Member",
    "Event Speaker",
    "Podcast",
  ];

  @override
  void onInit() async {
    super.onInit();
    loginResponse = await ConstantsUtils.getStoredLoginResponse();
    tabController = TabController(length: tabTitles.length, vsync: this);

    // Initialize scroll controllers and pagination for each tab
    for (int i = 0; i < tabTitles.length; i++) {
      scrollControllers[i] = ScrollController();
      scrollControllers[i]?.addListener(() {
        if (scrollControllers[i]?.position.pixels ==
            scrollControllers[i]?.position.maxScrollExtent) {
          fetchDataForTab(i); // Fetch more data on scroll to the bottom
        }
      });

      tabPage[i] ??= 1;
      tabHasMore[i] ??= true;
      tabData[i] ??= [];
      isLoading[i] ??= false;
    }

    // Fetch data for the initially selected tab
    resetPaginationForTab(0);
    await fetchDataForTab(0);

    // Tab selection listener
    tabController.addListener(() async {
      if (tabController.indexIsChanging) return;
      final newIndex = tabController.index;
      if (newIndex != selectedIndex.value) {
        resetPaginationForTab(newIndex);
        selectedIndex.value = newIndex;
        await checkAndFetchData(newIndex); // Fetch data when tab changes
      }
    });

    // Check connectivity on initialization and whenever it changes
    checkAndFetchData(selectedIndex.value);
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

  @override
  void onReady() {
    super.onReady();
    resetTab();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  Future<void> checkAndFetchData(int tabIndex) async {
    // Check connectivity before making API call
    var connectivityResult = connectivityService.isConnected.value;
    if (!connectivityResult) {
      errorMessage.value =
      'No internet connection. Please check your network settings.';
      print(errorMessage.value); // Debugging log
      return; // Skip API call if no internet
    }

    // Fetch data for the given tab if connection is restored
    await fetchDataForTab(tabIndex);
  }

  Future<void> fetchDataForTab(int tabIndex) async {
    print('Fetching data for tab index: $tabIndex'); // Debugging log
    // Check connectivity before making API call
    var connectivityResult = connectivityService.isConnected.value;
    if (!connectivityResult) {
      errorMessage.value =
      'No internet connection. Please check your network settings.';
      print(errorMessage.value); // Debugging log
      return; // Skip API call if no internet
    }

    if (isLoading[tabIndex] == true || !tabHasMore[tabIndex]!) {
      print(
          'Skipping fetch. isLoading: ${isLoading[tabIndex]}, tabHasMore: ${tabHasMore[tabIndex]}'); // Debugging log
      return; // Skip if already loading or no more data
    }

    isLoading[tabIndex] = true;
    print('isLoading set to true for tab index: $tabIndex'); // Debugging log

    String requestTypeData = getRequestTypeData(tabTitles[tabIndex]);
    int offset = (tabPage[tabIndex]! - 1) * 5;

    try {
      List<ExploreModel> fetchedData = await repository.fetchExploreRequests(
          requestTypes: requestTypeData,
          limit: 5,
          offset: offset,
          page: tabPage[tabIndex]!,
          userId: loginResponse?.data?.uniqueId, title: title.value);

      print(
          'Fetched data length for tab index $tabIndex: ${fetchedData.length}'); // Debugging log

      if (fetchedData.isEmpty) {
        tabHasMore[tabIndex] = false; // No more data for this tab
        print('No more data for tab index: $tabIndex'); // Debugging log
      } else {
        final currentData = tabData[tabIndex] ?? [];
        final uniqueData = fetchedData.where((newItem) {
          return !currentData
              .any((existingItem) => existingItem.id == newItem.id);
        }).toList();

        // Ensure the tabData is initialized properly for this tab
        if (tabData[tabIndex] == null) {
          tabData[tabIndex] = [];
        }

        tabData[tabIndex]
            ?.addAll(uniqueData); // Add new data to tab's data list
        tabPage[tabIndex] = tabPage[tabIndex]! + 1;

        // 🔥 Attach Firebase comment count listeners
        for (var item in uniqueData) {
          listenCommentCount(item);
        }

        print('Unique data added for tab index $tabIndex: ${uniqueData.length}'); // Debugging log
      }

      // Clear error message on successful fetch
      errorMessage.value = '';
      // Update the UI to reflect the changes in data
      update(); // Or tabData.refresh() if you're observing the tabData
      print('UI updated for tab index: $tabIndex'); // Debugging log
    } catch (e) {
      String errorMsg = await ErrorHandler.handleError(e);
      errorMessage.value = errorMsg;
      print(errorMessage.value); // Debugging log
    } finally {
      isLoading[tabIndex] = false;
      print('isLoading set to false for tab index: $tabIndex'); // Debugging log
    }
  }

  // Add to favorite method (unchanged)
  Future<void> addToFav(List<String> requestId, String type) async {
    final payload = FavPayload(
      requestId: requestId,
      type: type,
      userId: loginResponse?.data?.uniqueId,
    );
    if (kDebugMode) {
      print("payload  :   $payload");
    }
    try {
      await repository.addToFavorite(
          payload, loginResponse?.data?.tokenDetail?.token);
    } catch (e) {
      String errorMessage = await ErrorHandler.handleError(e);
      ConstantsUtils.showErrorSnackbar(errorMessage);
    }
  }

  String getRequestTypeData(String tabTitle) {
    switch (tabTitle) {
      case "Podcast":
        return ConstantsUtils.buildRequestTypeData(["podcast"]);
      case "Mentoring":
        return ConstantsUtils.buildRequestTypeData(["mentoring"]);
      case "Board Member":
        return ConstantsUtils.buildRequestTypeData(["board member"]);
      case "Event Speaker":
        return ConstantsUtils.buildRequestTypeData(["eventSpeaker"]);
      default:
        return ConstantsUtils.buildRequestTypeData(
            ["board member", "podcast", "mentoring", "eventSpeaker"]);
    }
  }

  void resetPaginationForTab(int tabIndex) {
    tabPage[tabIndex] = 1; // Reset to first page
    tabHasMore[tabIndex] = true; // Allow more data
    tabData[tabIndex]?.clear(); // Clear the existing data
    isLoading[tabIndex] = false; // Set loading state to false
  }

  // Method to reset the tab and load data
  void resetTab() {
    final args = Get.arguments as Map<String, String>?;

    title.value = args?['title'] ?? 'Explore Requests';
    subtitle.value = args?['subtitle'] ??
        'Unleash your expertise on epic missions! Spark lasting change!';

    tabController.animateTo(0); // Reset to the first tab (index 0)
    selectedIndex.value = 0; // Update the selected index
    resetPaginationForTab(0);
    fetchDataForTab(0); // Fetch data for the first tab
  }

  Future<void> likeUnlikeRequest(String reqId, String typeStatus) async {
    final payload = LikeUnlikePayload(
      requestId: reqId,
      type: typeStatus,
      userId: loginResponse!.data!.uniqueId.toString(),
    );
    print("likeUnlikeRequest :  $payload");
    try {
      final dataResponse = await repository.likeUnlikeRequest(
          payload, loginResponse?.data?.tokenDetail?.token);

      if (dataResponse.status == 'success' && dataResponse.data != null) {
        ConstantsUtils.showSuccessSnackbar(dataResponse.message);
      } else {
        throw Exception("data is missing or invalid");
      }
    } catch (e) {
      String errorMsg = await ErrorHandler.handleError(e);
      ConstantsUtils.showErrorSnackbar(errorMsg);
    } finally {}
  }

  Future<void> shareRequest(String reqId) async {
    try {
      if (loginResponse?.data?.tokenDetail?.token == null) {
        throw Exception("Authorization token is missing.");
      }

      final dataResponse = await repository.shareRequest(
        loginResponse!.data!.tokenDetail!.token!,
        reqId,
      );

      if (dataResponse.statusCode == 200) {
        ConstantsUtils.showSuccessSnackbar(dataResponse.message);
      } else {
        throw Exception("Failed to share request: ${dataResponse.message}");
      }
    } catch (e) {
      String errorMsg = await ErrorHandler.handleError(e);
      ConstantsUtils.showErrorSnackbar(errorMsg);
    }
  }
}