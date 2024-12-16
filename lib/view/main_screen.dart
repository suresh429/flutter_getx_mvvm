import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/view/explore_screen.dart';
import 'package:flutter_getx_mvvm/view/my_activity_screen.dart';
import 'package:flutter_getx_mvvm/view/vote_leaders_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../env/app_env.dart';
import '../utilites/constants_Utils.dart';
import '../view_model/bottom_nav_controller.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final BottomNavController bottomNavController =
      Get.put(BottomNavController());
  final storage = GetStorage();

  // Access GetStorage
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 120,
                child: Center(
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/ic_header.webp'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Obx(() {
                      final loginResponse = bottomNavController.loginResponse.value!;
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.red,
                              backgroundImage: NetworkImage(
                                  loginResponse.data?.profileImageUrl ??
                                      'https://via.placeholder.com/150'),
                              radius:
                                  25.0, // Adjust the size of the avatar if needed
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  loginResponse.data?.username ?? 'User Name',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  loginResponse.data?.email ?? 'User@email.com',
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 5),
                            IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios,color: Colors.white,size: 20,))
                          ],
                        );
                      }
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.person_2_outlined,
                  color: Colors.black,
                ),
                title: const Text("Public Profile"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.favorite_border,
                  color: Colors.black,
                ),
                title: const Text("Favorites"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.room_preferences_outlined,
                  color: Colors.black,
                ),
                title: const Text("Manage Preferences"),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed('/managePref');
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                ),
                title: const Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.person_2_outlined,
                  color: Colors.black,
                ),
                title: const Text("Meet our TALLeaders"),
                onTap: () {
                  ConstantsUtils.launchURL('${AppEnvironment.baseWebUrl}meet-our-TALLeaders', context);
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.bento_outlined,
                  color: Colors.black,
                ),
                title: const Text("TALLeader Benefits"),
                onTap: () {
                  ConstantsUtils.launchURL('${AppEnvironment.baseWebUrl}TALLeaders-Benefits', context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.info_outline,
                  color: Colors.black,
                ),
                title: const Text("About TALLeaders"),
                onTap: () {
                  ConstantsUtils.launchURL('${AppEnvironment.baseWebUrl}about-TALLeaders', context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.leaderboard_outlined,
                  color: Colors.black,
                ),
                title: const Text("Leadership"),
                onTap: () {
                  ConstantsUtils.launchURL('${AppEnvironment.baseWebUrl}leadership', context);
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.privacy_tip_outlined,
                  color: Colors.black,
                ),
                title:  const Text("Privacy Policy"),
                onTap: () {
                  ConstantsUtils.launchURL('${AppEnvironment.baseWebUrl}privacy-policy', context);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                title: const Text("Logout"),
                onTap: () {
                  logout();
                },
              ),
            ],
          ),
        ),
        body: GetBuilder<BottomNavController>(
          id: 'page', // Refresh pages when this ID is updated
          builder: (controller) {
            // Control which page is displayed
            switch (controller.selectedIndex.value) {
              case 0:
                return HomeScreen(); // Refresh HomeScreen
              case 1:
                return  ExploreScreen(); // Refresh ExploreScreen
              case 2:
                return const MyActivityScreen(); // Refresh MyActivityScreen
              case 3:
                return const VoteLeadersScreen(); // Refresh VoteLeadersScreen
              default:
                return Container();
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: bottomNavController.selectedIndex.value,
          onTap: (index) {
            bottomNavController.changeIndex(index);
            // Trigger a refresh for the specific tab
            bottomNavController.update(['page']);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_activity_rounded),
              label: 'My Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard),
              label: 'Vote Leaders',
            ),
          ],
        ),
      );
    });
  }

  void logout() {
    storage.remove('isLoggedIn');
    Get.offAllNamed('/login');
  }
}
