// Address model
import 'package:get/get.dart';

class Address {
  final String? line1;
  final String? line2;
  final String? city;
  final String? state;
  final String? zipCode;
  final String? country;

  Address({
    this.line1,
    this.line2,
    this.city,
    this.state,
    this.zipCode,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      line1: json['line1'] as String?,
      line2: json['line2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      zipCode: json['zip_code'] as String?,
      country: json['country'] as String?,
    );
  }
}

// UserInfo model
class UserInfo {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? email;
  final String? phone;
  final String? imageUrl;
  final String? gender;
  final Address? address;
  final bool? takingMedication;
  final bool? anyAllergies;
  final bool? outOfCountryTravel12months;
  final bool? isBloodDonor;
  final List<String>? bloodDonationCategory;
  final String? bloodGroup;
  final String? countriesVisited;
  final bool? isDonatedBefore;
  final int? lastDonatedDate;
  final int? noOfTimesDonated;
  final bool? isPlateletsDonor;

  UserInfo({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.email,
    this.phone,
    this.imageUrl,
    this.gender,
    this.address,
    this.takingMedication,
    this.anyAllergies,
    this.outOfCountryTravel12months,
    this.isBloodDonor,
    this.bloodDonationCategory,
    this.bloodGroup,
    this.countriesVisited,
    this.isDonatedBefore,
    this.lastDonatedDate,
    this.noOfTimesDonated,
    this.isPlateletsDonor,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'] as String?,
      firstName: json['name']?['first_name'] as String?,
      lastName: json['name']?['last_name'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      imageUrl: json['image_url'] as String?,
      gender: json['gender'] as String?,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      takingMedication: json['takingMedication'] as bool?,
      anyAllergies: json['anyAllergies'] as bool?,
      outOfCountryTravel12months: json['outOfCountryTravel12months'] as bool?,
      isBloodDonor: json['isBloodDonor'] as bool?,
      bloodDonationCategory:
      (json['bloodDonationCategory'] as List?)?.map((e) => e as String).toList(),
      bloodGroup: json['bloodGroup'] as String?,
      countriesVisited: json['countriesVisited'] as String?,
      isDonatedBefore: json['isDonatedBefore'] as bool?,
      lastDonatedDate: json['lastDonatedDate'] as int?,
      noOfTimesDonated: json['noOfTimesDonated'] as int?,
      isPlateletsDonor: json['isPlateletsDonor'] as bool?,
    );
  }
}

// DonationRequestInfo model
class DonationRequestInfo {
  final String? id;
  final Address? shippingAddress;
  final Map<String, dynamic>? hospitalInfo;
  final int? donatedQuantity;
  final String? requestType;
  final String? creatorType;
  final String? defaultImageUrl;
  final int? dueDate;
  final int? maxQuantity;
  final String? title;
  final List<String>? likes;
  final int? likeCount;
  final int? commentCount;
  final int? shareCount;
  final List<String>? favourites;
  final String? region;
  final int? status;
  final String? createdAt;


  DonationRequestInfo({
    this.id,
    this.shippingAddress,
    this.hospitalInfo,
    this.donatedQuantity,
    this.requestType,
    this.creatorType,
    this.defaultImageUrl,
    this.dueDate,
    this.maxQuantity,
    this.title,
    this.likes,
    this.likeCount,
    this.commentCount,
    this.shareCount,
    this.favourites,
    this.region,
    this.status,
    this.createdAt,

  });

  factory DonationRequestInfo.fromJson(Map<String, dynamic> json) {
    return DonationRequestInfo(
      id: json['_id'] as String?,
      shippingAddress: json['shipping_address'] != null
          ? Address.fromJson(json['shipping_address'])
          : null,
      hospitalInfo: json['hospitalInfo'] as Map<String, dynamic>?,
      donatedQuantity: json['donated_quantity'] as int?,
      requestType: json['request_type'] as String?,
      creatorType: json['creatorType'] as String?,
      defaultImageUrl: json['defaultImageUrl'] as String?,
      dueDate: json['due_date'] as int?,
      maxQuantity: json['maxQuantity'] as int?,
      title: json['title'] as String?,
      likes: (json['likes'] as List?)?.map((e) => e as String).toList(),
      likeCount: json['likeCount'] as int?,
      commentCount: json['commentCount'] as int?,
      shareCount: json['shareCount'] as int?,
      favourites: (json['favourites'] as List?)?.map((e) => e as String).toList(),
      region: json['region'] as String?,
      status: json['status'] as int?,
      createdAt: json['createdAt'] as String?,
    );
  }
}

// Main DonationRequestResponse model
class DonationRequestResponse {
  final String? id;
  final Address? address;
  final String? request_type;
  final UserInfo? participantName;
  final DonationRequestInfo? donationRequestInfo;
  final UserInfo? userInfo;
  final RxBool reminderSent; // Change to non-nullable RxBool

  DonationRequestResponse({
    this.id,
    this.address,
    this.request_type,
    this.participantName,
    this.donationRequestInfo,
    this.userInfo,
    required this.reminderSent, // Mark as required
  });

  factory DonationRequestResponse.fromJson(Map<String, dynamic> json) {
    return DonationRequestResponse(
      id: json['_id'] as String?,
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      request_type: json['request_type'] as String?,
      participantName: json['participantName'] != null
          ? UserInfo.fromJson(json['participantName'])
          : null,
      donationRequestInfo: json['donation_request_info'] != null
          ? DonationRequestInfo.fromJson(json['donation_request_info'])
          : null,
      userInfo: json['user_info'] != null
          ? UserInfo.fromJson(json['user_info'])
          : null,
      reminderSent: RxBool(json['reminderSent'] ?? false), // Explicitly initialize RxBool
    );
  }
}


// Complete Response model
class DonationRequestResponseData {
  final String? status;
  final int? statusCode;
  final String? message;
  final List<DonationRequestResponse>? data;
  final int? totalCountOfRecords;

  DonationRequestResponseData({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.totalCountOfRecords,
  });

  factory DonationRequestResponseData.fromJson(Map<String, dynamic> json) {
    return DonationRequestResponseData(
      status: json['status'] as String?,
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List?)
          ?.map((e) => DonationRequestResponse.fromJson(e))
          .toList(),
      totalCountOfRecords: json['totalCountOfRecords'] as int?,
    );
  }
}
