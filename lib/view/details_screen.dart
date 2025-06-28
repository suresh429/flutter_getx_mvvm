import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/view_model/explore_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../env/app_env.dart';
import '../view_model/details_page_controller.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final DetailsPageController controller = Get.put(DetailsPageController());
  final ExploreController exploreController = Get.put(ExploreController());
  late final dynamic exploreModel;
  int _currentTabIndex = 0; // Track current tab

  @override
  void initState() {
    super.initState();
    exploreModel = Get.arguments;
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () =>
            controller.isLoading.value
                ? const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                )
                : DefaultTabController(
                  length: 3,
                  child: NestedScrollView(
                    headerSliverBuilder: (
                      BuildContext context,
                      bool innerBoxIsScrolled,
                    ) {
                      return [
                        SliverAppBar(
                          expandedHeight: 420,
                          floating: false,
                          pinned: true,
                          elevation: 0,
                          backgroundColor: Colors.white,
                          leading: IconButton(
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                            onPressed: () => Get.back(),
                          ),
                          actions: [
                            Obx(() => IconButton(
                                onPressed: () {
                                  controller.exploreModel.isFavorite.value =
                                  !controller.exploreModel.isFavorite.value;
                                  exploreController.addToFav(
                                      [controller.exploreModel.id],
                                      controller.exploreModel.isFavorite.value
                                          ? "favourite"
                                          : 'unfavourite');
                                },
                                icon: Icon(
                                  controller.exploreModel.isFavorite.value
                                      ? Icons.favorite
                                      : Icons.favorite_border_outlined,
                                  size: 24,
                                  color: controller.exploreModel.isFavorite.value
                                      ? Colors.red
                                      : Colors.grey,
                                ),
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert, color: Colors.black),
                              onSelected: (value) {
                                if (value == 'report') {
                                  // handle report click
                                  print('Report clicked');
                                } else if (value == 'share') {
                                  // handle share click
                                  print('Share clicked');
                                }
                              },
                              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'report',
                                  child: Text('Report'),
                                ),

                              ],
                            )

                          ],
                          title: const Text(
                            "Request Details",
                            style: TextStyle(color: Colors.black),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            background: Stack(
                              fit: StackFit.loose,
                              children: [
                                // Banner Image
                                Positioned(
                                  top: kToolbarHeight + 60,
                                  left: 0,
                                  right: 0,
                                  height: 150,
                                  child: Obx(
                                    () => Image.network(
                                      controller.imageUrl.value,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (
                                            context,
                                            error,
                                            stackTrace,
                                          ) => Image.asset(
                                            'assets/card_default_image.webp',
                                            fit: BoxFit.cover,
                                          ),
                                    ),
                                  ),
                                ),

                                // White Card
                                Positioned(
                                  top: kToolbarHeight + 130,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 16),
                                    child: ConstrainedBox(
                                      constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width - 32, // Match horizontal margins
                                      ),
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Obx(() => Text(
                                                controller.title.value,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              )),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                                                  const SizedBox(width: 4),
                                                  Obx(() => Text(
                                                    controller.daysLeft.value,
                                                    style: const TextStyle(color: Colors.grey),
                                                  )),
                                                ],
                                              ),
                                              const SizedBox(height: 12),
                                              Obx(() => Text(
                                                controller.preferredTitle.value,
                                                style: const TextStyle(color: Colors.grey),
                                              )),
                                              Obx(() => Text(
                                                controller.preferredValue.value,
                                                style: const TextStyle(color: Colors.black),
                                              )),
                                              const SizedBox(height: 12),
                                              Obx(() => Text(
                                                controller.languageTitle.value,
                                                style: const TextStyle(color: Colors.grey),
                                              )),
                                              Obx(() => Row(
                                                children: [
                                                  if (controller.currentRequestType.value == "podcast" &&
                                                      controller.languageTitle.value.contains("Mode"))
                                                    Padding(
                                                      padding: const EdgeInsets.only(right: 8.0),
                                                      child: Icon(
                                                        Icons.videocam,
                                                        size: 20,
                                                        color: Colors.grey[600],
                                                      ),
                                                    ),
                                                  Expanded(
                                                    child: Text(
                                                      controller.languageValue.value,
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                              const SizedBox(height: 16),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  // Like Button
                                                  SizedBox(
                                                    width: 80, // Fixed width for each button group
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Obx(() {
                                                          return IconButton(
                                                            padding: EdgeInsets.zero,
                                                            constraints: const BoxConstraints(),
                                                            icon: Icon(
                                                              Icons.thumb_up,
                                                              size: 20,
                                                              color: controller.exploreModel.isLike.value
                                                                  ? Colors.red
                                                                  : Colors.grey,
                                                            ),
                                                            onPressed: () {
                                                              controller.exploreModel.isLike.value =
                                                              !controller.exploreModel.isLike.value;
                                                              if (controller.exploreModel.isLike.value) {
                                                                controller.exploreModel.likesCount++;
                                                              } else {
                                                                controller.exploreModel.likesCount--;
                                                              }
                                                              exploreController.likeUnlikeRequest(
                                                                  controller.exploreModel.id,
                                                                  controller.exploreModel.isLike.value ? "like" : 'unlike');
                                                            },
                                                          );
                                                        }),
                                                        Obx(() => Text(
                                                          controller.exploreModel.likesCount.toString(),
                                                          style: const TextStyle(fontSize: 14),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                  // Comment Button
                                                  SizedBox(
                                                    width: 80, // Fixed width for each button group
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        IconButton(
                                                          padding: EdgeInsets.zero,
                                                          constraints: const BoxConstraints(),
                                                          icon: const Icon(Icons.comment, size: 20, color: Colors.grey),
                                                          onPressed: () {
                                                            _tabController.animateTo(2);
                                                          },
                                                        ),
                                                        Text(
                                                          controller.exploreModel.commentsCount.toString(),
                                                          style: const TextStyle(fontSize: 14),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  // Share Button
                                                  SizedBox(
                                                    width: 80, // Fixed width for each button group
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        IconButton(
                                                          padding: EdgeInsets.zero,
                                                          constraints: const BoxConstraints(),
                                                          icon: const Icon(Icons.share, size: 20, color: Colors.grey),
                                                          onPressed: () {
                                                            controller.exploreModel.sharesCount++;
                                                            exploreController.shareRequest(controller.exploreModel.id);
                                                            var title = controller.exploreModel.title.replaceAll(' ', '-');
                                                            var url = "${AppEnvironment.baseWebUrl}/donationRequest/$title";
                                                            Share.share(url, subject: 'TALLeaders');
                                                          },
                                                        ),
                                                        Obx(() => Text(
                                                          controller.exploreModel.sharesCount.toString(),
                                                          style: const TextStyle(fontSize: 14),
                                                          overflow: TextOverflow.ellipsis,
                                                          maxLines: 1,
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          bottom: PreferredSize(
                            preferredSize: const Size.fromHeight(48),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.black12,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                labelColor: Colors.black,
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: Colors.black,
                                tabs: const [
                                  Tab(text: 'Request Info'),
                                  Tab(text: 'Uploads'),
                                  Tab(text: 'Comments'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: Column(children: [_buildRequestInfo()]),
                        ),
                        SingleChildScrollView(child: _buildUploads()),
                        _buildComments(),
                      ],
                    ),
                  ),
                ),
      ),
      bottomNavigationBar:
          _currentTabIndex !=
                  2 // Hide for Comments tab
              ? Container(
                color: Colors.white,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      bottom: 20.0,
                      top: 5.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              // ensures it only takes as much width as needed
                              children: [
                                Icon(Icons.share, size: 20),
                                SizedBox(width: 8),
                                Text("Share"),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text("Connect"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              : null,
    );
  }

  Widget _buildRequestInfo() {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Obx(() {
              if (controller.currentRequestType.value == "eventSpeaker") {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.speakerDescription.value,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Event Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem("Event Name", controller.eventName.value),
                    _buildDetailItem("Event Type", controller.eventType.value),

                    const Divider(height: 32),

                    const Text(
                      "Event Location",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem("Venue Name", controller.venueName.value),
                    _buildDetailItem(
                      "Location",
                      controller.eventLocation.value,
                    ),

                    const Divider(height: 32),

                    const Text(
                      "Speaker Requirements",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem(
                      "Speaker Responsibilities",
                      controller.speakerResponsibilities.value,
                    ),

                    const Text(
                      "Qualifications Required",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          controller.speakerQualifications
                              .map(
                                (qual) => Chip(
                                  label: Text(qual),
                                  backgroundColor: Colors.grey[200],
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 16),

                    _buildDetailItem(
                      "Preferred Speaking Topics",
                      controller.speakerTopics.value,
                    ),
                    _buildDetailItem(
                      "Expected Duration of Speech (minutes)",
                      controller.speakerDuration.value,
                    ),
                    _buildDetailItem(
                      "Audience Size",
                      controller.audienceSize.value,
                    ),
                    _buildDetailItem(
                      "Commercials",
                      controller.commercialMode.value,
                    ),
                    _buildDetailItem(
                      "Speaker Fee",
                      controller.speakerFee.value,
                    ),

                    const Text(
                      "Preferred Languages",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          controller.speakerLanguages
                              .map(
                                (lang) => Chip(
                                  label: Text(lang),
                                  backgroundColor: Colors.grey[200],
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 16),

                    _buildDetailItem(
                      "Deadline for Speaker Confirmation",
                      controller.speakerDeadline.value,
                    ),
                  ],
                );
              } else if (controller.currentRequestType.value == "podcast") {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.podcastDescription.value,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Podcast Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem(
                      "Podcast Name",
                      controller.podcastName.value,
                    ),
                    _buildDetailItem(
                      "Podcast Type",
                      controller.podcastType.value,
                    ),
                    _buildDetailItem("Host Name", controller.hostName.value),

                    const SizedBox(height: 16),
                    const Text(
                      "Preferred Recording Slot(s)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Obx(() {
                      return Text(
                        controller.podcastDates.join("\n"),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      );
                    }),

                    const SizedBox(height: 24),
                    const Text(
                      "Guest Requirements",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      controller.guestRequirements.value,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 24),
                    Obx(
                      () => _buildDetailItem(
                        "Preferred Language",
                        controller.preferredLanguage.value,
                      ),
                    ),
                    Obx(
                      () => _buildDetailItem(
                        "Deadline for Guest Confirmation",
                        controller.guestConfirmationDeadline.value ?? ' N/A',
                      ),
                    ),
                    Obx(
                      () => _buildDetailItem(
                        "Expected Duration of Speech (minutes)",
                        "${controller.expectedDuration.value}",
                      ),
                    ),
                    Obx(
                      () => _buildDetailItem(
                        "Commercial",
                        controller.commercial.value,
                      ),
                    ),
                    Obx(
                      () => _buildDetailItem(
                        "Speaker Fee",
                        "\$${controller.stipendFee.value}",
                      ),
                    ),
                  ],
                );
              } else if (controller.currentRequestType.value == "mentoring") {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.mentorDescription.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Mentor Responsibilities",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.mentorResponsibilities.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Qualifications Required",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          controller.mentorQualifications
                              .map(
                                (qual) => Chip(
                                  label: Text(qual),
                                  backgroundColor: Colors.grey[200],
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Mentor Mode",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        controller.mentorMode.value,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Expected Time Commitment (hours/month)",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.mentorExpectedTime.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Deadline",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.mentorDeadline.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                );
              } else {
                // Board Member case
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.boardDescription.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Skills & Expertise Needed",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          controller.boardExpertise
                              .map(
                                (skill) => Chip(
                                  label: Text(skill),
                                  backgroundColor: Colors.grey[200],
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Expected Time (hours/year)",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.boardExpectedTime.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Term Length (years)",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.boardTermLength.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Personal Traits",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          controller.boardPersonalTraits
                              .map(
                                (trait) => Chip(
                                  label: Text(trait),
                                  backgroundColor: Colors.grey[200],
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Board Member Responsibilities",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.boardResponsibilities.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Qualifications Required",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children:
                          controller.boardQualifications
                              .map(
                                (qual) => Chip(
                                  label: Text(qual),
                                  backgroundColor: Colors.grey[200],
                                ),
                              )
                              .toList(),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      "Request End Date",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      controller.boardEndDate.value,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                );
              }
              return Container();
            }),
          ),

          // Created By Card
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade200),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Obx(() {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Created By",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Obx(() {
                          final imageUrl = controller.profileImageUrl.value;
                          final profileInitial =
                              controller.profileName.value.isNotEmpty
                                  ? controller.profileName.value[0]
                                      .toUpperCase()
                                  : "A";

                          return CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.green,
                            backgroundImage:
                                (imageUrl.isNotEmpty)
                                    ? NetworkImage(imageUrl)
                                    : null, // Only set if image is not empty
                            child:
                                (imageUrl.isEmpty)
                                    ? Text(
                                      profileInitial,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                    : null, // If image is loaded, no child needed
                          );
                        }),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.profileName.value,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                controller.profileDate.value,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Obx(
                                () => Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      controller.profileLocation.value,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(height: 16),

          // Beneficiary Card
          Obx(() {
            if (!controller.showOrganization.value)
              return const SizedBox.shrink();

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.grey.shade200),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Beneficiary",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              controller.orgImageUrl.value,
                              fit: BoxFit.cover,
                              errorBuilder:
                                  (context, error, stackTrace) => Icon(
                                    Icons.business,
                                    color: Colors.grey[400],
                                    size: 24,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.orgName.value,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                controller.orgDate.value,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Obx(
                                () => Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      controller.orgLocation.value,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildUploads() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListTile(
        leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
        title: const Text("Board Member Document.pdf"),
        trailing: const Icon(Icons.visibility),
        onTap: () {},
      ),
    );
  }

  Widget _buildComments() {
    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.all(16).copyWith(bottom: 80),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.png'),
                  radius: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "LaLisa Manoban",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "20-Jun-2025 02:02 PM",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_horiz),
                            itemBuilder:
                                (context) => [
                                  const PopupMenuItem(
                                    value: 'edit',
                                    child: Text('Edit'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ],
                            onSelected: (value) {
                              // Handle menu item selection
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text("hi"),
                      const SizedBox(height: 8),
                      const Text("Reply", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/avatar.png'),
                  radius: 18,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Add a comment...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        child: IconButton(
                          icon: const Icon(Icons.send, color: Colors.red),
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showCommentOptionsDialog(BuildContext context) {
    final RenderBox? button = context.findRenderObject() as RenderBox?;
    if (button == null) return;

    final position = button.localToGlobal(Offset.zero);
    final size = button.size;

    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (BuildContext context) {
        return Stack(
          children: [
            Positioned(
              top: position.dy + size.height,
              left: position.dx + size.width - 100,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        title: const Text(
                          "Edit",
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          // Implement edit functionality
                        },
                      ),
                      ListTile(
                        title: const Text(
                          "Delete",
                          style: TextStyle(fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          // Implement delete functionality
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _StickyTabBarDelegate(this.tabBar);

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.white, width: 0)),
      ),
      child: Material(color: Colors.white, child: tabBar),
    );
  }

  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
