/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

DetailsModel detailsModelFromJson(String str) => DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
    DetailsModel({
        required this.totalCountOfRecords,
        required this.data,
        required this.message,
        required this.status,
        required this.statusCode,
    });

    int totalCountOfRecords;
    List<Datum> data;
    String message;
    String status;
    int statusCode;

    factory DetailsModel.fromJson(Map<dynamic, dynamic> json) => DetailsModel(
        totalCountOfRecords: json["totalCountOfRecords"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
        status: json["status"],
        statusCode: json["statusCode"],
    );

    Map<dynamic, dynamic> toJson() => {
        "totalCountOfRecords": totalCountOfRecords,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status": status,
        "statusCode": statusCode,
    };
}

class Datum {
    Datum({
        required this.createdAt,
        required this.requestType,
        required this.userInfo,
        required this.donationRequestInfo,
        required this.connectionStatus,
        required this.id,
        required this.updatedAt,
    });

    DateTime createdAt;
    String requestType;
    UserInfo userInfo;
    DonationRequestInfo donationRequestInfo;
    int connectionStatus;
    String id;
    DateTime updatedAt;

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        createdAt: DateTime.parse(json["createdAt"]),
        requestType: json["request_type"],
        userInfo: UserInfo.fromJson(json["user_info"]),
        donationRequestInfo: DonationRequestInfo.fromJson(json["donation_request_info"]),
        connectionStatus: json["connectionStatus"],
        id: json["_id"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<dynamic, dynamic> toJson() => {
        "createdAt": createdAt.toIso8601String(),
        "request_type": requestType,
        "user_info": userInfo.toJson(),
        "donation_request_info": donationRequestInfo.toJson(),
        "connectionStatus": connectionStatus,
        "_id": id,
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class DonationRequestInfo {
    DonationRequestInfo({
        required this.requestType,
        required this.favourites,
        required this.noOfImpressions,
        required this.noOfViews,
        required this.likeCount,
        required this.requestedFor,
        required this.isPrivate,
        required this.units,
        required this.title,
        required this.noOfButtonClicks,
        required this.orgId,
        required this.shareCount,
        required this.createdAt,
        required this.userInfo,
        required this.scholarshipResponses,
        required this.fundsRecipient,
        required this.additionalInfo,
        required this.shippingAddress,
        required this.likes,
        required this.startDate,
        required this.quantity,
        required this.creatorType,
        required this.dueDate,
        required this.defaultImageUrl,
        required this.commentCount,
        required this.donatedQuantity,
        required this.name,
        required this.id,
        required this.region,
        required this.status,
    });

    String requestType;
    List<String> favourites;
    int noOfImpressions;
    int noOfViews;
    int likeCount;
    String requestedFor;
    bool isPrivate;
    String units;
    String title;
    int noOfButtonClicks;
    OrgId orgId;
    int shareCount;
    DateTime createdAt;
    UserInfo userInfo;
    List<String> scholarshipResponses;
    String fundsRecipient;
    AdditionalInfo additionalInfo;
    ShippingAddress shippingAddress;
    List<String> likes;
    int startDate;
    int quantity;
    String creatorType;
    int dueDate;
    String defaultImageUrl;
    int commentCount;
    int donatedQuantity;
    String name;
    String id;
    String region;
    int status;

    factory DonationRequestInfo.fromJson(Map<dynamic, dynamic> json) => DonationRequestInfo(
        requestType: json["request_type"],
        favourites: List<String>.from(json["favourites"].map((x) => x)),
        noOfImpressions: json["noOfImpressions"],
        noOfViews: json["noOfViews"],
        likeCount: json["likeCount"],
        requestedFor: json["requested_for"],
        isPrivate: json["isPrivate"],
        units: json["units"],
        title: json["title"],
        noOfButtonClicks: json["noOfButtonClicks"],
        orgId: OrgId.fromJson(json["orgId"]),
        shareCount: json["shareCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        userInfo: UserInfo.fromJson(json["user_info"]),
        scholarshipResponses: List<String>.from(json["scholarshipResponses"].map((x) => x)),
        fundsRecipient: json["fundsRecipient"],
        additionalInfo: AdditionalInfo.fromJson(json["additionalInfo"]),
        shippingAddress: ShippingAddress.fromJson(json["shipping_address"]),
        likes: List<String>.from(json["likes"].map((x) => x)),
        startDate: json["start_date"],
        quantity: json["quantity"],
        creatorType: json["creatorType"],
        dueDate: json["due_date"],
        defaultImageUrl: json["defaultImageUrl"],
        commentCount: json["commentCount"],
        donatedQuantity: json["donated_quantity"],
        name: json["name"],
        id: json["_id"],
        region: json["region"],
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "request_type": requestType,
        "favourites": List<dynamic>.from(favourites.map((x) => x)),
        "noOfImpressions": noOfImpressions,
        "noOfViews": noOfViews,
        "likeCount": likeCount,
        "requested_for": requestedFor,
        "isPrivate": isPrivate,
        "units": units,
        "title": title,
        "noOfButtonClicks": noOfButtonClicks,
        "orgId": orgId.toJson(),
        "shareCount": shareCount,
        "createdAt": createdAt.toIso8601String(),
        "user_info": userInfo.toJson(),
        "scholarshipResponses": List<dynamic>.from(scholarshipResponses.map((x) => x)),
        "fundsRecipient": fundsRecipient,
        "additionalInfo": additionalInfo.toJson(),
        "shipping_address": shippingAddress.toJson(),
        "likes": List<dynamic>.from(likes.map((x) => x)),
        "start_date": startDate,
        "quantity": quantity,
        "creatorType": creatorType,
        "due_date": dueDate,
        "defaultImageUrl": defaultImageUrl,
        "commentCount": commentCount,
        "donated_quantity": donatedQuantity,
        "name": name,
        "_id": id,
        "region": region,
        "status": status,
    };
}

class AdditionalInfo {
    AdditionalInfo({
        required this.podcastDate,
        required this.duration,
        required this.preferredConsultationMode,
        required this.hostName,
        required this.preferredTopics,
        required this.languages,
        required this.podcastDate2,
        required this.interviewOrPanelDiscussion,
        required this.format,
        required this.podcastName,
        required this.podcastDate1,
        required this.podcastWebsite,
    });

    int podcastDate;
    String duration;
    String preferredConsultationMode;
    String hostName;
    String preferredTopics;
    List<String> languages;
    int podcastDate2;
    String interviewOrPanelDiscussion;
    String format;
    String podcastName;
    int podcastDate1;
    String podcastWebsite;

    factory AdditionalInfo.fromJson(Map<dynamic, dynamic> json) => AdditionalInfo(
        podcastDate: json["podcastDate"],
        duration: json["duration"],
        preferredConsultationMode: json["preferredConsultationMode"],
        hostName: json["hostName"],
        preferredTopics: json["preferredTopics"],
        languages: List<String>.from(json["languages"].map((x) => x)),
        podcastDate2: json["podcastDate2"],
        interviewOrPanelDiscussion: json["interviewOrPanelDiscussion"],
        format: json["format"],
        podcastName: json["podcastName"],
        podcastDate1: json["podcastDate1"],
        podcastWebsite: json["podcastWebsite"],
    );

    Map<dynamic, dynamic> toJson() => {
        "podcastDate": podcastDate,
        "duration": duration,
        "preferredConsultationMode": preferredConsultationMode,
        "hostName": hostName,
        "preferredTopics": preferredTopics,
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "podcastDate2": podcastDate2,
        "interviewOrPanelDiscussion": interviewOrPanelDiscussion,
        "format": format,
        "podcastName": podcastName,
        "podcastDate1": podcastDate1,
        "podcastWebsite": podcastWebsite,
    };
}

class OrgId {
    OrgId({
        this.orgName,
        this.orgEmail,
        this.websiteUrl,
        this.orgAddress,
        this.id,
        this.defaultImageUrl,
        this.createdAt,
    });

    String? orgName;
    String? orgEmail;
    String? websiteUrl;
    OrgAddress? orgAddress;
    String? id;
    String? defaultImageUrl;
    String? createdAt;

    factory OrgId.fromJson(Map<dynamic, dynamic> json) => OrgId(
        orgName: json["orgName"],
        orgEmail: json["orgEmail"],
        websiteUrl: json["websiteUrl"],
        orgAddress: json["orgAddress"] != null ? OrgAddress.fromJson(json["orgAddress"]) : null,
        id: json["_id"],
        defaultImageUrl: json["defaultImageUrl"],
        createdAt: json["createdAt"],
    );

    Map<dynamic, dynamic> toJson() => {
        "orgName": orgName,
        "orgEmail": orgEmail,
        "websiteUrl": websiteUrl,
        "orgAddress": orgAddress?.toJson(),
        "_id": id,
        "defaultImageUrl": defaultImageUrl,
        "createdAt": createdAt,
    };
}


class OrgAddress {
    OrgAddress({
        this.country,
        this.city,
        this.state,
        this.line2,
        this.line1,
        this.zipCode,
    });

    String? country;
    String? city;
    String? state;
    String? line2;
    String? line1;
    String? zipCode;

    factory OrgAddress.fromJson(Map<dynamic, dynamic> json) => OrgAddress(
        country: json["country"],
        city: json["city"],
        state: json["state"],
        line2: json["line2"],
        line1: json["line1"],
        zipCode: json["zip_code"],
    );

    Map<dynamic, dynamic> toJson() => {
        "country": country,
        "city": city,
        "state": state,
        "line2": line2,
        "line1": line1,
        "zip_code": zipCode,
    };
}

class ShippingAddress {
    ShippingAddress();

    factory ShippingAddress.fromJson(Map<dynamic, dynamic> json) => ShippingAddress(
    );

    Map<dynamic, dynamic> toJson() => {
    };
}

class UserInfo {
    UserInfo({
        required this.noOfTimesDonated,
        this.allergies,
        required this.isBloodDonor,
        required this.address,
        required this.gender,
        required this.imageUrl,
        required this.bloodDonationCategory,
        required this.anyAllergies,
        this.medication,
        required this.countriesVisited,
        required this.outOfCountryTravel12Months,
        required this.takingMedication,
        required this.bloodGroup,
        required this.phone,
        required this.name,
        this.isTransmissibleDiseaseHistory,
        required this.lastDonatedDate,
        this.transmissibleDiseaseHistory,
        required this.id,
        required this.email,
        required this.isDonatedBefore,
        required this.isPlateletsDonor,
        required this.username,
    });

    int noOfTimesDonated;
    String? allergies;
    bool isBloodDonor;
    Address address;
    String gender;
    String imageUrl;
    List<String> bloodDonationCategory;
    bool anyAllergies;
    String? medication;
    String countriesVisited;
    bool outOfCountryTravel12Months;
    bool takingMedication;
    String bloodGroup;
    String phone;
    Name name;
    bool? isTransmissibleDiseaseHistory;
    int lastDonatedDate;
    String? transmissibleDiseaseHistory;
    String id;
    String email;
    bool isDonatedBefore;
    bool isPlateletsDonor;
    String username;

    factory UserInfo.fromJson(Map<dynamic, dynamic> json) => UserInfo(
        noOfTimesDonated: json["noOfTimesDonated"],
        allergies: json["allergies"],
        isBloodDonor: json["isBloodDonor"],
        address: Address.fromJson(json["address"]),
        gender: json["gender"],
        imageUrl: json["image_url"],
        bloodDonationCategory: List<String>.from(json["bloodDonationCategory"].map((x) => x)),
        anyAllergies: json["anyAllergies"],
        medication: json["medication"],
        countriesVisited: json["countriesVisited"],
        outOfCountryTravel12Months: json["outOfCountryTravel12months"],
        takingMedication: json["takingMedication"],
        bloodGroup: json["bloodGroup"],
        phone: json["phone"],
        name: Name.fromJson(json["name"]),
        isTransmissibleDiseaseHistory: json["isTransmissibleDiseaseHistory"],
        lastDonatedDate: json["lastDonatedDate"],
        transmissibleDiseaseHistory: json["transmissibleDiseaseHistory"],
        id: json["_id"],
        email: json["email"],
        isDonatedBefore: json["isDonatedBefore"],
        isPlateletsDonor: json["isPlateletsDonor"],
        username: json["username"],
    );

    Map<dynamic, dynamic> toJson() => {
        "noOfTimesDonated": noOfTimesDonated,
        "allergies": allergies,
        "isBloodDonor": isBloodDonor,
        "address": address.toJson(),
        "gender": gender,
        "image_url": imageUrl,
        "bloodDonationCategory": List<dynamic>.from(bloodDonationCategory.map((x) => x)),
        "anyAllergies": anyAllergies,
        "medication": medication,
        "countriesVisited": countriesVisited,
        "outOfCountryTravel12months": outOfCountryTravel12Months,
        "takingMedication": takingMedication,
        "bloodGroup": bloodGroup,
        "phone": phone,
        "name": name.toJson(),
        "isTransmissibleDiseaseHistory": isTransmissibleDiseaseHistory,
        "lastDonatedDate": lastDonatedDate,
        "transmissibleDiseaseHistory": transmissibleDiseaseHistory,
        "_id": id,
        "email": email,
        "isDonatedBefore": isDonatedBefore,
        "isPlateletsDonor": isPlateletsDonor,
        "username": username,
    };
}

class Address {
    Address({
        required this.country,
        required this.city,
        required this.district,
        required this.state,
        required this.village,
        required this.line2,
        required this.line1,
        required this.zipCode,
        required this.mandal,
    });

    String country;
    String city;
    String district;
    String state;
    String village;
    String line2;
    String line1;
    String zipCode;
    String mandal;

    factory Address.fromJson(Map<dynamic, dynamic> json) => Address(
        country: json["country"],
        city: json["city"],
        district: json["district"],
        state: json["state"],
        village: json["village"],
        line2: json["line2"],
        line1: json["line1"],
        zipCode: json["zip_code"],
        mandal: json["mandal"],
    );

    Map<dynamic, dynamic> toJson() => {
        "country": country,
        "city": city,
        "district": district,
        "state": state,
        "village": village,
        "line2": line2,
        "line1": line1,
        "zip_code": zipCode,
        "mandal": mandal,
    };
}

class Name {
    Name({
        required this.lastName,
        required this.middleName,
        required this.firstName,
    });

    String lastName;
    String middleName;
    String firstName;

    factory Name.fromJson(Map<dynamic, dynamic> json) => Name(
        lastName: json["last_name"],
        middleName: json["middle_name"],
        firstName: json["first_name"],
    );

    Map<dynamic, dynamic> toJson() => {
        "last_name": lastName,
        "middle_name": middleName,
        "first_name": firstName,
    };
}
