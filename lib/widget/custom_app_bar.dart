import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String subTitle;
  final bool showFilterButton;
  final VoidCallback? onFilterPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subTitle,
    required this.showFilterButton,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20, // Remove default padding
      centerTitle: false, // Align title to the start
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subTitle,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 11,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      actions: showFilterButton
          ? [
        IconButton(
          onPressed: onFilterPressed,
          icon: const Icon(Icons.filter_alt),
        ),
      ]
          : null,
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}