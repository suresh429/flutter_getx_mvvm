import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/utilites/constants_Utils.dart';
import 'package:get/get.dart';
import '../service/ConnectivityService.dart';
import '../utilites/colors.dart';
import '../view_model/my_activity_controller.dart';
import '../widget/check_internet_widget.dart';

class MyActivityScreen extends StatefulWidget {
  const MyActivityScreen({super.key});

  @override
  State<MyActivityScreen> createState() => _MyActivityScreenState();
}

class _MyActivityScreenState extends State<MyActivityScreen>
    with WidgetsBindingObserver {
  final MyActivityController controller = Get.put(MyActivityController());
  final ConnectivityService connectivityService = Get.find<ConnectivityService>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Safe to call after the build phase is complete
      controller.resetSelection();
    });
    return Scaffold(
      backgroundColor: ColorUtils.colorSurface,
      appBar: _buildAppBar(context),
      body: Obx(() {
        if (!connectivityService.isConnected.value) {
          return Center(
            child: CheckInternetWidget(
              onRetry: () {
                controller.fetchRequests();
              },
            ),
          );
        }

        if (controller.isLoading.value && controller.requests.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

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

        if (controller.requests.isEmpty) {
          return const Center(child: Text("No Activities found."));
        }

        return _buildActivityList();
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: AppBar(
          titleSpacing: 20,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Activities',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      filterDialog(context);
                    },
                    icon: const Icon(Icons.filter_alt),
                  ),
                ],
              ),
              const SizedBox(height: 0),
              Text(
                'Impactful opportunities you expressed interest in.',
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
    );
  }

  Widget _buildActivityList() {
    return ListView.builder(
      itemCount: controller.requests.length + 1,
      itemBuilder: (context, index) {
        if (index == controller.requests.length) {
          if (controller.hasMoreData.value) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.fetchRequests();
            });
            return const Center(child: CircularProgressIndicator());
          } else {
            return const SizedBox.shrink();
          }
        }

        final donationData = controller.requests[index];
        return SizedBox(
          width: 320,
          child: Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: _buildImage(donationData),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          donationData.request_type ?? '',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            donationData.donationRequestInfo?.title ?? 'No Title Available',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Interest sent on',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  ConstantsUtils().formatDate(donationData.donationRequestInfo!.createdAt) ?? 'N/A',
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 25),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Request Status',
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  donationData.donationRequestInfo!.status == 1
                                      ? 'Approved'
                                      : donationData.donationRequestInfo!.status == -4
                                      ? 'Expired'
                                      : 'Unknown',
                                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() {
                              final isReminderSent = donationData.reminderSent.value; // Access RxBool using .value
                              return OutlinedButton.icon(
                                onPressed: isReminderSent
                                    ? null // Disable the button when reminderSent is true
                                    : () async {
                                  donationData.reminderSent.value = true; // Update the RxBool value
                                  await controller.reminderPost(donationData.donationRequestInfo!.id.toString());
                                  await controller.reminderPut(donationData.id.toString());
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.grey),
                                  padding: const EdgeInsets.symmetric(vertical: 0),
                                  backgroundColor: isReminderSent
                                      ? Colors.grey.withOpacity(0.3) // Greyed out for disabled state
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  minimumSize: const Size(double.infinity, 35),
                                ),
                                icon: Icon(
                                  isReminderSent ? Icons.check : Icons.notifications_outlined,
                                  color: Colors.grey,
                                ),
                                label: Text(
                                  isReminderSent ? 'Reminder Sent' : 'Remind',
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              );
                            }),
                          ),
                          const SizedBox(width: 25),
                          Expanded(
                            child: OutlinedButton.icon(
                                  iconAlignment: IconAlignment.start,
                                  onPressed: () {
                                    showConfirmationDialog(context,donationData.id.toString(),donationData.donationRequestInfo!.title.toString());
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(color: Colors.grey),
                                    padding: const EdgeInsets.symmetric(vertical: 0),
                                    backgroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    minimumSize: const Size(double.infinity, 35),
                                  ),
                                  icon: const Icon(Icons.close, color: Colors.grey),
                                  label: const Text(
                                    'Withdraw',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(dynamic donationData) {
    final imageUrl = donationData.donationRequestInfo?.defaultImageUrl;

    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/card_default_image.webp',
        height: 120,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }

  void showConfirmationDialog(BuildContext context, String reqId, String title) {
    Get.dialog(
      AlertDialog(
        title: const Text('Confirmation'),
        content: Text.rich(
          TextSpan(
            children: [
              const TextSpan(text: 'Are you sure you want to withdraw your interest from '),
              TextSpan(
                text: title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: ' ?'),
            ],
          ),
        ),        actions: [
          TextButton(
            onPressed: () {
              // Cancel action
              Get.back(); // Close the dialog
            },
            child: const Text('Cancel',style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () async{
              // Add the action you want to take when the OK button is clicked
              await controller.withdraw(reqId);
              Get.back();
            },
            style: TextButton.styleFrom(
              backgroundColor: Colors.black, // Set your desired background color here
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text('Withdraw', style: TextStyle(color: Colors.white)),
            ),          ),
        ],
      ),
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
    );
  }


  void filterDialog(BuildContext context) {
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
                      const Text('Filter ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Status', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 8, bottom: 0, top: 8),
                        child: Obx(() {
                          return Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: controller.statusList.map((status) {
                              return FilterChip(
                                label: Text(status),
                                selected: controller.selectedStatusList.value == status,
                                onSelected: (bool selected) {
                                  if (selected) {
                                    controller.selectedStatusList.value = status;
                                  } else {
                                    controller.selectedStatusList.value = '';
                                  }
                                },
                                selectedColor: ColorUtils.colorPrimary,
                                backgroundColor: Colors.grey[200],
                                checkmarkColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: controller.selectedStatusList.value == status ? Colors.white : Colors.black,
                                ),
                              );
                            }).toList(),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      const Text('Type', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 8, bottom: 0, top: 8),
                        child: Obx(() {
                          return Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: controller.typeList.map((type) {
                              return FilterChip(
                                label: Text(type),
                                selected: controller.selectedTypeList.value == type,
                                onSelected: (bool selected) {
                                  if (selected) {
                                    controller.selectedTypeList.value = type;
                                  } else {
                                    controller.selectedTypeList.value = '';
                                  }
                                },
                                selectedColor: ColorUtils.colorPrimary,
                                backgroundColor: Colors.grey[200],
                                checkmarkColor: Colors.white,
                                labelStyle: TextStyle(
                                  color: controller.selectedTypeList.value == type ? Colors.white : Colors.black,
                                ),
                              );
                            }).toList(),
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        color: ColorUtils.colorGray,
                        height: 1,
                        width: double.maxFinite,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                controller.resetSelection();
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.red),
                                padding: const EdgeInsets.symmetric(vertical: 0),
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                minimumSize: const Size(double.infinity, 40),
                              ),
                              child: const Text(
                                'Reset',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                controller.requests.clear();
                                controller.offset = 0;
                                controller.hasMoreData.value = true;
                                controller.fetchRequests();
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 0),
                                minimumSize: const Size(double.infinity, 40),
                              ),
                              child: const Text('Apply'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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