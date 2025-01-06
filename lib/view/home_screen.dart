import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_mvvm/widget/explore_card.dart';
import 'package:get/get.dart';

import '../env/app_env.dart';
import '../service/ConnectivityService.dart';
import '../utilites/colors.dart';
import '../utilites/constants_Utils.dart';
import '../view_model/bottom_nav_controller.dart';
import '../view_model/explore_controller.dart';
import '../view_model/recommendation_controller.dart';
import '../widget/check_internet_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BottomNavController bottomNavController = Get.find();

  final RecommendationController controller = Get.put(RecommendationController());

  final ExploreController exploreController = Get.put(ExploreController());

  final ConnectivityService connectivityService = Get.put(ConnectivityService());

  final List<String> bannerImages = [
    'assets/banner_image.png', // Example image paths
  ];

  @override
  void initState() {
    super.initState();
    controller.initializeController();
  }

  @override
  Widget build(BuildContext context) {
    controller.initializeController();
    return Scaffold(
      backgroundColor: ColorUtils.colorSurface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/app_logo.png', // Path to your app logo
              height: 30,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer(); // Opens the navigation drawer
              },
              child: Obx(() {
                final loginResponse = bottomNavController.loginResponse.value!;
                return Stack(children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    backgroundImage: NetworkImage(
                      loginResponse.data?.profileImageUrl ??
                          'https://via.placeholder.com/150',
                    ),
                    radius: 18.0,
                  ),
                  Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.menu,
                            size: 12,
                            color: Colors.black,
                          ),
                        ),
                      )),
                ]);
              }),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildBannerSlider(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recommendations for You",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                    GestureDetector(
                        onTap: () {
                          bottomNavController.changeIndex(1);
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: ColorUtils.colorPrimary),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 325,
                child: Obx(() {
                  if (!connectivityService.isConnected.value) {
                    return CheckInternetWidget(
                      onRetry: () {
                        controller.fetchData(controller.loginResponse?.data?.uniqueId);
                      },
                    );
                  }

                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

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

                  if (controller.recommendations.isEmpty) {
                    return const Center(
                        child: Text("No recommendations found."));
                  }

                  return ListView.builder(
                    scrollDirection: Axis.horizontal, // Make it horizontal
                    itemCount: controller.recommendations.length,
                    itemBuilder: (context, index) {
                      final recommendation = controller.recommendations[index];
                      return ExploreCard(
                        exploreModel: recommendation,
                        controller: controller,
                      );
                    },
                  );
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/send_email_image.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Know an Inspiring Leader? Invite Them to Join TALLeaders',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoBold',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Invite change makers and leaders who you think can make a difference and add value to the TALLeaders community.',
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'RobotoRegular',
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              openBottomSheet(context);
                            },
                            icon: const Icon(
                              Icons.email_outlined,
                              size: 16,
                            ),
                            label: const Text(
                              'Send Email Invite',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              String link =
                                  '${AppEnvironment.baseWebUrl}becomeTalLeaderHome';
                              Clipboard.setData(ClipboardData(text: link));
                              ConstantsUtils.showInfoSnackbar('Link copied!');
                            },
                            icon: const Icon(
                              Icons.link,
                              size: 16,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Copy Link',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: const EdgeInsets.all(12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              side: const BorderSide(
                                  color: Colors.black, width: 1),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
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

  void openBottomSheet(BuildContext context) {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Invite ', style: TextStyle(fontSize: 20)),
                      InkWell(
                        child: const Icon(
                          Icons.close,
                          size: 24,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: ColorUtils.colorGray,
                  height: 1,
                  width: double.maxFinite,
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Obx(() {
                        return TextField(
                          controller: controller.firstNameController,
                          decoration: InputDecoration(
                            labelText: 'First Name',
                            errorText: controller.firstNameError.value,
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Obx(() {
                        return TextField(
                          controller: controller.lastNameController,
                          decoration: InputDecoration(
                            labelText: 'Last Name',
                            errorText: controller.lastNameError.value,
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Obx(() {
                        return TextField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            errorText: controller.emailError.value,
                          ),
                        );
                      }),
                      const SizedBox(height: 20),
                      Obx(() {
                        return ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () {
                            controller.inviteMember(context);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 45),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : const Text(
                            'Invite',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      isDismissible: true,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
    );
  }
}