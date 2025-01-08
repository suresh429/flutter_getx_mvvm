import 'package:flutter_getx_mvvm/model/DonationRequestResponse.dart';
import 'package:get/get.dart';
import '../model/LoginModel.dart';
import '../service/main_repository.dart';
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
  Rx<LoginModel?> loginResponse = Rx<LoginModel?>(null); // Initialize with a default value

  final MainRepository repository = MainRepository();

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
  void onInit() {
    super.onInit();
    initializeController();
  }

  @override
  void onReady() {
    super.onReady();
    resetSelection();
  }

  // initialize
  Future<void> initializeController() async {
    loginResponse = Rx<LoginModel?>(await ConstantsUtils.getStoredLoginResponse());
    if (loginResponse.value != null) {
      resetSelection();
      await fetchRequests();
    } else {
      errorMessage.value = 'Failed to load login response';
    }
  }

  // Method to fetch the requests
  Future<void> fetchRequests() async {
    if (isLoading.value || !hasMoreData.value || loginResponse.value == null) return;

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

    try {
      final List<DonationRequestResponse> newRequests = await repository.fetchActivityRequests(
        requestTypes: requestTypeData,
        limit: limit,
        offset: offset,
        userId: loginResponse.value?.data?.uniqueId ?? '',
        requestStatus: requestStatusData,
      );

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

  Future<void> reminderPost(String requestId) async {
    try {
      if (isLoading.value || loginResponse.value == null) return;

      isLoading(true);

      final dataResponse = await repository.reminderPost(requestId, loginResponse.value?.data?.tokenDetail?.token);

      if (dataResponse.status == 'success' && dataResponse.data != null) {
        // Update the reminderSent field for the corresponding request
        final index = requests.indexWhere((request) => request.id == requestId);
        if (index != -1) {
          requests[index].reminderSent.value = true;
        }
       // ConstantsUtils.showSuccessSnackbar('post ${dataResponse.message}');
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

  Future<void> reminderPut(String requestId) async {
    try {
      if (isLoading.value || loginResponse.value == null) return;

      isLoading(true);

      final dataResponse = await repository.reminderPut(requestId, loginResponse.value?.data?.tokenDetail?.token);

      if (dataResponse.status == 'success' && dataResponse.data != null) {
        ConstantsUtils.showSuccessSnackbar('put ${dataResponse.message}');
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


  Future<void> withdraw(String requestId) async {
    try {
      if (isLoading.value || loginResponse.value == null) return;

      isLoading(true);

      final dataResponse = await repository.withdraw(requestId, loginResponse.value?.data?.tokenDetail?.token);

      if (dataResponse['status'] == 'success' && dataResponse['data'] != null) {
        ConstantsUtils.showSuccessSnackbar('withdraw ${dataResponse['message']}');

        removeRequest(requestId);

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

  // Method to remove a request by its ID
  void removeRequest(String requestId) {
    requests.removeWhere((request) => request.id == requestId);
  }
}