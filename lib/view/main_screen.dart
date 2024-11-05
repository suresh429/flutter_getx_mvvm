import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/view/explore_screen.dart';
import 'package:flutter_getx_mvvm/view/my_activity_screen.dart';
import 'package:flutter_getx_mvvm/view/vote_leaders_screen.dart';
import 'package:get/get.dart';

import '../view_model/bottom_nav_controller.dart';
import 'home_screen.dart';

class MainScreen extends StatelessWidget {
  final BottomNavController bottomNavController = Get.put(BottomNavController());

  final List<Widget> _pages = [
     HomeScreen(),
    const ExploreScreen(),
    const MyActivityScreen(),
    const VoteLeadersScreen(),
  ];

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
                  backgroundImage: AssetImage('assets/user.png'), // Path to user icon
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
                leading: const Icon(Icons.settings),
                title: const Text("Settings"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: _pages[bottomNavController.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          currentIndex: bottomNavController.selectedIndex.value,
          onTap: (index) => bottomNavController.changeIndex(index),
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
}


