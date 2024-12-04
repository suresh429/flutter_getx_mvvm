import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/view/explore_screen.dart';
import 'package:flutter_getx_mvvm/view/my_activity_screen.dart';
import 'package:flutter_getx_mvvm/view/vote_leaders_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../view_model/bottom_nav_controller.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final BottomNavController bottomNavController = Get.put(BottomNavController());

  final storage = GetStorage();
 // Access GetStorage
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                accountName: Text("User Name"),
                accountEmail: Text("user@example.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/user.png'),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Home"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
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
                return ExploreScreen(); // Refresh ExploreScreen
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
