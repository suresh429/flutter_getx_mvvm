import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getx_mvvm/widget/explore_card.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../env/app_env.dart';
import '../utilites/colors.dart';
import '../utilites/constants_Utils.dart';
import '../view_model/bottom_nav_controller.dart';
import '../view_model/explore_controller.dart';
import '../view_model/recommendation_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BottomNavController bottomNavController = Get.find();

  final RecommendationController controller = Get.put(RecommendationController());

  final ExploreController exploreController = Get.put(ExploreController());

  final List<String> bannerImages = [
    'assets/banner_image.png', // Example image paths
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // initial call
  Future<void> fetchData() async {
    var loginResponse = await ConstantsUtils.getStoredLoginResponse();
    controller.fetchData(loginResponse?.data?.uniqueId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.colorSurface,
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
                height: 320,
                child: Obx(() {
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
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  // margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage('assets/send_email_image.png'),
                      // Adjust the image path
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
                        // Replace with localized string if needed
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          // Replace with your `textLarge1` dimension
                          fontFamily: 'RobotoBold',
                          // Replace with your Roboto bold font family
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      // Replace with `layout_side_small` dimension
                      const Text(
                        'Invite change makers and leaders who you think can make a difference and add value to the TALLeaders community.',
                        // Replace with localized string if needed
                        style: TextStyle(
                          fontSize: 12,
                          // Replace with your `textMedium` dimension
                          fontFamily: 'RobotoRegular',
                          // Replace with your Roboto regular font family
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Space between text and buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              // Action for Send Email Invite button
                              openBottomSheet(context);
                            },
                            icon: const Icon(
                              Icons.email_outlined,
                              // Replace with `ic_send_email_person` if you have custom icon
                              size: 16,
                            ),
                            label: const Text(
                              'Send Email Invite',
                              // Replace with localized string if needed
                              style: TextStyle(
                                fontSize: 12,
                                // Replace with your `textSmall` dimension
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.all(12),
                              // Adjust padding as needed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              // Action for Copy Link button
                              String link =
                                  '${AppEnvironment.baseWebUrl}becomeTalLeaderHome';
                              Clipboard.setData(ClipboardData(text: link));
                              ConstantsUtils.showInfoSnackbar('Link copied!');
                            },
                            icon: const Icon(
                              Icons.link,
                              // Replace with `ic_link` if you have custom icon
                              size: 16,
                              color: Colors.black,
                            ),
                            label: const Text(
                              'Copy Link',
                              // Replace with localized string if needed
                              style: TextStyle(
                                fontSize: 12,
                                // Replace with your Roboto regular font family
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
      Container(
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
                padding: const EdgeInsets.only(left: 16,right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Invite ', style: TextStyle(fontSize: 20)),
                    InkWell(child: const Icon(Icons.close,size: 24,),
                      onTap: (){
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
                    Obx(()  {
                        return TextField(
                          controller: controller.firstNameController,
                          decoration:  InputDecoration(
                            labelText: 'First Name',
                            border: OutlineInputBorder(),
                            errorText: controller.firstNameError.value,
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                        return TextField(
                          controller: controller.lastNameController,
                          decoration:  InputDecoration(
                            labelText: 'Last Name',
                            border: OutlineInputBorder(),
                            errorText: controller.lastNameError.value,
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 20),
                    Obx((){
                        return TextField(
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: const OutlineInputBorder(),
                            errorText: controller.emailError.value,
                          ),
                        );
                      }
                    ),
                    const SizedBox(height: 20),
                    Obx(() {
                        return ElevatedButton(
                          onPressed: controller.isLoading.value ? null :() { controller.inviteMember(context); },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 45),
                            // Full-width button
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5), // Set the radius to 5
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
                      }
                    )
                  ],
                ),
              )
            ],
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
