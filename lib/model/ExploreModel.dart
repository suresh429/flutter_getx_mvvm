import 'package:get/get.dart';

class ExploreModel {
  final String id;
  final String title;
  final String requestType;
  final String requestedFor;
  final String defaultImageUrl;
  final int? startDate; // Nullable for optional dates
  final int? dueDate; // Nullable for optional dates
  RxInt likesCount; // Changed from late final RxInt to final RxInt
  final int commentsCount;
  RxInt sharesCount;
  final String city;
  final String state;
  final String country;
  final String hostName;
  final String podcastName;
  final String format;
  final List<String> languages;
  final RxBool isFavorite;
  final RxBool isLike;

  ExploreModel({
    required this.id,
    required this.title,
    required this.requestType,
    required this.requestedFor,
    required this.defaultImageUrl,
    this.startDate,
    this.dueDate,
    required int likesCount, // Pass an int and convert to RxInt
    required this.commentsCount,
    required int sharesCount,
    required this.city,
    required this.state,
    required this.country,
    required this.hostName,
    required this.podcastName,
    required this.format,
    required this.languages,
    required bool isFavorite,
    required bool isLike,
  })  : likesCount = likesCount.obs,
        sharesCount = sharesCount.obs,
        // Convert to RxInt
        isFavorite = isFavorite.obs,
        isLike = isLike.obs;

  /// Factory to parse JSON into the model
  factory ExploreModel.fromJson(Map<String, dynamic> json) {
    return ExploreModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      requestType: json['request_type'] ?? '',
      requestedFor: json['requested_for'] ?? '',
      defaultImageUrl: json['defaultImageUrl'] ?? '',
      startDate: json['start_date'] as int?,
      // Ensure startDate is nullable
      dueDate: json['due_date'] as int?,
      // Ensure dueDate is nullable
      likesCount: json['likesCount'] ?? 0,
      // Pass int
      commentsCount: json['commentsCount'] ?? 0,
      sharesCount: json['sharesCount'] ?? 0,
      city: (json['user_info']?['address']?['city'] ?? '') as String,
      state: (json['user_info']?['address']?['state'] ?? '') as String,
      country: (json['user_info']?['address']?['country'] ?? '') as String,
      hostName: (json['additionalInfo']?['hostName'] ?? '') as String,
      podcastName: (json['additionalInfo']?['podcastName'] ?? '') as String,
      format: (json['additionalInfo']?['format'] ?? '') as String,
      languages: List<String>.from(json['additionalInfo']?['languages'] ?? []),
      isFavorite: (json['isFavourite'] ?? false) as bool,
      isLike: (json['isLike'] ?? false) as bool,
    );
  }
}
