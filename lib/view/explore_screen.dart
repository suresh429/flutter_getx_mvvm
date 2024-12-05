import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/view_model/explore_controller.dart';
import 'package:get/get.dart';

import '../utilites/colors.dart';
import '../widget/explore_card.dart';

class ExploreScreen extends StatelessWidget {
  final ExploreController controller = Get.put(ExploreController());

  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.resetTab();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: AppBar(
              titleSpacing: 20,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    "Explore Requests",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Unleash your expertise on epic missions! Spark lasting change!",
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                ],
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Material(
            child: Container(
              height: 30,
              color: Colors.white,
              child: Obx(() => TabBar(
                    controller: controller.tabController,
                    isScrollable: true,
                    physics: const ClampingScrollPhysics(),
                    unselectedLabelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: ColorUtils.colorPrimary,
                    ),
                    tabs: controller.tabTitles.map((title) {
                      final int index = controller.tabTitles.indexOf(title);
                      final bool isSelected =
                          controller.selectedIndex.value == index;

                      return Tab(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color:
                                  isSelected ? Colors.transparent : ColorUtils.colorGray,
                              width: 1,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              title,
                              style: const TextStyle(fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              color: Colors.grey[200],
              child: TabBarView(
                controller: controller.tabController,
                children: controller.tabTitles.map((title) {
                  final int tabIndex = controller.tabTitles.indexOf(title);
                  return Obx(() {
                    final isLoading = controller.isLoading[tabIndex] ?? false;
                    final data = controller.tabData[tabIndex] ?? [];

                    // Show error message
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

                    if (data.isEmpty && !isLoading) {
                      return const Center(
                          child: Text("No Explore Data found."));
                    }

                    return CustomScrollView(
                      controller: controller.scrollControllers[tabIndex],
                      slivers: [
                        // List of items
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              if (index < data.length) {
                                final exploreModel = data[index];
                                return ExploreCard(exploreModel: exploreModel,controller: controller,);
                              }

                              // The extra space for loading indicator at the bottom
                              return const SizedBox.shrink();
                            },
                            childCount: data.length,
                          ),
                        ),
                        // Loading indicator at the bottom
                        if (isLoading)
                          const SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                          ),
                      ],
                    );
                  });
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
