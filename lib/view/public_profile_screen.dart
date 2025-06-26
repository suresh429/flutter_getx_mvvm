import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../env/app_env.dart';
import '../utilites/constants_Utils.dart';
import '../view_model/public_profile_controller.dart';
import '../widget/profile_progressbar.dart';
import '../widget/public_profile_about_bottom.dart';
import '../widget/public_profile_area_interest_bottom.dart';
import '../widget/public_profile_experience_bottom.dart';
import '../widget/public_profile_expertise_bottom.dart';
import '../widget/public_profile_honor_bottom.dart';
import '../widget/public_profile_url_bottom.dart';
import '../widget/public_profile_user_bottom.dart';

class PublicProfileScreen extends StatefulWidget {
  const PublicProfileScreen({super.key});

  @override
  _PublicProfileScreenState createState() => _PublicProfileScreenState();
}

class _PublicProfileScreenState extends State<PublicProfileScreen> {
  final List<GlobalKey> categoriesSections = List.generate(
    5,
    (_) => GlobalKey(),
  );
  final PublicProfileController controller = Get.put(PublicProfileController());
  late ScrollController scrollController;
  BuildContext? tabContext;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(animateToTab);
  }

  void animateToTab() {
    for (int i = 0; i < categoriesSections.length; i++) {
      final box = categoriesSections[i].currentContext?.findRenderObject();
      if (box is RenderBox) {
        final position = box.localToGlobal(Offset.zero);
        if (scrollController.offset >= position.dy - 150) {
          DefaultTabController.of(tabContext!)?.animateTo(i);
        }
      }
    }
  }

  void scrollToIndex(int index) async {
    scrollController.removeListener(animateToTab);
    final keyContext = categoriesSections[index].currentContext;
    if (keyContext != null) {
      await Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 600),
      );
    }
    scrollController.addListener(animateToTab);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Builder(
        builder: (BuildContext context) {
          tabContext = context;
          return Scaffold(
            body: SafeArea(
              child: Obx(() {
                return controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CustomScrollView(
                      controller: scrollController,
                      slivers: [
                        // Proper height for header
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 490,
                            // Adjusted height to accommodate entire header content
                            child: _buildProfileHeader(context),
                          ),
                        ),

                        // Pinned TabBar
                        SliverPersistentHeader(
                          pinned: true,
                          delegate: _SliverAppBarDelegate(
                            TabBar(
                              labelColor: Theme.of(context).primaryColor,
                              unselectedLabelColor: Colors.grey,
                              indicatorColor: Theme.of(context).primaryColor,
                              labelStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              unselectedLabelStyle: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14,
                              ),
                              isScrollable: true,
                              tabs: const [
                                Tab(child: Text('About')),
                                Tab(child: Text('Experience')),
                                Tab(child: Text('Expertise')),
                                Tab(child: Text('Areas Of Interest')),
                                Tab(child: Text('Honors & Awards')),
                              ],
                              onTap: scrollToIndex,
                            ),
                          ),
                        ),

                        // Tab Content
                        SliverList(
                          delegate: SliverChildListDelegate([
                            //_buildCategoryTitle('About', 0),
                            _buildAboutTab(context, categoriesSections[0]),
                            _buildExperienceTab(context, categoriesSections[1]),
                            _buildExpertiseTab(context, categoriesSections[2]),
                            _buildInterestsTab(context, categoriesSections[3]),
                            _buildHonorsTab(context, categoriesSections[4]),
                            const SizedBox(height: 30),
                          ]),
                        ),
                      ],
                    );
              }),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      // fit: StackFit.expand,
      children: [
        // Cover Image
        SizedBox(
          height: 120.0,
          width: double.infinity,
          child: Obx(() {
            final url = controller.coverBgImage.value;
            if (url.isNotEmpty) {
              return Image.network(
                url,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder:
                    (_, __, ___) => Image.asset(
                      'assets/card_default_image.webp',
                      fit: BoxFit.cover,
                    ),
              );
            } else {
              return Image.asset(
                'assets/card_default_image.webp',
                fit: BoxFit.cover,
              );
            }
          }),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: InkWell(
            onTap: controller.pickImage,
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
          top: 90,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Obx(() {
                              final loginResponse =
                                  controller.loginResponse.value;
                              if (loginResponse == null) {
                                return const CircleAvatar(
                                  radius: 50,
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return ProfileWithProgressBar(
                                data: loginResponse,
                                size: 100,
                              );
                            }),
                            const SizedBox(height: 10),
                            Obx(
                              () => Column(
                                children: [
                                  Text(
                                    controller.name.value,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    controller.bio.value,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    controller.location.value,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildSocialIcon(
                                  'assets/facebook.png',
                                  controller
                                          .loginResponse
                                          .value
                                          ?.data
                                          ?.facebookProfileUrl ??
                                      '',
                                  context,
                                ),
                                const SizedBox(width: 10),
                                _buildSocialIcon(
                                  'assets/twitter.png',
                                  controller
                                          .loginResponse
                                          .value
                                          ?.data
                                          ?.twitterProfileUrl ??
                                      '',
                                  context,
                                ),
                                const SizedBox(width: 10),
                                _buildSocialIcon(
                                  'assets/linkedin.png',
                                  controller
                                          .loginResponse
                                          .value
                                          ?.data
                                          ?.linkedInProfileUrl ??
                                      '',
                                  context,
                                ),
                              ],
                            ),
                          ],
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
                              builder:
                                  (_) => Padding(
                                    padding: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.of(
                                            context,
                                          ).viewInsets.bottom,
                                    ),
                                    child: PublicProfileUserBottom(
                                      controller: controller,
                                    ),
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
                ),
                //const SizedBox(height: 16),
                _buildProfileUrlSection(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon(
    String assetPath,
    String socialLink,
    BuildContext context,
  ) {
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
                    child: const Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: Text(
                      "${AppEnvironment.baseWebUrl}public-profile/${controller.publicProfileUrl.value}",
                      style: const TextStyle(
                        fontSize: 10.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                    height: 30,
                    child: OutlinedButton(
                      onPressed: () {
                        Clipboard.setData(
                          ClipboardData(
                            text:
                                "${AppEnvironment.baseWebUrl}public-profile/${controller.publicProfileUrl.value}",
                          ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTitle(String title, int index) {
    return Container(
      key: categoriesSections[index],
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildAboutTab(BuildContext context, Key key) {
    return Card(
      key: key,
      // 👈 Important for scroll-to-section to work!
      elevation: 1.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          final aboutText = controller.aboutMe.value;
          final isExpanded = controller.isAboutExpanded.value;
          final hasContent = aboutText.trim().isNotEmpty;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton.icon(
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
                        builder:
                            (_) => Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: PublicProfileAboutBottom(
                                controller: controller,
                                bottomSheetContext: context,
                              ),
                            ),
                      );
                    },
                    icon: const Icon(Icons.edit, size: 18, color: Colors.red),
                    label: Text(
                      hasContent ? 'Edit' : 'Add',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                hasContent ? aboutText : "No description provided.",
                maxLines: isExpanded ? null : 4,
                overflow:
                    isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.0, color: Colors.grey[800]),
              ),
              if (hasContent)
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
      ),
    );
  }

  // Experience Tab (Optimized with ListView.builder)
  Widget _buildExperienceTab(BuildContext context, Key key) {
    return Card(
      key: key,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(
              "Experience",
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
                  builder:
                      (context) => Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: PublicProfileExperienceBottomSheet(
                          controller: controller,
                          bottomSheetContext: context,
                        ),
                      ),
                );
              },
            ),
            const SizedBox(height: 8),
            Obx(
              () =>
                  controller.experiences.isEmpty
                      ? const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Center(
                          child: Text(
                            "No experiences available.",
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      )
                      : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.experiences.length,
                        itemBuilder: (context, index) {
                          final exp = controller.experiences[index];
                          final date =
                              ConstantsUtils.getFormattedExperienceRange(
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
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpertiseTab(BuildContext context, Key key) {
    return _buildCardSection(
      key: key,
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
        Obx(
          () =>
              controller.expertise.isEmpty
                  ? const Center(child: Text("No expertise added yet."))
                  : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        controller.expertise
                            .map((chip) => Chip(label: Text(chip)))
                            .toList(),
                  ),
        ),
      ],
    );
  }

  Widget _buildInterestsTab(BuildContext context, Key key) {
    return _buildCardSection(
      key: key,
      title: "Areas of Interest",
      subtitle:
          "Sustainable Development Goals (SDGs) that the TALLeader is passionate about.",
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
              child: PublicProfileAreaInterestBottom(
                controller: controller,
                bottomSheetContext: context,
              ),
            );
          },
        );
      },
      children: [
        Obx(
          () =>
              controller.areaOfInterest.isEmpty
                  ? const Center(child: Text("No Area of Interest added yet."))
                  : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children:
                        controller.areaOfInterest
                            .map((chip) => Chip(label: Text(chip)))
                            .toList(),
                  ),
        ),
      ],
    );
  }

  // Honors Tab (Optimized with ListView.builder)
  Widget _buildHonorsTab(BuildContext context, Key key) {
    return _buildCardSection(
      key: key,
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
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.honorsAwards.length,
            itemBuilder: (context, index) {
              final honor = controller.honorsAwards[index];
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
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 10),
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
                                            bottom:
                                                MediaQuery.of(
                                                  context,
                                                ).viewInsets.bottom,
                                          ),
                                          child: PublicProfileHonorBottom(
                                            controller: controller,
                                            bottomSheetContext: context,
                                            editItem: honor,
                                            editIndex: index,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    size: 14,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            if (honor.awardIssuedBy != null)
                              Text(honor.awardIssuedBy!),
                            const SizedBox(height: 5),
                            if (honor.awardDescription != null)
                              Text(
                                honor.awardDescription!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
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
            },
          );
        }),
      ],
    );
  }

  Widget _experienceItem(
    int index,
    String role,
    String company,
    String date, {
    required BuildContext context,
  }) {
    final experience =
        controller.experiences[index]; // ✅ Get current experience item

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
                  Text(
                    role,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
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
                              editItem:
                                  experience, // ✅ Use actual experience object
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(company),
              const SizedBox(height: 5),
              Text(
                date,
                style: const TextStyle(fontSize: 10, color: Colors.grey),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _sectionHeader(String title, {VoidCallback? onAdd}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        if (onAdd != null)
          TextButton(
            onPressed: onAdd,
            child: const Text("Add", style: TextStyle(color: Colors.red)),
          ),
      ],
    );
  }

  Widget _buildCardSection({
    Key? key,
    required String title,
    String? subtitle,
    VoidCallback? onAdd,
    VoidCallback? onEdit,
    required List<Widget> children,
  }) {
    return Card(
      key: key,
      // Use key for scroll-to-section functionality
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
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (onAdd != null)
                  TextButton(
                    onPressed: onAdd,
                    child: const Text(
                      "Add",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                if (onEdit != null)
                  TextButton(
                    onPressed: onEdit,
                    child: const Text(
                      "Edit",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
            if (subtitle != null) ...[
              Text(
                subtitle,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 8),
            ],
            ...children,
          ],
        ),
      ),
    );
  }
}

// Delegate for pinned TabBar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}
