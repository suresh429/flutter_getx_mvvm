import 'package:flutter_getx_mvvm/model/DonationRequestResponse.dart';
import 'package:get/get.dart';
import '../model/LoginModel.dart';
import '../service/api_service.dart';
import '../utilites/constants_Utils.dart';
import '../utilites/error_handler.dart';

class MyActivityController extends GetxController {
  RxList<DonationRequestResponse> requests = <DonationRequestResponse>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasMoreData = true.obs;
  int offset = 0;
  final int limit = 5;

  RxString title = ''.obs;
  var subtitle = ''.obs;
  final errorMessage = ''.obs;
  late Rx<LoginModel?> loginResponse;

  final ApiService apiService = ApiService();

  final List<String> typeList = [
    "All",
    "Mentoring",
    "Board Member",
    "Event Speaker",
    "Podcast",
  ];

  final List<String> statusList = [
    "All",
    "Approved",
    "Expired",
  ];

  Rx<String> selectedTypeList = 'All'.obs;
  Rx<String> selectedStatusList = 'All'.obs;

  @override
  void onInit() async {
    super.onInit();
    loginResponse = Rx<LoginModel?>(await ConstantsUtils.getStoredLoginResponse());
    Future.delayed(Duration.zero, fetchRequests);
  }

  @override
  void onReady() {
    super.onReady();
  }

  // Method to fetch the requests
  Future<void> fetchRequests() async {
    if (isLoading.value || !hasMoreData.value) return;

    isLoading.value = true;
    errorMessage.value = ''; // Reset error message

    String requestTypeData = 'board member,podcast,mentoring,eventSpeaker';
    String requestStatusData = '1,-4';

    if (selectedTypeList.value != 'All' && selectedTypeList.value.isNotEmpty) {
      requestTypeData = selectedTypeList.value;
    }

    switch (selectedStatusList.value) {
      case 'Approved':
        requestStatusData = '1';
        break;
      case 'Expired':
        requestStatusData = '-4';
        break;
      default:
        requestStatusData = '1,-4';
        break;
    }

    print("Request Status: $requestStatusData");
    print("Request Type: $requestTypeData");

    try {
      print('Fetching requests...');
      final List<DonationRequestResponse> newRequests = await apiService.fetchActivityRequests(
        requestTypes: requestTypeData,
        limit: limit,
        offset: offset,
        userId: loginResponse.value?.data?.uniqueId ?? '',
        requestStatus: requestStatusData,
      );

      print('Requests fetched successfully');
      if (newRequests.isEmpty) {
        hasMoreData.value = false;
      } else {
        requests.addAll(newRequests);
        offset += limit;
      }
    } catch (e) {
      String errorMsg = await ErrorHandler.handleError(e);
      errorMessage.value = errorMsg;
    } finally {
      isLoading.value = false;
    }
  }

  void resetSelection() {
    selectedTypeList.value = 'All';
    selectedStatusList.value = 'All';
    requests.clear();
    offset = 0;
    hasMoreData.value = true;
    fetchRequests();
  }
}