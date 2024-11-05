class ExploreModel {
  final String id;
  final String title;
  final String requestType;
  final String requestedFor;
  final String defaultImageUrl;
  final int likesCount;
  final int sharesCount;
  final String city;
  final String state;
  final String country;
  final String hostName;
  final String podcastName;
  final String format;
  final List<String> languages;

  ExploreModel({
    required this.id,
    required this.title,
    required this.requestType,
    required this.requestedFor,
    required this.defaultImageUrl,
    required this.likesCount,
    required this.sharesCount,
    required this.city,
    required this.state,
    required this.country,
    required this.hostName,
    required this.podcastName,
    required this.format,
    required this.languages,
  });

  factory ExploreModel.fromJson(Map<String, dynamic> json) {
    return ExploreModel(
      id: json['_id'],
      title: json['title'],
      requestType: json['request_type'],
      requestedFor: json['requested_for'],
      defaultImageUrl: json['defaultImageUrl'] ?? '',
      likesCount: json['likesCount'] ?? 0,
      sharesCount: json['sharesCount'] ?? 0,
      city: json['user_info']['address']['city'] ?? '',
      state: json['user_info']['address']['state'] ?? '',
      country: json['user_info']['address']['country'] ?? '',
      hostName: json['additionalInfo']['hostName'] ?? '',
      podcastName: json['additionalInfo']['podcastName'] ?? '',
      format: json['additionalInfo']['format'] ?? '',
      languages: List<String>.from(json['additionalInfo']['languages'] ?? []),
    );
  }
}
