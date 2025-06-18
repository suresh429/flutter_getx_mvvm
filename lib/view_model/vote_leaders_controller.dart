import 'package:get/get.dart';
import '../model/LoginModel.dart';
import '../model/vote_leader_model.dart';
import '../service/main_repository.dart';
import '../utilites/constants_utils.dart';
import '../utilites/error_handler.dart';
import '../payload/like_unlike_payload.dart';

class VoteLeadersController extends GetxController {
  RxList<Datum> requests = <Datum>[].obs;
  RxBool isLoading = false.obs;
  RxBool hasMoreData = true.obs;
  int offset = 0;
  final int limit = 5;

  RxString title = ''.obs;
  var subtitle = ''.obs;
  final errorMessage = ''.obs;
  Rx<LoginModel?> loginResponse = Rx<LoginModel?>(null); // Initialize with a default value

  final MainRepository repository = MainRepository();

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

    try {
      final List<Datum> newRequests = await repository.fetchVoteLeaders(
        profileVerificationStatus: '0',
        limit: limit,
        offset: offset,
        userId: loginResponse.value?.data?.uniqueId ?? '',
        sortBy: 'createdAt',
        sortOrder: '-1',
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




  // Like or unlike a leader
  Future<void> likeLeader(String id,token) async {
    if (loginResponse.value == null) {
      errorMessage.value = 'User not logged in';
      Get.snackbar('Error', errorMessage.value);
      return;
    }

    final currentUserId = loginResponse.value!.data!.uniqueId;
    final leaderIndex = requests.indexWhere((leader) => leader.id == id);

    if (leaderIndex == -1) {
      errorMessage.value = 'Leader not found';
      Get.snackbar('Error', errorMessage.value);
      return;
    }

    final leader = requests[leaderIndex];
    final isCurrentlyLiked = leader.userLikes?.any((like) => like.id == currentUserId);

    try {
      if (isCurrentlyLiked!) {
        // Unlike: Send DELETE request
        await repository.unLikeLeader(id, token);
        // Update likeCount by removing the current user's like
        final updatedLikeCount = List<UserLike>.from(leader.userLikes!)
          ..removeWhere((like) => like.id == currentUserId);
        requests[leaderIndex] = leader.copyWith(userLikes: updatedLikeCount);
      } else {
        // Like: Send PUT request
        await repository.likeLeader(id, token);
        // Update likeCount by adding the current user's like
        final updatedLikeCount = List<UserLike>.from(leader.userLikes!)..add(UserLike(id: currentUserId));
        requests[leaderIndex] = leader.copyWith(userLikes: updatedLikeCount);
      }
      requests.refresh(); // Notify UI of changes
    } catch (e) {
      String errorMsg = await ErrorHandler.handleError(e);
      errorMessage.value = errorMsg;
      Get.snackbar('Error', errorMsg);
    }
  }

  void onComment(Datum leader) {
    // Implement comment functionality
    print('Commenting on leader: ${leader.displayName}');
  }

  void approveLeader(String id) {
    // Implement approve functionality
    print('Approving leader with ID: $id');
  }

  void resetSelection() {

    requests.clear();
    offset = 0;
    hasMoreData.value = true;
    fetchRequests();
  }

}