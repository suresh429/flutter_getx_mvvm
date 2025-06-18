import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/model/vote_leader_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
// Assuming you have a way to access the current user's ID, e.g., via GetX
import 'package:get/get.dart'; // If using GetX for state management

class VoteLeaderCard extends StatefulWidget {
  final String userId;
  final String imageUrl;
  final String name;
  final String role;
  final String organization;
  final List<String> areasOfInterest;
  final List<UserLike> likeCount;
  final int commentCount;
  final bool isAdmin;
  final VoidCallback onViewProfile;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onApprove;
  final VoidCallback? onReject;

  const VoteLeaderCard({
    required this.userId,
    required this.imageUrl,
    required this.name,
    required this.role,
    required this.organization,
    required this.areasOfInterest,
    required this.likeCount,
    required this.commentCount,
    required this.isAdmin,
    required this.onViewProfile,
    required this.onLike,
    required this.onComment,
    required this.onApprove,
    this.onReject,
    super.key,
  });

  @override
  State<VoteLeaderCard> createState() => _VoteLeaderCardState();
}

class _VoteLeaderCardState extends State<VoteLeaderCard> {
  bool isLiked = false;
  late int currentLikeCount;

  @override
  void initState() {
    super.initState();
    currentLikeCount = widget.likeCount.length;
    // Check if the current user has liked this card
    isLiked = widget.likeCount.any((like) => like.id == widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: SvgPicture.asset(
                        'assets/profile_placeholder.svg',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: SvgPicture.asset(
                        'assets/profile_placeholder.svg',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name.isNotEmpty ? widget.name : '-------',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      Text(
                        widget.role.isNotEmpty ? widget.role : '-------',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      Text(
                        widget.organization.isNotEmpty ? widget.organization : '-------',
                        style: const TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Areas of Interest',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
            ),
            const SizedBox(height: 1),
            Wrap(
              spacing: 8,
              children: widget.areasOfInterest
                  .map((interest) => Chip(
                label: Text(interest),
                backgroundColor: Colors.grey[200],
                labelStyle: const TextStyle(color: Colors.black),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Colors.grey),
                ),
              ))
                  .toList(),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onViewProfile,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    child: const Column(
                      children: [
                        Icon(Icons.visibility, size: 20, color: Colors.grey),
                        SizedBox(height: 5),
                        Text('View Profile', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                        currentLikeCount += isLiked ? 1 : -1;
                      });
                      widget.onLike();
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: isLiked ? Theme.of(context).primaryColor : Colors.grey,
                      ),
                      backgroundColor:
                      isLiked ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                              size: 16,
                              color: isLiked ? Theme.of(context).primaryColor : Colors.grey,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '$currentLikeCount',
                              style: TextStyle(
                                fontSize: 16,
                                color: isLiked ? Theme.of(context).primaryColor : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Vote',
                          style: TextStyle(
                            fontSize: 12,
                            color: isLiked ? Theme.of(context).primaryColor : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onComment,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 5),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.comment, size: 16, color: Colors.grey),
                            const SizedBox(width: 5),
                            Text('${widget.commentCount}', style: const TextStyle(fontSize: 16, color: Colors.grey)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        const Text('Comment', style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (widget.isAdmin) ...[
              const SizedBox(height: 12),
              const Divider(color: Colors.grey, height: 1),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: widget.onApprove,
                      icon: const Icon(Icons.check, color: Colors.green),
                      label: const Text('Approved', style: TextStyle(color: Colors.green)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.green),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                  if (widget.onReject != null) ...[
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: widget.onReject,
                        icon: const Icon(Icons.close, color: Colors.red),
                        label: const Text('Reject', style: TextStyle(color: Colors.red)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}