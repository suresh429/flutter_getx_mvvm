class ExploreModel {
  final String id;
  final String title;
  final String requestType;
  final String requestedFor;
  final String defaultImageUrl;
  final int? startDate; // Make it nullable if the date can be null
  final int? dueDate;   // Make it nullable if the date can be null
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final String city;
  final String state;
  final String country;
  final String hostName;
  final String podcastName;
  final String format;
  bool isFavorite;
  final List<String> languages;

  ExploreModel({
    required this.id,
    required this.title,
    required this.requestType,
    required this.requestedFor,
    required this.defaultImageUrl,
    this.startDate,
    this.dueDate,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    required this.city,
    required this.state,
    required this.country,
    required this.hostName,
    required this.podcastName,
    required this.format,
  required this.isFavorite,
    required this.languages ,
  });

  factory ExploreModel.fromJson(Map<String, dynamic> json) {
    return ExploreModel(
      id: json['_id'] ?? '',  // Default value for _id if null
      title: json['title'] ?? '',  // Default value for title if null
      requestType: json['request_type'] ?? '',
      requestedFor: json['requested_for'] ?? '',
      defaultImageUrl: json['defaultImageUrl'] ?? '',  // Default empty string for image URL if null
      startDate: json['start_date'] != null ? json['start_date'] as int? : null,  // Ensure startDate can be null
      dueDate: json['due_date'] != null ? json['due_date'] as int? : null,    // Ensure dueDate can be null
      likesCount: json['likesCount'] ?? 0,  // Default value of 0 if null
      commentsCount: json['commentsCount'] ?? 0,  // Default value of 0 if null
      sharesCount: json['sharesCount'] ?? 0,  // Default value of 0 if null
      city: json['user_info']['address']['city'] ?? '',  // Default empty string for city if null
      state: json['user_info']['address']['state'] ?? '',  // Default empty string for state if null
      country: json['user_info']['address']['country'] ?? '',  // Default empty string for country if null
      hostName: json['additionalInfo']['hostName'] ?? '',  // Default empty string for hostName if null
      podcastName: json['additionalInfo']['podcastName'] ?? '',  // Default empty string for podcastName if null
      format: json['additionalInfo']['format'] ?? '',  // Default empty string for format if null
      isFavorite: json['isFavorite'] ?? false,  // Default empty string for format if null
      languages: List<String>.from(json['additionalInfo']['languages'] ?? []),  // Default empty list if languages is null
    );
  }
}
