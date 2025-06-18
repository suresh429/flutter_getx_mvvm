import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/vote_leader_model.dart';
import '../service/ConnectivityService.dart';
import '../utilites/colors.dart';
import '../widget/check_internet_widget.dart';
import '../widget/custom_app_bar.dart';
import '../view_model/vote_leaders_controller.dart';
import '../widget/view_profile_bottomsheet.dart';
import '../widget/vote_leader_card.dart';
import 'comments_screen.dart';

class VoteLeadersScreen extends StatelessWidget {
  const VoteLeadersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final VoteLeadersController controller = Get.put(VoteLeadersController());
    final ConnectivityService connectivityService = Get.find<ConnectivityService>();
    final ScrollController scrollController = ScrollController();

    // Reset and fetch data on screen open
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.resetSelection();
    });

    // Infinite scroll listener
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          !controller.isLoading.value &&
          controller.hasMoreData.value) {
        controller.fetchRequests(); // Fetch more data without resetting
      }
    });

    return Scaffold(
      backgroundColor: ColorUtils.colorSurface,
      appBar: CustomAppBar(
        title: 'Vote New Leaders',
        subTitle: 'Your voice matters! Aid the new leader selection process. Vote & comment.',
        showFilterButton: false,
        onFilterPressed: () {},
      ),
      body: Obx(() {
        if (!connectivityService.isConnected.value) {
          return Center(
            child: CheckInternetWidget(
              onRetry: () {
                controller.resetSelection();
              },
            ),
          );
        }

        if (controller.isLoading.value && controller.requests.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          );
        }

        if (controller.requests.isEmpty) {
          return const Center(child: Text("No Activities found."));
        }

        return ListView.builder(
          controller: scrollController, // Attach scroll controller
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          itemCount: controller.requests.length,
          itemBuilder: (context, index) {
            final leader = controller.requests[index];

            return VoteLeaderCard(
              userId: controller.loginResponse.value?.data?.uniqueId.toString() ?? '',
              imageUrl: leader.imageUrl.toString(),
              name: "${leader.name!.firstName.toString()} ${leader.name!.lastName.toString()}",
              role: leader.currentRole.toString(),
              organization: leader.currentCompanyName.toString(),
              areasOfInterest: leader.areasOfInterest?.toList() ?? [],
              likeCount: leader.userLikes!.toList(),
              commentCount: leader.userComments!.length,
              isAdmin: false,
              onViewProfile: () => viewProfile(context, leader),
              onLike: () => controller.likeLeader(
                  leader.id.toString(), controller.loginResponse.value?.data?.tokenDetail?.token.toString()),
              onComment: () {
                Get.to(const CommentsScreen(), arguments: {
                  'title': 'Comments',
                  'subtitle': 'Leave a comment',
                  'id': leader.id.toString(),
                });
              } ,

              onApprove: () => controller.approveLeader(leader.id.toString()),
            );
          },
        );
      }),
    );
  }

  void viewProfile(BuildContext context, Datum data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      isDismissible: true, // Allow background tap to dismiss
      enableDrag: true, // Enable dragging
      builder: (bottomSheetContext) => DraggableScrollableSheet(
        initialChildSize: 0.8, // Start at 80% of screen height
        minChildSize: 0.5, // Minimum height when dragged down
        maxChildSize: 0.9, // Maximum height when dragged up
        builder: (context, scrollController) => ViewProfileBottomSheet(
          data: data,
          scrollController: scrollController,
          bottomSheetContext: bottomSheetContext, // Pass context for dismissal
        ),
      ),
    );
  }

}