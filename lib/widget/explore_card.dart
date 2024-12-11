import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/ExploreModel.dart';
import '../utilites/colors.dart';
import '../utilites/constants_Utils.dart';
import '../view_model/explore_controller.dart';

class ExploreCard extends StatefulWidget {
  final ExploreModel exploreModel;
  final dynamic controller; // Accepts either controller
  const ExploreCard({super.key, required this.exploreModel,required this.controller,});

  @override
  State<ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<ExploreCard> {
  @override
  Widget build(BuildContext context) {
    final ExploreController controller = Get.find<ExploreController>();
    print("object ${widget.exploreModel.isFavorite}");
    final timeLeft = ConstantsUtils.calculateTimeLeft(
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
                  child: _buildImage(),
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
                      widget.exploreModel.requestType,
                      style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 12),
                    ),
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
                    child: Obx(
                      // still OK, but rebuilds Column unnecessarily
                      () => IconButton(
                        onPressed: () {
                          widget.exploreModel.isFavorite.value =
                              !widget.exploreModel.isFavorite.value;
                          controller.addToFav(
                              [widget.exploreModel.id],
                              widget.exploreModel.isFavorite.value
                                  ? "favourite"
                                  : 'unfavourite');
                        },
                        icon: Icon(
                          widget.exploreModel.isFavorite.value
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          size: 15,
                          color: widget.exploreModel.isFavorite.value
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )
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
                      const Icon(Icons.location_on,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 1),
                      Flexible(
                        child: Text(
                          "${widget.exploreModel.city.isNotEmpty ? widget.exploreModel.city : 'Unknown City'}, ${widget.exploreModel.country.isNotEmpty ? widget.exploreModel.country : 'Unknown Country'}",
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
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
                          const Icon(Icons.timer_outlined,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 3),
                          Text(timeLeft,
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey)),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          foregroundColor: ColorUtils.colorPrimary,
                          backgroundColor: ColorUtils.colorButtonCard,
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
                              icon: const Icon(Icons.thumb_up,
                                  size: 20, color: Colors.grey),
                              onPressed: () {},
                            ),
                            Text(widget.exploreModel.likesCount.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.comment,
                                  size: 20, color: Colors.grey),
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
                                icon: const Icon(Icons.share,
                                    size: 20, color: Colors.grey),
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

  Widget _buildImage() {
    if (widget.exploreModel.defaultImageUrl.isNotEmpty) {
      return Image.network(
        widget.exploreModel.defaultImageUrl,
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
}
