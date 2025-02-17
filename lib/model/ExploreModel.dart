import 'package:get/get.dart';

class ExploreModel {
  final String id;
  final String title;
  final String requestType;
  final String requestedFor;
  final String defaultImageUrl;
  final int? startDate; // Nullable for optional dates
  final int? dueDate; // Nullable for optional dates
  RxInt likesCount; // Reactive integer for likes count
  final int commentsCount;
  RxInt sharesCount; // Reactive integer for shares count
  final String city;
  final String state;
  final String country;
  final String hostName;
  final String podcastName;
  final String format;
  final List<String> languages;
  RxBool isFavorite; // Reactive boolean for favorite status
  RxBool isLike; // Reactive boolean for like status

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
    required int sharesCount, // Pass an int and convert to RxInt
    required this.city,
    required this.state,
    required this.country,
    required this.hostName,
    required this.podcastName,
    required this.format,
    required this.languages,
    required bool isFavorite, // Pass a bool and convert to RxBool
    required bool isLike, // Pass a bool and convert to RxBool
  })  : likesCount = likesCount.obs,
        sharesCount = sharesCount.obs,
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
      startDate: json['start_date'] as int?, // Ensure startDate is nullable
      dueDate: json['due_date'] as int?, // Ensure dueDate is nullable
      likesCount: json['likesCount'] ?? 0, // Pass int and handle null
      commentsCount: json['commentsCount'] ?? 0, // Pass int and handle null
      sharesCount: json['sharesCount'] ?? 0, // Pass int and handle null
      city: (json['user_info']?['address']?['city'] ?? '') as String,
      state: (json['user_info']?['address']?['state'] ?? '') as String,
      country: (json['user_info']?['address']?['country'] ?? '') as String,
      hostName: (json['additionalInfo']?['hostName'] ?? '') as String,
      podcastName: (json['additionalInfo']?['podcastName'] ?? '') as String,
      format: (json['additionalInfo']?['format'] ?? '') as String,
      languages: List<String>.from(json['additionalInfo']?['languages'] ?? []),
      isFavorite: (json['isFavourite'] ?? false) as bool, // Handle null
      isLike: (json['isLike'] ?? false) as bool, // Handle null
    );
  }
}