import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/vote_leader_model.dart';
import '../utilites/colors.dart';

class ViewProfileBottomSheet extends StatelessWidget {
  final Datum data;
  final ScrollController scrollController;
  final BuildContext bottomSheetContext;

  const ViewProfileBottomSheet({
    Key? key,
    required this.data,
    required this.scrollController,
    required this.bottomSheetContext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            width: 40.0,
            height: 4.0,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
          // Close button
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0, right: 8.0),
              child: InkWell(
                onTap: () => Navigator.pop(bottomSheetContext), // Use bottom sheet context
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 24.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0, bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Info Section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CachedNetworkImage(
                          imageUrl: data.imageUrl ?? '',
                          width: 80.0,
                          height: 80.0,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => SvgPicture.asset(
                            'assets/profile_placeholder.svg',
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          ),
                          errorWidget: (context, url, error) => SvgPicture.asset(
                            'assets/profile_placeholder.svg',
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data.name?.firstName ?? ''} ${data.name?.lastName ?? ''}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              data.currentRole?.isNotEmpty == true ? data.currentRole! : '-------',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              data.currentCompanyName?.isNotEmpty == true
                                  ? data.currentCompanyName!
                                  : '-------',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Divider
                  const SizedBox(height: 16.0),
                  const Divider(color: Color(0xFFD3D3D3), height: 1.0),
                  const SizedBox(height: 16.0),
                  // Contact Info Section
                  Text(
                    'Contact Info / Location',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Email
                  Text(
                    'Email Address',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    data.email?.isNotEmpty == true ? data.email! : '-------',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Phone
                  Text(
                    'Phone Number',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    data.phone?.isNotEmpty == true ? data.phone! : '-------',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  // Location
                  Text(
                    'Location',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    _formatAddress(data.address),
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                  // Divider
                  const SizedBox(height: 16.0),
                  const Divider(color: Color(0xFFD3D3D3), height: 1.0),
                  const SizedBox(height: 16.0),
                  // Company Info Section
                  Text(
                    'Company Info',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Company Name',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    data.currentCompanyName?.isNotEmpty == true
                        ? data.currentCompanyName!
                        : '-------',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Current Role/Designation',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    data.currentRole?.isNotEmpty == true ? data.currentRole! : '-------',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                  // Divider
                  const SizedBox(height: 16.0),
                  const Divider(color: Color(0xFFD3D3D3), height: 1.0),
                  const SizedBox(height: 16.0),
                  // Areas of Interest Section
                  Text(
                    'Areas of Interest',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: data.areasOfInterest?.map((interest) {
                      return Chip(
                        label: Text(interest),
                        backgroundColor: Colors.grey[200],
                        labelStyle: const TextStyle(color: Colors.black),
                      );
                    }).toList() ??
                        [],
                  ),
                  // Divider
                  const SizedBox(height: 16.0),
                  const Divider(color: Color(0xFFD3D3D3), height: 1.0),
                  const SizedBox(height: 16.0),
                  // Additional Information Section
                  Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'What impact would you like to make on society and causes you are interested in serving?',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    data.typeOfHelpAndInvolvement?.join(', ') ?? '-------',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'How would you like to serve and make an impact in causes you are interested in?',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    data.serveAndMakeImpact?.isNotEmpty == true
                        ? data.serveAndMakeImpact!
                        : '-------',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Are you willing to give at least one hour per week?',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    data.oneHourPerWeek == true ? 'Yes' : 'No',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Are you willing to be in a management/leadership position in Touch-A-Life?',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    data.managementPosition == true ? 'Yes' : 'No',
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black54,
                    ),
                  ),
                  // Divider
                  const SizedBox(height: 16.0),
                  const Divider(color: Color(0xFFD3D3D3), height: 1.0),
                  const SizedBox(height: 16.0),
                  // LinkedIn Profile Section
                  Text(
                    'LinkedIn profile',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.colorRoyalBlue,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  GestureDetector(
                    onTap: () async {
                      final url = data.linkedInProfileUrl;
                      if (url != null && url.isNotEmpty && url.startsWith('http')) {
                        final uri = Uri.parse(url);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri, mode: LaunchMode.externalApplication);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid LinkedIn URL')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Invalid LinkedIn URL')),
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.link, size: 16.0),
                          SizedBox(width: 5.0),
                          Text(
                            'LinkedIn',
                            style: TextStyle(fontSize: 12.0, color: Colors.black),
                          ),
                          SizedBox(width: 5.0),
                          Icon(Icons.open_in_new, size: 16.0),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0), // Extra padding at bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatAddress(Address? address) {
    final parts = [
      address?.city,
      address?.state,
      address?.country,
    ].where((e) => e != null && e.isNotEmpty).toList();
    return parts.isNotEmpty ? parts.join(', ') : 'Address not available';
  }
}