import 'package:flutter/material.dart';

import '../utilites/colors.dart';
import '../widget/custom_app_bar.dart';

class VoteLeadersScreen extends StatelessWidget {
  const VoteLeadersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.colorSurface,
      appBar: CustomAppBar(
        title: 'Vote New Leaders',
        subTitle: 'Your voice matters Aid the new leader selection process. Vote & comment.',
        showFilterButton: false,
        onFilterPressed: () {
          // Your filter logic here
        },
      ),
      body: Column(
      ),
    );
  }
}
