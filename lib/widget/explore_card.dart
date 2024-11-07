import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/model/ExploreModel.dart';

import '../utilites/constants.dart';

class ExploreCard extends StatelessWidget {
  final ExploreModel exploreModel;

  const ExploreCard({Key? key, required this.exploreModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeLeft = calculateTimeLeft(exploreModel.startDate, exploreModel.dueDate);
    return SizedBox(
      width: 300, // Set a fixed width for horizontal orientation
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            Stack(
              children: [
                // Image
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image.network(
                    exploreModel.defaultImageUrl,
                    height: 100, // Adjust the height as needed
                    width: double.infinity,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // Image is loaded
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/card_default_image.webp', // Placeholder image
                        height: 100,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                // Positioned label at the bottom left of the image
                Positioned(
                  bottom: 8, // Position 8px from the bottom
                  left: 8, // Position 8px from the left
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      exploreModel.requestType,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    exploreModel.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2, // Limit to avoid overflow
                    overflow:
                        TextOverflow.ellipsis, // Add ellipsis for overflow text
                  ),
                  const SizedBox(height: 8),
                  // Location and Country
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 1),
                      Flexible(
                        // Use Flexible to allow dynamic sizing
                        child: Text(
                            "${exploreModel.city},${exploreModel.country}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.grey)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // times ago and details button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Row(
                        children: [
                          const Icon(Icons.timer_outlined,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 3),
                          Text(timeLeft,
                              style: const TextStyle(fontSize: 12, color: Colors.grey))
                        ],
                      ),

                      SizedBox(
                        width: 100, // Set button width
                        height: 35,
                        child: ElevatedButton(
                            onPressed: () {
                              // Define what happens when the button is pressed
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFFEC1C24), backgroundColor: const Color(0xFFF3D9DA), side: const BorderSide(color: Colors.transparent),
                              // Outline color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 10), // Text color
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Details"),
                                SizedBox(width: 5), // Space between text and icon
                                Icon(Icons.arrow_forward, size: 16), // Icon on the right side
                              ],
                            ),),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Action buttons
                  Container(
                    decoration :BoxDecoration(
                      color: const Color(0x82F1EEF1), // Background color of the container
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.thumb_up,
                                  size: 20, color: Colors.grey),
                              onPressed: () {},
                            ),
                            Text(exploreModel.likesCount.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.comment,
                                  size: 20, color: Colors.grey),
                              onPressed: () {},
                            ),
                            Text(exploreModel.commentsCount.toString()),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.share,
                                    size: 20, color: Colors.grey),
                                onPressed: () {},
                              ),
                              Text(exploreModel.sharesCount.toString()),
                            ],
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
      ),
    );
  }
}
