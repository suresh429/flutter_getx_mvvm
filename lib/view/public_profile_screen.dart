import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs_lite.dart';
import 'package:flutter_getx_mvvm/utilites/colors.dart';
import 'package:flutter_getx_mvvm/utilites/constants_Utils.dart';
import 'package:flutter_getx_mvvm/view_model/public_profile_controller.dart';
import 'package:flutter_getx_mvvm/widget/public_profile_about_bottom.dart';
import 'package:flutter_getx_mvvm/widget/public_profile_area_interest_bottom.dart';
import 'package:flutter_getx_mvvm/widget/public_profile_experience_bottom.dart';
import 'package:flutter_getx_mvvm/widget/public_profile_expertise_bottom.dart';
import 'package:flutter_getx_mvvm/widget/public_profile_honor_bottom.dart';
import 'package:flutter_getx_mvvm/widget/public_profile_user_bottom.dart';
import 'package:get/get.dart';

import '../env/app_env.dart';
import '../widget/profile_progressbar.dart';
import '../widget/public_profile_url_bottom.dart';

class PublicProfileScreen extends StatelessWidget {
  final PublicProfileController controller = Get.put(PublicProfileController());
  static const double _tabBarHeight = 56.0;

  // Define isTabSelectedByUser at class level
  final RxBool isTabSelectedByUser = false.obs;

  // Global keys for each section
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _expertiseKey = GlobalKey();
  final GlobalKey _areasOfInterestKey = GlobalKey();
  final GlobalKey _honorsKey = GlobalKey();

  PublicProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: SafeArea(
          child: Builder(
            builder: (BuildContext context) {
              // Access TabController and ScrollController here
              final TabController tabController = DefaultTabController.of(context);
              final ScrollController scrollController = ScrollController();

              // Handle tab selection to scroll to the corresponding section
              tabController.addListener(() {
                if (tabController.indexIsChanging && !isTabSelectedByUser.value) {
                  _scrollToSection(context, tabController.index, scrollController);
                }
              });

              // Handle scroll changes to update tab selection
              scrollController.addListener(() {
                if (isTabSelectedByUser.value) {
                  _updateTabBasedOnScroll(context, tabController, scrollController);
                }
              });

              return NestedScrollView(
                controller: scrollController,
                physics: const ClampingScrollPhysics(),
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    expandedHeight: 505.0,
                    pinned: false,
                    backgroundColor: Colors.grey[200],
                    flexibleSpace: FlexibleSpaceBar(
                      background: _buildProfileHeader(context),
                    ),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _ProfileTabBarDelegate(
                      onTabSelected: (index) {
                        isTabSelectedByUser.value = false;
                        _scrollToSection(context, index, scrollController);
                      },
                    ),
                  ),
                ],
                body: TabBarView(
                  children: [
                    _buildScrollableTabContent(_buildAboutTab(context), _aboutKey),
                    _buildScrollableTabContent(_buildExperienceTab(context), _experienceKey),
                    _buildScrollableTabContent(_buildExpertiseTab(context), _expertiseKey),
                    _buildScrollableTabContent(_buildInterestsTab(context), _areasOfInterestKey),
                    _buildScrollableTabContent(_buildHonorsTab(context), _honorsKey),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _scrollToSection(
      BuildContext context,
      int index,
      ScrollController scrollController,
      ) {
    GlobalKey key;
    switch (index) {
      case 0:
        key = _aboutKey;
        break;
      case 1:
        key = _experienceKey;
        break;
      case 2:
        key = _expertiseKey;
        break;
      case 3:
        key = _areasOfInterestKey;
        break;
      case 4:
        key = _honorsKey;
        break;
      default:
        return;
    }

    final contextKey = key.currentContext;
    if (contextKey != null) {
      final RenderBox renderBox = contextKey.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero).dy;
      final appBarHeight = AppBar().preferredSize.height;
      final tabBarHeight = _tabBarHeight;
      final statusBarHeight = MediaQuery.of(context).padding.top;

      scrollController.animateTo(
        offset - appBarHeight - tabBarHeight - statusBarHeight,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _updateTabBasedOnScroll(
      BuildContext context,
      TabController tabController,
      ScrollController scrollController,
      ) {
    final scrollPosition = scrollController.offset;
    final aboutOffset = _getSectionOffset(context, _aboutKey);
    final experienceOffset = _getSectionOffset(context, _experienceKey);
    final expertiseOffset = _getSectionOffset(context, _expertiseKey);
    final areasOfInterestOffset = _getSectionOffset(context, _areasOfInterestKey);
    final honorsOffset = _getSectionOffset(context, _honorsKey);

    isTabSelectedByUser.value = true;
    if (scrollPosition >= honorsOffset) {
      tabController.animateTo(4);
    } else if (scrollPosition >= areasOfInterestOffset) {
      tabController.animateTo(3);
    } else if (scrollPosition >= expertiseOffset) {
      tabController.animateTo(2);
    } else if (scrollPosition >= experienceOffset) {
      tabController.animateTo(1);
    } else {
      tabController.animateTo(0);
    }
  }

  double _getSectionOffset(BuildContext context, GlobalKey key) {
    final contextKey = key.currentContext;
    if (contextKey != null) {
      final RenderBox renderBox = contextKey.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero).dy;
      final appBarHeight = AppBar().preferredSize.height;
      final tabBarHeight = _tabBarHeight;
      final statusBarHeight = MediaQuery.of(context).padding.top;
      return offset - appBarHeight - tabBarHeight - statusBarHeight;
    }
    return double.infinity;
  }

  Widget _buildScrollableTabContent(Widget child, GlobalKey key) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            key: key,
            child: child,
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16.0), // Optional padding
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Stack(
      children: [
      SizedBox(
      height: 150.0,
      child: Obx(() {
        final url = controller.coverBgImage.value;

        if (url.isNotEmpty) {
          return Image.network(
            url,
            fit: BoxFit.cover,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                'assets/card_default_image.webp',
                fit: BoxFit.fitWidth,
                width: double.infinity,
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
          );
        } else {
          return Image.asset(
            'assets/card_default_image.webp',
            fit: BoxFit.cover,
            width: double.infinity,
          );
        }
      }),
    ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: () => controller.pickImage(),
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2)],
              ),
              child: const Icon(Icons.edit, size: 18, color: Colors.red),
            ),
          ),
        ),
        Positioned(
          top: 140.0,
          left: 0.0,
          right: 0.0,
          child: Transform.translate(
            offset: const Offset(0.0, -20.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Obx(() {
                              final loginResponse = controller.loginResponse.value;
                              print("response $loginResponse");

                              if (loginResponse == null) {
                                return const CircleAvatar(
                                  radius: 50.0,
                                  backgroundColor: Colors.white,
                                  child: CircularProgressIndicator(),
                                );
                              }

                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  ProfileWithProgressBar(
                                    data: loginResponse,
                                    size: 100.0,
                                  ),
                                ],
                              );
                            }),
                            Obx(() => Column(
                              children: [
                                Text(
                                  controller.name.value,
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  controller.bio.value,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[500],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 5.0),
                                Text(
                                  controller.location.value,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.grey[500],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),
                            const SizedBox(height: 16.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildSocialIcon(
                                    'assets/facebook.png', controller.loginResponse.value?.data?.facebookProfileUrl ?? '', context),
                                const SizedBox(width: 10),
                                _buildSocialIcon(
                                    'assets/twitter.png', controller.loginResponse.value?.data?.twitterProfileUrl ?? '', context),
                                const SizedBox(width: 10),
                                _buildSocialIcon(
                                    'assets/linkedin.png', controller.loginResponse.value?.data?.linkedInProfileUrl ?? '', context),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            builder: (context) => Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: PublicProfileUserBottom(controller: controller),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 2),
                            ],
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _buildProfileUrlSection(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(String assetPath, String socialLink, BuildContext context) {
    return GestureDetector(
      onTap: () {
        ConstantsUtils.launchURL(socialLink, context);
      },
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Image.asset(assetPath, width: 30, height: 30),
      ),
    );
  }

  Widget _buildProfileUrlSection(BuildContext context) {
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Public Profile & URL',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: PublicProfileUrlBottom(controller: controller),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.edit, size: 18, color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Obx(() => Row(
              children: [
                Expanded(
                  child: Text(
                    "${AppEnvironment.baseWebUrl}public-profile/${controller.publicProfileUrl.value}",
                    style: const TextStyle(fontSize: 10.0, color: Colors.black),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: 30,
                  child: OutlinedButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: "${AppEnvironment.baseWebUrl}public-profile/${controller.publicProfileUrl.value}"),
                      );
                      ScaffoldMessenger.of(Get.context!).showSnackBar(
                        const SnackBar(
                          content: Text('URL copied to clipboard'),
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 6.0,
                      ),
                    ),
                    child: const Text(
                      'Copy',
                      style: TextStyle(color: Colors.black, fontSize: 10.0),
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutTab(BuildContext context) {
    return Card(
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'About',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18.0),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: PublicProfileAboutBottom(
                            controller: controller,
                            bottomSheetContext: context,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 8.0),

            // About text with Read more/less
            Obx(() {
              final aboutText = controller.aboutMe.value;
              final isExpanded = controller.isAboutExpanded.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aboutText.isEmpty ? "No description provided." : aboutText,
                    maxLines: isExpanded ? null : 4,
                    overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 16.0, color: Colors.grey[800]),
                  ),
                  if (aboutText.trim().isNotEmpty)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () => controller.isAboutExpanded.toggle(),
                        child: Text(
                          isExpanded ? 'Read less' : 'Read more',
                          style: const TextStyle(fontSize: 14, color: Colors.red),
                        ),
                      ),
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceTab(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader("Experience", onAdd: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                builder: (context) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: PublicProfileExperienceBottomSheet(
                    controller: controller,
                    bottomSheetContext: context,
                   // index: null,
                  ),
                ),
              );
            }),
            const SizedBox(height: 8),

            Obx(() => controller.experiences.isEmpty
                ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  "No experiences available.",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            )
                : Column(
              children: controller.experiences.asMap().entries.map((entry) {
                final index = entry.key;
                final exp = entry.value;

                final date = ConstantsUtils.getFormattedExperienceRange(
                  exp.experienceStartDate,
                  exp.experienceEndDate,
                );

                return Column(
                  children: [
                    _experienceItem(
                      index,
                      exp.role!,
                      exp.company!,
                      date,
                      context: context,
                    ),
                    if (index < controller.experiences.length - 1)
                      const Divider(),
                  ],
                );
              }).toList(),
            )),
          ],
        ),
      ),
    );
  }

  Widget _buildExpertiseTab(BuildContext context) {
    return _buildCardSection(
      title: "Expertise",
      onEdit: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: PublicProfileExpertiseBottom(
                controller: controller,
                bottomSheetContext: context,
              ),
            );
          },
        );
      },
      children: [
        Obx(() => controller.expertise.isEmpty
            ? const Center(child: Text("No expertise added yet."))
            : Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.expertise
              .map((chip) => Chip(label: Text(chip)))
              .toList(),
        )),
      ],
    );
  }

  Widget _buildInterestsTab(BuildContext context) {
    return _buildCardSection(
      title: "Areas of Interest",
      subtitle: "Sustainable Development Goals (SDGs) that the TALLeader is passionate about.",
      onEdit: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: PublicProfileAreaInterestBottom(controller: controller, bottomSheetContext: context),
            );
          },
        );
      },
      children: [
        Obx(() => controller.areaOfInterest.isEmpty
            ? const Center(child: Text("No Area of Interest added yet."))
            : Wrap(
          spacing: 8,
          runSpacing: 8,
          children: controller.areaOfInterest
              .map((chip) => Chip(label: Text(chip)))
              .toList(),
        )),
      ],
    );
  }

  Widget _buildHonorsTab(BuildContext context) {
    return _buildCardSection(
      title: "Honor & Awards",
      onAdd: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: PublicProfileHonorBottom(
                controller: controller,
                bottomSheetContext: context,
              ),
            );
          },
        );
      },
      children: [
        Obx(() {
          if (controller.honorsAwards.isEmpty) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  "No honors or awards available.",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
            );
          }

          return Column(
            children: controller.honorsAwards.asMap().entries.map((entry) {
              final index = entry.key;
              final honor = entry.value;

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.emoji_events, size: 32),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  honor.awardTitle ?? '',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 10),
                                GestureDetector(
                                  onTap: () {
                                    // Show edit bottom sheet

                                    showModalBottomSheet(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                      ),
                                      builder: (context) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context).viewInsets.bottom,
                                          ),
                                          child: PublicProfileHonorBottom(
                                            controller: controller,
                                            bottomSheetContext: context,
                                            editItem: honor, // Pass the honor item to edit
                                            editIndex: index, // Pass the index for editing
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(Icons.edit, size: 14, color: Colors.red),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5,),
                            if (honor.awardIssuedBy != null)
                              Text(honor.awardIssuedBy!),
                            const SizedBox(height: 5,),
                            if (honor.awardDescription != null)
                              Text(
                                honor.awardDescription!,
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (index < controller.honorsAwards.length - 1)
                    const SizedBox(height: 12),
                  const Divider(),
                ],
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  Widget _experienceItem(int index, String role, String company, String date, {
    required BuildContext context,
  }) {
    final experience = controller.experiences[index]; // ✅ Get current experience item

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.work, size: 32),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(role, style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                          ),
                        ),
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: PublicProfileExperienceBottomSheet(
                              controller: controller,
                              bottomSheetContext: context,
                              editItem: experience, // ✅ Use actual experience object
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.edit, size: 18, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(company),
              const SizedBox(height: 5),
              Text(date, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        )
      ],
    );
  }

  Widget _sectionHeader(String title, {VoidCallback? onAdd}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        if (onAdd != null)
          TextButton(
            onPressed: onAdd,
            child: const Text("Add", style: TextStyle(color: Colors.red)),
          ),
      ],
    );
  }

  Widget _buildCardSection({
    required String title,
    String? subtitle,
    VoidCallback? onAdd,
    VoidCallback? onEdit,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                if (onAdd != null)
                  TextButton(onPressed: onAdd, child: const Text("Add", style: TextStyle(color: Colors.red))),
                if (onEdit != null)
                  TextButton(onPressed: onEdit, child: const Text("Edit", style: TextStyle(color: Colors.red))),
              ],
            ),
            if (subtitle != null) ...[
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
              const SizedBox(height: 8),
            ],
            ...children,
          ],
        ),
      ),
    );
  }
}

class _ProfileTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Function(int) onTabSelected;

  _ProfileTabBarDelegate({required this.onTabSelected});

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Material(
      color: Colors.transparent,
      child: Card(
        elevation: 0.5,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: TabBar(
              isScrollable: true,
              labelColor: ColorUtils.colorPrimary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: ColorUtils.colorPrimary,
              labelStyle: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(fontSize: 14.0),
              onTap: onTabSelected,
              tabs: const [
                Tab(text: 'About'),
                Tab(text: 'Experience'),
                Tab(text: 'Expertise'),
                Tab(text: 'Areas of Interest'),
                Tab(text: 'Honors & Awards'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 56.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}