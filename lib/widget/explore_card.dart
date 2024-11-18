import 'package:flutter/material.dart';

import '../model/ExploreModel.dart';
import '../utilites/colors.dart';
import '../utilites/constants.dart';

class ExploreCard extends StatefulWidget {
  final ExploreModel exploreModel;

  const ExploreCard({super.key, required this.exploreModel});

  @override
  State<ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    // Initialize the favorite status directly from the model
    isFavorite = widget.exploreModel.isFavorite;
    print('Favorite status in initState: $isFavorite');
  }

  @override
  Widget build(BuildContext context) {
    final timeLeft = calculateTimeLeft(
      widget.exploreModel.startDate ?? 0,
      widget.exploreModel.dueDate ?? 0,
    );

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
                  child: Image.network(
                    widget.exploreModel.defaultImageUrl.isNotEmpty
                        ? widget.exploreModel.defaultImageUrl
                        : 'assets/card_default_image.webp',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isFavorite = !isFavorite;
                          widget.exploreModel.isFavorite = isFavorite; // Update model
                          print('Favorite status updated to: $isFavorite');
                        });
                      },
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                        size: 15,
                        color: isFavorite ? Colors.red : Colors.grey,
                      ),
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
                  Text(
                    widget.exploreModel.title.isNotEmpty
                        ? widget.exploreModel.title
                        : 'No Title Available',
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16, color: Colors.grey),
                      const SizedBox(width: 1),
                      Flexible(
                        child: Text(
                          "${widget.exploreModel.city.isNotEmpty ? widget.exploreModel.city : 'Unknown City'}, ${widget.exploreModel.country.isNotEmpty ? widget.exploreModel.country : 'Unknown Country'}",
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.timer_outlined, size: 16, color: Colors.grey),
                          const SizedBox(width: 3),
                          Text(timeLeft, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: colorPrimary,
                          backgroundColor: colorButtonCard,
                          side: const BorderSide(color: Colors.transparent),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Details"),
                            SizedBox(width: 5),
                            Icon(Icons.arrow_forward, size: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0x82F1EEF1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.thumb_up, size: 20, color: Colors.grey),
                              onPressed: () {},
                            ),
                            Text(widget.exploreModel.likesCount.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.comment, size: 20, color: Colors.grey),
                              onPressed: () {},
                            ),
                            Text(widget.exploreModel.commentsCount.toString()),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 10.0, 0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.share, size: 20, color: Colors.grey),
                                onPressed: () {},
                              ),
                              Text(widget.exploreModel.sharesCount.toString()),
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
