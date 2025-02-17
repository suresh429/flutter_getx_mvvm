import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_app_bar.dart';

class ObservableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final RxString title;
  final RxString subTitle;
  final bool showFilterButton;
  final VoidCallback? onFilterPressed;

  ObservableAppBar({
    required this.title,
    required this.subTitle,
    required this.showFilterButton,
    this.onFilterPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => CustomAppBar(
        title: title.value,
        subTitle: subTitle.value,
        showFilterButton: showFilterButton,
        onFilterPressed: onFilterPressed,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
