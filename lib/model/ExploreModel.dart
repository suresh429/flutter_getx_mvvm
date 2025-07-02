import 'package:get/get.dart';
import 'details_model.dart'; // assuming OrgId and OrgAddress are inside this

class ExploreModel {
  final String id;
  final String title;
  final String requestType;
  final String requestedFor;
  final String description;
  final String whyYouNeedHelp;
  final String eventName;
  final String defaultImageUrl;
  final String units;
  final int? startDate;
  final int? dueDate;
  final int? createdAt;
  final int? quantity;
  final int? size;

  RxInt likesCount;
  RxInt commentsCount;
  RxInt sharesCount;

  final String city;
  final String state;
  final String country;

  final String hostName;
  final String podcastName;
  final String format;
  final String preferredConsultationMode;
  final List<String> languages;
  final List<String> functionalExpertise;

  OrgId? orgId;
  AdditionalInfo? additionalInfo;
  UserInfo? userInfo;
  ShippingAddress? shippingAddress;


  RxBool isFavorite;
  RxBool isLike;
  RxBool isScholarshipApplied;

  ExploreModel({
    required this.id,
    required this.title,
    required this.requestType,
    required this.requestedFor,
    required this.description,
    required this.whyYouNeedHelp,
    required this.eventName,
    required this.defaultImageUrl,
    required this.units,
    this.startDate,
    this.dueDate,
    this.createdAt,
    this.quantity,
    this.size,
    required int likesCount,
    required int commentsCount,
    required int sharesCount,
    required this.city,
    required this.state,
    required this.country,
    required this.hostName,
    required this.podcastName,
    required this.format,
    required this.preferredConsultationMode,
    required this.languages,
    required this.functionalExpertise,
    this.orgId,
    this.additionalInfo,
    this.userInfo,
    this.shippingAddress,
    required bool isFavorite,
    required bool isLike,
    required bool isScholarshipApplied,
  })  : likesCount = likesCount.obs,
        commentsCount = commentsCount.obs,
        sharesCount = sharesCount.obs,
        isFavorite = isFavorite.obs,
        isLike = isLike.obs,
        isScholarshipApplied = isScholarshipApplied.obs;

  factory ExploreModel.fromJson(Map<String, dynamic> json) {
    return ExploreModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      requestType: json['request_type'] ?? '',
      requestedFor: json['requested_for'] ?? '',
      description: json['description'] ?? '',
      whyYouNeedHelp: json['whyYouNeedHelp'] ?? '',
      eventName: json['eventName'] ?? '',
      defaultImageUrl: json['defaultImageUrl'] ?? '',
      units: json['units'] ?? '',
      startDate: json['start_date'] as int?,
      dueDate: json['due_date'] as int?,
      createdAt: json['createdAt'] as int?,
      quantity: json['quantity'] as int?,
      size: json['size'] as int?,
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
      sharesCount: json['sharesCount'] ?? 0,
      city: (json['user_info']?['address']?['city'] ?? '') as String,
      state: (json['user_info']?['address']?['state'] ?? '') as String,
      country: (json['user_info']?['address']?['country'] ?? '') as String,
      hostName: (json['additionalInfo']?['hostName'] ?? '') as String,
      podcastName: (json['additionalInfo']?['podcastName'] ?? '') as String,
      format: (json['additionalInfo']?['format'] ?? '') as String,
      preferredConsultationMode: json['preferredConsultationMode'] ?? '',
      languages: List<String>.from(json['additionalInfo']?['languages'] ?? []),
      functionalExpertise: List<String>.from(json['additionalInfo']?['functionalExpertise'] ?? []),
      isFavorite: (json['isFavourite'] ?? false) as bool,
      isLike: (json['isLike'] ?? false) as bool,
      isScholarshipApplied: (json['isScholarshipApplied'] ?? false) as bool,
      orgId: json['orgId'] != null ? OrgId.fromJson(json['orgId']) : null,
      additionalInfo: json['additionalInfo'] != null ? AdditionalInfo.fromJson(json['additionalInfo']) : null,
      userInfo: json['user_info'] != null ? UserInfo.fromJson(json['user_info']) : null,
      shippingAddress: json['shipping_address'] != null ? ShippingAddress.fromJson(json['shipping_address']) : null,
    );
  }
}
