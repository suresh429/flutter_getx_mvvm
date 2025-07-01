import 'package:flutter/material.dart';
import 'package:TALLeaders/view_model/explore_controller.dart';
import 'package:get/get.dart';
import '../service/ConnectivityService.dart';
import '../utilites/colors.dart';
import '../widget/check_internet_widget.dart';
import '../widget/custom_app_bar.dart';
import '../widget/explore_card.dart';
import '../widget/observable_app_bar.dart';

class ExploreScreen extends StatelessWidget {
  final ExploreController controller = Get.put(ExploreController());
  final ConnectivityService connectivityService = Get.put(ConnectivityService());

  ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Safe to call after the build phase is complete
      controller.resetTab();
    });

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: ObservableAppBar(
          title: controller.title,
          subTitle: controller.subtitle,
          showFilterButton: false,
          onFilterPressed: () {
            // Filter button logic
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        child: Column(
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
                  labelPadding: EdgeInsets.only(right: 5.0), // 🔥 Remove default tab spacing
                  tabs: controller.tabTitles.map((title) {
                    final int index = controller.tabTitles.indexOf(title);
                    final bool isSelected =
                        controller.selectedIndex.value == index;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8), // 👈 Control spacing
                      child: Tab(
                        child: Container(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 8), // Inner padding
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.transparent
                                  : ColorUtils.colorGray,
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
                      ),
                    );
                  }).toList(),
                )),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (!connectivityService.isConnected.value) {
                  return CheckInternetWidget(
                    onRetry: () {
                      controller
                          .checkAndFetchData(controller.selectedIndex.value);
                    },
                  );
                }

                return Container(
                  color: Colors.grey[200],
                  child: TabBarView(
                    controller: controller.tabController,
                    children: controller.tabTitles.map((title) {
                      final int tabIndex =
                      controller.tabTitles.indexOf(title);
                      return Obx(() {
                        final isLoading =
                            controller.isLoading[tabIndex] ?? false;
                        final data = controller.tabData[tabIndex] ?? [];

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
                          return const Center(child: Text("No Explore Data found."));
                        }

                        return CustomScrollView(
                          controller:
                          controller.scrollControllers[tabIndex],
                          slivers: [
                            SliverList(
                              delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                  if (index < data.length) {
                                    final exploreModel = data[index];
                                    return ExploreCard(
                                      exploreModel: exploreModel,
                                      controller: controller,
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                                childCount: data.length,
                              ),
                            ),
                            if (isLoading)
                              const SliverToBoxAdapter(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  child:
                                  Center(child: CircularProgressIndicator()),
                                ),
                              ),
                          ],
                        );
                      });
                    }).toList(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),

    );
  }
}