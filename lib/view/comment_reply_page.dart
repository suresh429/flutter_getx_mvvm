import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/RevieModel.dart';
import '../view_model/details_page_controller.dart';
import '../utilites/constants_Utils.dart';

class CommentReplyPage extends StatelessWidget {
  final TextEditingController replyController = TextEditingController();
  final DetailsPageController controller = Get.find<DetailsPageController>();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final String requestId = args['exploreId'];
    final String reviewId = args['reviewId'];
    print("requestId: $requestId $reviewId");

    // Load replies on open
    // Run after the first build frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchReplyComments(requestId, reviewId);
    });

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Reply'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Reply List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.replyComments.isEmpty) {
                return const Center(child: Text("No replies yet."));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: controller.replyComments.length,
                itemBuilder: (context, index) {
                  final comment = controller.replyComments[index];
                  return _buildCommentItem(comment, index, requestId, reviewId);
                },
              );
            }),
          ),
          // Reply input box
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: Colors.grey[200],
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: (controller.currentUserProfileUrl.isNotEmpty)
                        ? NetworkImage(controller.currentUserProfileUrl.value)
                        : const AssetImage('assets/profile_placeholder.png') as ImageProvider,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: TextField(
                        controller: replyController,
                        decoration: const InputDecoration(
                          hintText: "Reply...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.red.shade100,
                    child: IconButton(
                      icon: const Icon(Icons.send, color: Colors.red, size: 16),
                      onPressed: () {

                        if (replyController.text.isNotEmpty) {
                          controller.addReplyComment(requestId, reviewId, replyController.text);
                          replyController.clear();
                        } else {
                          Get.snackbar("Validation", "Please type a comment...");
                        }
                      },
                      padding: EdgeInsets.zero,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCommentItem(
      ReviewModel comment,
      int index,
      String requestId,
      String reviewId,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: (comment.senderProfileImageUrl?.isNotEmpty ?? false)
                  ? NetworkImage(comment.senderProfileImageUrl!)
                  : const AssetImage('assets/profile_placeholder.png') as ImageProvider,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.senderName ?? "Anonymous",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ConstantsUtils.formatDateTimeComments(comment.whenSent),
                              style: const TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_horiz, size: 20, color: Colors.grey),
                        onSelected: (value) {
                          if (value == 'Edit') {
                            replyController.text = comment.text ?? "";
                            controller.editReviewModel.value = comment;
                            controller.isReplyEditClicked.value = true;

                          } else if (value == 'Delete') {
                            controller.deleteReplyComment(
                              requestId,
                              reviewId,
                              comment.id ?? '',
                            );
                          }
                        },
                        itemBuilder: (context) => const [
                          PopupMenuItem(value: "Delete", child: Text("Delete")),
                          PopupMenuItem(value: "Edit", child: Text("Edit")),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(comment.text ?? ""),
                ],
              ),
            ),
          ],
        ),
        const Divider(thickness: 1, height: 20),
      ],
    );
  }
}
