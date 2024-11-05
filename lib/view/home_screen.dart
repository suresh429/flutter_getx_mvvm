import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/widget/explore_card.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../view_model/explore_controller.dart';

class HomeScreen extends StatelessWidget {
  final RecommendationController controller = Get.put(RecommendationController());

  final List<String> bannerImages = [
    'assets/banner_image.png', // Example image paths
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/app_logo.png', // Path to your app logo
              height: 40,
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.person,
                color: Colors.black, // Icon color
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer(); // Opens navigation drawer
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildBannerSlider(),
            SizedBox(
              height: 280,
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.recommendations.isEmpty) {
                  return const Center(child: Text("No recommendations found."));
                }

                return ListView.builder(
                                  scrollDirection: Axis.horizontal, // Make it horizontal
                  itemCount: controller.recommendations.length,
                  itemBuilder: (context, index) {
                    final recommendation = controller.recommendations[index];
                    return ExploreCard(
                      exploreModel: recommendation,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Banner Slider Widget
  Widget _buildBannerSlider() {
    return SizedBox(
      height: 150, // Adjust height as needed
      child: PageView.builder(
        itemCount: bannerImages.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              child: Image.asset(
                bannerImages[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
