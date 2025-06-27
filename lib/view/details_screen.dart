import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view_model/details_page_controller.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final DetailsPageController controller = Get.put(DetailsPageController());
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
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 380,
                floating: false,
                pinned: true,
                elevation: 0,
                backgroundColor: Colors.white,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.favorite_outline, color: Colors.black),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.black),
                    onPressed: () {},
                  ),
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
                        top: kToolbarHeight,
                        left: 0,
                        right: 0,
                        height: 150,
                        child: Obx(() => Image.network(
                          controller.imageUrl.value,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Image.asset(
                            'assets/card_default_image.webp',
                            fit: BoxFit.cover,
                          ),
                        )),
                      ),
                      // White Card
                      Positioned(
                        top: kToolbarHeight + 80,
                        left: 0,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
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
                                      if (controller.languageTitle.value.contains("Mode"))
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: Icon(Icons.videocam,
                                            size: 20,
                                            color: Colors.grey[600]
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
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Obx(() => Icon(
                                            Icons.thumb_up_outlined,
                                            color: controller.isLiked.value ? Colors.red : Colors.grey,
                                          )),
                                          const SizedBox(width: 4),
                                          Obx(() => Text(controller.likeCount.toString())),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.comment_outlined),
                                          const SizedBox(width: 4),
                                          Obx(() => Text(controller.commentCount.toString())),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Icon(Icons.share_outlined),
                                          const SizedBox(width: 4),
                                          Obx(() => Text(controller.shareCount.toString())),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
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
                child: Column(
                  children: [
                    _buildRequestInfo(),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: _buildUploads(),
              ),
              _buildComments(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _currentTabIndex != 2 // Hide for Comments tab
          ? Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: const Text("Share"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text("Connect"),
              ),
            ),
          ],
        ),
      )
          : null,
    );
  }

  Widget _buildHeaderCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          exploreModel?.title ?? "Advocate General Meeting for Board Member Elections",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        const Text("179 days left", style: TextStyle(color: Colors.black87)),
        const SizedBox(height: 8),
        const Text("Preferred Industry: Management, Fundraising, Operations",
            style: TextStyle(color: Colors.black87)),
        const SizedBox(height: 4),
        const Text("Preferred Language: Hindi, English",
            style: TextStyle(color: Colors.black87)),
        const SizedBox(height: 10),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.thumb_up_off_alt, color: Colors.black54),
            Icon(Icons.comment, color: Colors.black54),
            Icon(Icons.share, color: Colors.black54),
          ],
        )
      ],
    );
  }

  Widget _buildHtmlDescription(String htmlContent) {
    return Html(
      data: htmlContent,
      style: {
        "body": Style(
          margin: Margins.zero,
          padding: HtmlPaddings.zero,
          fontSize: FontSize(14.0),
          color: Colors.black87,
        ),
        "p": Style(
          margin: Margins.only(bottom: 8),
        ),
        "li": Style(
          margin: Margins.only(bottom: 8),
        ),
        "ul": Style(
          margin: Margins.only(top: 8, bottom: 8),
        ),
        "ol": Style(
          margin: Margins.only(top: 8, bottom: 8),
        ),
      },
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
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Description",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      )
                    ),
                    const SizedBox(height: 8),
                    Text(controller.podcastDescription.value,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                            height: 1.5,
                          )
                        ),
                    const SizedBox(height: 24),

                    const Text("Podcast Details",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      )
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem("Podcast Name", controller.podcastName.value),
                    _buildDetailItem("Podcast Type", controller.podcastType.value),
                    _buildDetailItem("Host Name", controller.hostName.value),

                    const SizedBox(height: 16),
                    const Text("Preferred Recording Slot(s)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      )
                    ),
                    const SizedBox(height: 8),
                    Obx( () {
                        return  Text(controller.podcastDates.join("\n"),
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          )
                        );
                      }
                    ),

                    const SizedBox(height: 24),
                    const Text("Guest Requirements",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      )
                    ),
                    const SizedBox(height: 12),
                    Text(controller.guestRequirements.value,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      )
                    ),

                    const SizedBox(height: 24),
                    Obx(() => _buildDetailItem(
                      "Preferred Language",
                      controller.preferredLanguage.value
                    )),
                    Obx(() => _buildDetailItem(
                      "Deadline for Guest Confirmation",
                      controller.guestConfirmationDeadline.value ?? ' N/A'
                    )),
                    Obx(() => _buildDetailItem(
                      "Expected Duration",
                      "${controller.expectedDuration.value}"
                    )),
                    Obx(() => _buildDetailItem(
                      "Commercial",
                      controller.commercial.value
                    )),
                    Obx(() => _buildDetailItem(
                      "Speaker Fee",
                      "\$${controller.stipendFee.value}"
                    )),
                  ],
                );
              }
            ),
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
                      const Text("Created By",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        )
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Obx(() {
                            final imageUrl = controller.profileImageUrl.value;
                            final profileInitial = controller.profileName.value.isNotEmpty
                                ? controller.profileName.value[0].toUpperCase()
                                : "A";

                            return CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.green,
                              backgroundImage: (imageUrl.isNotEmpty)
                                  ? NetworkImage(imageUrl)
                                  : null, // Only set if image is not empty
                              child: (imageUrl.isEmpty)
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
                                Text(controller.profileName.value,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  )
                                ),
                                const SizedBox(height: 4),
                                Text(controller.profileDate.value,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  )
                                ),
                                const SizedBox(height: 4),
                                Obx(() => Row(
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
                                ))

                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Beneficiary Card
          Obx(() {
            if (!controller.showOrganization.value) return const SizedBox.shrink();

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
                              errorBuilder: (context, error, stackTrace) => Icon(
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
                              Obx(() => Row(
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
                              ))
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
          Text(label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            )
          ),
          const SizedBox(height: 4),
          Text(value,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            )
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
                            itemBuilder: (context) => [
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
                      const Text(
                        "Reply",
                        style: TextStyle(color: Colors.grey),
                      ),
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
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                        title: const Text("Edit", style: TextStyle(fontSize: 14)),
                        onTap: () {
                          Navigator.pop(context);
                          // Implement edit functionality
                        },
                      ),
                      ListTile(
                        title: const Text("Delete", style: TextStyle(fontSize: 14)),
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
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.white,
            width: 0,
          ),
        ),
      ),
      child: Material(
        color: Colors.white,
        child: tabBar,
      ),
    );
  }

  @override
  double get maxExtent => 48.0;

  @override
  double get minExtent => 48.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
