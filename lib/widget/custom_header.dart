import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'profile_progressbar.dart';
import '../view_model/bottom_nav_controller.dart';
import '../model/LoginModel.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomNavController bottomNavController =
        Get.find<BottomNavController>();

    return SizedBox(
      height: 120,
      child: DrawerHeader(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ic_header.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Obx(() {
          if (bottomNavController.loginResponse.value == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final loginResponse = bottomNavController.loginResponse.value!;
          return InkWell(
            onTap: () {
              Navigator.pop(context);
              Get.toNamed('/userProfile');
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile with progress circle
                ProfileWithProgressBar(data: loginResponse, size: 60),

                const SizedBox(width: 12),

                // User info column
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        final loginData = bottomNavController.loginResponse.value?.data;
                        return Text(
                          '${loginData?.name?.firstName} ${loginData?.name?.lastName}' ?? 'User Name',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        );
                      }),

                      const SizedBox(height: 4),
                      Text(
                        loginResponse.data?.email ?? 'user@email.com',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Arrow icon
                const Icon(Icons.chevron_right, color: Colors.white, size: 20),
              ],
            ),
          );
        }),
      ),
    );
  }
}
