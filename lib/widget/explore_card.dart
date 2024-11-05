import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm/model/ExploreModel.dart';

class ExploreCard extends StatelessWidget {
  final ExploreModel exploreModel;

  const ExploreCard({Key? key, required this.exploreModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category Label
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      exploreModel.requestType,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Title
                  Text(
                    exploreModel.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2, // Limit to avoid overflow
                    overflow: TextOverflow.ellipsis, // Add ellipsis for overflow text
                  ),
                  const SizedBox(height: 4),
                  // Location and Country
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 1),
                      Flexible( // Use Flexible to allow dynamic sizing
                        child: Text(exploreModel.city, style: const TextStyle(fontSize: 12)),
                      ),
                      const Spacer(),
                      Flexible( // Use Flexible for country text
                        child: Text(exploreModel.country, style: const TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.thumb_up),
                            onPressed: () {},
                          ),
                          Text(exploreModel.likesCount.toString()),
                        ],
                      ),

                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.comment),
                            onPressed: () {},
                          ),
                          Text(exploreModel.sharesCount.toString()),
                        ],
                      ),

                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.share),
                            onPressed: () {},
                          ),
                          Text(exploreModel.sharesCount.toString()),
                        ],
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
  }
}
