import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  late final dynamic exploreModel;

  @override
  void initState() {
    super.initState();
    exploreModel = Get.arguments;
    _tabController = TabController(length: 3, vsync: this);
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
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 280,
                floating: false,
                pinned: true,
                elevation: 0,
                toolbarHeight: 0, // Set to 0 to hide app bar when collapsed
                backgroundColor: Colors.white,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: Container(
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      padding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 16),
                      tabs: const [
                        Tab(text: 'Request Info'),
                        Tab(text: 'Uploads (1)'),
                        Tab(text: 'Comments'),
                      ],
                      labelColor: Colors.black,
                      indicatorColor: Colors.red,
                    ),
                  ),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      // Banner Image
                      Image.asset(
                        'assets/banner_image.png',
                        width: double.infinity,
                        height: 280,
                        fit: BoxFit.cover,
                      ),
                      // Add a gradient overlay for better text visibility at top
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: 100,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.black.withOpacity(0.7),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Back button and title
                      Positioned(
                        top: MediaQuery.of(context).padding.top,
                        left: 0,
                        right: 0,
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          leading: IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () => Get.back(),
                          ),
                          title: Text(
                            exploreModel?.title ?? "Request Details",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      // Header Card Overlay
                      Positioned(
                        bottom: 0,
                        left: 16,
                        right: 16,
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: _buildHeaderCard(),
                          ),
                        ),
                      ),
                    ],
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
              SingleChildScrollView(
                child: _buildComments(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
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
      ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.thumb_up_off_alt, color: Colors.black54),
            Icon(Icons.comment, color: Colors.black54),
            Icon(Icons.share, color: Colors.black54),
          ],
        )
      ],
    );
  }

  Widget _buildRequestInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("General Board Meeting"),
          const SizedBox(height: 10),
          const Text("Skills/ Expertise Needed", style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: const [
              Chip(label: Text("Management")),
              Chip(label: Text("Fundraising")),
              Chip(label: Text("Operations")),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Expected Time(hours/month): 26"),
          const Text("Term length(Years): 3"),
          const SizedBox(height: 10),
          const Text("Personality Traits", style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: const [
              Chip(label: Text("Trustworthy")),
              Chip(label: Text("Approachable")),
              Chip(label: Text("Diligent")),
            ],
          ),
          const SizedBox(height: 10),
          const Text("Board Member Responsibilities"),
          const Text("Test Responsibility"),
          const SizedBox(height: 10),
          const Text("Qualifications Required", style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 8,
            children: const [
              Chip(label: Text("Experience in nonprofit management")),
              Chip(label: Text("Financial expertise")),
              Chip(label: Text("Legal expertise")),
            ],
          ),
          const SizedBox(height: 20),
          const Text("Requested Date", style: TextStyle(fontWeight: FontWeight.bold)),
          const Text("December 17, 2025"),
          const SizedBox(height: 20),
          _buildInfoCard("Created By", "Harishwar Miryanam", "17-Jun-2025", "Hyderabad", Colors.purple, 'H'),
          const SizedBox(height: 10),
          _buildInfoCard("Beneficiary", "New Organization", "05-Jun-2025", "West Delhi", Colors.red, 'O'),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String name, String date, String location, Color avatarColor, String initial) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Divider(),
            Row(
              children: [
                CircleAvatar(radius: 24, backgroundColor: avatarColor, child: Text(initial, style: const TextStyle(color: Colors.white))),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                    Text(date),
                    Row(children: [const Icon(Icons.location_on, size: 14), Text(location)])
                  ],
                )
              ],
            )
          ],
        ),
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              CircleAvatar(backgroundImage: AssetImage('assets/avatar.png')),
              SizedBox(width: 8),
              Text("LaLisa Manoban", style: TextStyle(fontWeight: FontWeight.bold)),
              Spacer(),
              Text("20-Jun-2025 02:35 PM", style: TextStyle(fontSize: 12))
            ],
          ),
          const SizedBox(height: 8),
          const Text("hi"),
          const SizedBox(height: 8),
          Row(
            children: const [
              Text("Reply", style: TextStyle(color: Colors.blue)),
              Spacer(),
              Icon(Icons.edit),
              SizedBox(width: 10),
              Icon(Icons.delete),
            ],
          ),
          const Divider(),
          Row(
            children: [
              const CircleAvatar(backgroundImage: AssetImage('assets/avatar.png'), radius: 16),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Add a comment...",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.send, color: Colors.red),
                      onPressed: () {},
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              )
            ],
          )
        ],
      ),
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
  double get maxExtent => 48.0; // Fixed height for the tab bar

  @override
  double get minExtent => 48.0; // Same as maxExtent for consistent height

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => false;
}
