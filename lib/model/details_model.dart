import 'dart:convert';

DetailsModel detailsModelFromJson(String str) => DetailsModel.fromJson(json.decode(str));

String detailsModelToJson(DetailsModel data) => json.encode(data.toJson());

class DetailsModel {
    DetailsModel({
        this.totalCountOfRecords,
        this.data,
        this.message,
        this.status,
        this.statusCode,
    });

    int? totalCountOfRecords;
    List<Datum>? data;
    String? message;
    String? status;
    int? statusCode;

    factory DetailsModel.fromJson(Map<dynamic, dynamic> json) => DetailsModel(
        totalCountOfRecords: json["totalCountOfRecords"] as int? ?? 0,
        data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) : [],
        message: json["message"] as String? ?? '',
        status: json["status"] as String? ?? '',
        statusCode: json["statusCode"] as int? ?? 0,
    );

    Map<dynamic, dynamic> toJson() => {
        "totalCountOfRecords": totalCountOfRecords,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : [],
        "message": message,
        "status": status,
        "statusCode": statusCode,
    };
}

class Datum {
    Datum({
        this.createdAt,
        this.requestType,
        this.userInfo,
        this.donationRequestInfo,
        this.connectionStatus,
        this.id,
        this.updatedAt,
    });

    DateTime? createdAt;
    String? requestType;
    UserInfo? userInfo;
    DonationRequestInfo? donationRequestInfo;
    int? connectionStatus;
    String? id;
    DateTime? updatedAt;

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"] as String) : null,
        requestType: json["request_type"] as String? ?? '',
        userInfo: json["user_info"] != null ? UserInfo.fromJson(json["user_info"]) : null,
        donationRequestInfo: json["donation_request_info"] != null ? DonationRequestInfo.fromJson(json["donation_request_info"]) : null,
        connectionStatus: json["connectionStatus"] as int? ?? 0,
        id: json["_id"] as String? ?? '',
        updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"] as String) : null,
    );

    Map<dynamic, dynamic> toJson() => {
        "createdAt": createdAt?.toIso8601String(),
        "request_type": requestType,
        "user_info": userInfo?.toJson(),
        "donation_request_info": donationRequestInfo?.toJson(),
        "connectionStatus": connectionStatus,
        "_id": id,
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class DonationRequestInfo {
    DonationRequestInfo({
        this.requestType,
        this.favourites,
        this.noOfImpressions,
        this.noOfViews,
        this.likeCount,
        this.requestedFor,
        this.isPrivate,
        this.units,
        this.title,
        this.noOfButtonClicks,
        this.orgId,
        this.shareCount,
        this.createdAt,
        this.userInfo,
        this.scholarshipResponses,
        this.fundsRecipient,
        this.additionalInfo,
        this.shippingAddress,
        this.likes,
        this.startDate,
        this.quantity,
        this.creatorType,
        this.dueDate,
        this.defaultImageUrl,
        this.commentCount,
        this.donatedQuantity,
        this.name,
        this.id,
        this.region,
        this.status,
    });

    String? requestType;
    List<String>? favourites;
    int? noOfImpressions;
    int? noOfViews;
    int? likeCount;
    String? requestedFor;
    bool? isPrivate;
    String? units;
    String? title;
    int? noOfButtonClicks;
    OrgId? orgId;
    int? shareCount;
    DateTime? createdAt;
    UserInfo? userInfo;
    List<String>? scholarshipResponses;
    String? fundsRecipient;
    AdditionalInfo? additionalInfo;
    ShippingAddress? shippingAddress;
    List<String>? likes;
    int? startDate;
    int? quantity;
    String? creatorType;
    int? dueDate;
    String? defaultImageUrl;
    int? commentCount;
    int? donatedQuantity;
    String? name;
    String? id;
    String? region;
    int? status;

    factory DonationRequestInfo.fromJson(Map<dynamic, dynamic> json) => DonationRequestInfo(
        requestType: json["request_type"] as String? ?? '',
        favourites: json["favourites"] != null ? List<String>.from(json["favourites"].map((x) => x as String)) : [],
        noOfImpressions: json["noOfImpressions"] as int? ?? 0,
        noOfViews: json["noOfViews"] as int? ?? 0,
        likeCount: json["likeCount"] as int? ?? 0,
        requestedFor: json["requested_for"] as String? ?? '',
        isPrivate: json["isPrivate"] as bool? ?? false,
        units: json["units"] as String? ?? '',
        title: json["title"] as String? ?? '',
        noOfButtonClicks: json["noOfButtonClicks"] as int? ?? 0,
        orgId: json["orgId"] != null ? OrgId.fromJson(json["orgId"]) : null,
        shareCount: json["shareCount"] as int? ?? 0,
        createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"] as String) : null,
        userInfo: json["user_info"] != null ? UserInfo.fromJson(json["user_info"]) : null,
        scholarshipResponses: json["scholarshipResponses"] != null ? List<String>.from(json["scholarshipResponses"].map((x) => x as String)) : [],
        fundsRecipient: json["fundsRecipient"] as String? ?? '',
        additionalInfo: json["additionalInfo"] != null ? AdditionalInfo.fromJson(json["additionalInfo"]) : null,
        shippingAddress: json["shipping_address"] != null ? ShippingAddress.fromJson(json["shipping_address"]) : null,
        likes: json["likes"] != null ? List<String>.from(json["likes"].map((x) => x as String)) : [],
        startDate: json["start_date"] as int? ?? 0,
        quantity: json["quantity"] as int? ?? 0,
        creatorType: json["creatorType"] as String? ?? '',
        dueDate: json["due_date"] as int? ?? 0,
        defaultImageUrl: json["defaultImageUrl"] as String? ?? '',
        commentCount: json["commentCount"] as int? ?? 0,
        donatedQuantity: json["donated_quantity"] as int? ?? 0,
        name: json["name"] as String? ?? '',
        id: json["_id"] as String? ?? '',
        region: json["region"] as String? ?? '',
        status: json["status"] as int? ?? 0,
    );

    Map<dynamic, dynamic> toJson() => {
        "request_type": requestType,
        "favourites": favourites != null ? List<dynamic>.from(favourites!.map((x) => x)) : [],
        "noOfImpressions": noOfImpressions,
        "noOfViews": noOfViews,
        "likeCount": likeCount,
        "requested_for": requestedFor,
        "isPrivate": isPrivate,
        "units": units,
        "title": title,
        "noOfButtonClicks": noOfButtonClicks,
        "orgId": orgId?.toJson(),
        "shareCount": shareCount,
        "createdAt": createdAt?.toIso8601String(),
        "user_info": userInfo?.toJson(),
        "scholarshipResponses": scholarshipResponses != null ? List<dynamic>.from(scholarshipResponses!.map((x) => x)) : [],
        "fundsRecipient": fundsRecipient,
        "additionalInfo": additionalInfo?.toJson(),
        "shipping_address": shippingAddress?.toJson(),
        "likes": likes != null ? List<dynamic>.from(likes!.map((x) => x)) : [],
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
        this.podcastDate,
        this.duration,
        this.preferredConsultationMode,
        this.hostName,
        this.preferredTopics,
        this.languages,
        this.podcastDate2,
        this.speakerDeadline,
        this.interviewOrPanelDiscussion,
        this.format,
        this.podcastName,
        this.podcastDate1,
        this.podcastWebsite,
        this.speakerResponsibilities,
        this.speakingTopics,
        this.speechduration,
        this.preferredCommercialMode,
        this.socialProblem,
        this.numberOfCommitsPerYear,
        this.termLength,
        this.responsibilities,
        this.qualificationsRequired,
        this.functionalExpertise,
        this.personalTraits,
    });

    int? podcastDate;
    String? duration;
    String? preferredConsultationMode;
    String? hostName;
    String? preferredTopics;
    List<String>? languages;
    int? podcastDate2;
    int? speakerDeadline;
    String? interviewOrPanelDiscussion;
    String? format;
    String? podcastName;
    int? podcastDate1;
    String? podcastWebsite;
    String? speakerResponsibilities;
    String? speakingTopics;
    String? speechduration;
    String? preferredCommercialMode;
    String? socialProblem;
    String? numberOfCommitsPerYear;
    String? termLength;
    String? responsibilities;
    List<String>? qualificationsRequired;
    List<String>? functionalExpertise;
    List<String>? personalTraits;

    factory AdditionalInfo.fromJson(Map<dynamic, dynamic> json) => AdditionalInfo(
        podcastDate: json["podcastDate"] as int?,
        duration: json["duration"] as String?,
        preferredConsultationMode: json["preferredConsultationMode"] as String?,
        hostName: json["hostName"] as String?,
        preferredTopics: json["preferredTopics"] as String?,
        languages: json["languages"] != null ? List<String>.from(json["languages"].map((x) => x as String)) : [],
        podcastDate2: json["podcastDate2"] as int?,
        speakerDeadline: json["speakerDeadline"] as int?,
        interviewOrPanelDiscussion: json["interviewOrPanelDiscussion"] as String?,
        format: json["format"] as String?,
        podcastName: json["podcastName"] as String?,
        podcastDate1: json["podcastDate1"] as int?,
        podcastWebsite: json["podcastWebsite"] as String?,
        speakerResponsibilities: json["speakerResponsibilities"] as String?,
        speakingTopics: json["speakingTopics"] as String?,
        speechduration: json["speechduration"] as String?,
        preferredCommercialMode: json["preferredCommercialMode"] as String?,
        socialProblem: json["socialProblem"] as String?,
        numberOfCommitsPerYear: json["numberOfCommitsPerYear"] as String?,
        termLength: json["termLength"] as String?,
        responsibilities: json["responsibilities"] as String?,
        qualificationsRequired: json["qualificationsRequired"] != null ? List<String>.from(json["qualificationsRequired"].map((x) => x as String)) : [],
        functionalExpertise: json["functionalExpertise"] != null ? List<String>.from(json["functionalExpertise"].map((x) => x as String)) : [],
        personalTraits: json["personalTraits"] != null ? List<String>.from(json["personalTraits"].map((x) => x as String)) : [],

    );

    Map<dynamic, dynamic> toJson() => {
        "podcastDate": podcastDate,
        "duration": duration,
        "preferredConsultationMode": preferredConsultationMode,
        "hostName": hostName,
        "preferredTopics": preferredTopics,
        "languages": languages != null ? List<dynamic>.from(languages!.map((x) => x)) : [],
        "podcastDate2": podcastDate2,
        "speakerDeadline": speakerDeadline,
        "interviewOrPanelDiscussion": interviewOrPanelDiscussion,
        "format": format,
        "podcastName": podcastName,
        "podcastDate1": podcastDate1,
        "podcastWebsite": podcastWebsite,
        "speakerResponsibilities": speakerResponsibilities,
        "speakingTopics": speakingTopics,
        "speechduration": speechduration,
        "preferredCommercialMode": preferredCommercialMode,
        "socialProblem": socialProblem,
        "numberOfCommitsPerYear": numberOfCommitsPerYear,
        "termLength": termLength,
        "responsibilities": responsibilities,
        "qualificationsRequired": qualificationsRequired != null ? List<dynamic>.from(qualificationsRequired!.map((x) => x)) : [],
        "functionalExpertise": functionalExpertise != null ? List<dynamic>.from(functionalExpertise!.map((x) => x)) : [],
        "personalTraits": personalTraits != null ? List<dynamic>.from(personalTraits!.map((x) => x)) : [],
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
        orgName: json["orgName"] as String? ?? '',
        orgEmail: json["orgEmail"] as String? ?? '',
        websiteUrl: json["websiteUrl"] as String? ?? '',
        orgAddress: json["orgAddress"] != null ? OrgAddress.fromJson(json["orgAddress"]) : null,
        id: json["_id"] as String? ?? '',
        defaultImageUrl: json["defaultImageUrl"] as String? ?? '',
        createdAt: json["createdAt"] as String? ?? '',
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
        country: json["country"] as String? ?? '',
        city: json["city"] as String? ?? '',
        state: json["state"] as String? ?? '',
        line2: json["line2"] as String? ?? '',
        line1: json["line1"] as String? ?? '',
        zipCode: json["zip_code"] as String? ?? '',
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
    ShippingAddress({
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

    factory ShippingAddress.fromJson(Map<dynamic, dynamic> json) => ShippingAddress(
        country: json["country"] as String? ?? '',
        city: json["city"] as String? ?? '',
        state: json["state"] as String? ?? '',
        line2: json["line2"] as String? ?? '',
        line1: json["line1"] as String? ?? '',
        zipCode: json["zip_code"] as String? ?? '',
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

class UserInfo {
    UserInfo({
        this.noOfTimesDonated,
        this.allergies,
        this.isBloodDonor,
        this.address,
        this.gender,
        this.imageUrl,
        this.bloodDonationCategory,
        this.anyAllergies,
        this.medication,
        this.countriesVisited,
        this.outOfCountryTravel12Months,
        this.takingMedication,
        this.bloodGroup,
        this.phone,
        this.name,
        this.isTransmissibleDiseaseHistory,
        this.lastDonatedDate,
        this.transmissibleDiseaseHistory,
        this.id,
        this.email,
        this.isDonatedBefore,
        this.isPlateletsDonor,
        this.username,
    });

    int? noOfTimesDonated;
    String? allergies;
    bool? isBloodDonor;
    Address? address;
    String? gender;
    String? imageUrl;
    List<String>? bloodDonationCategory;
    bool? anyAllergies;
    String? medication;
    String? countriesVisited;
    bool? outOfCountryTravel12Months;
    bool? takingMedication;
    String? bloodGroup;
    String? phone;
    Name? name;
    bool? isTransmissibleDiseaseHistory;
    int? lastDonatedDate;
    String? transmissibleDiseaseHistory;
    String? id;
    String? email;
    bool? isDonatedBefore;
    bool? isPlateletsDonor;
    String? username;

    factory UserInfo.fromJson(Map<dynamic, dynamic> json) => UserInfo(
        noOfTimesDonated: json["noOfTimesDonated"] as int? ?? 0,
        allergies: json["allergies"] as String? ?? '',
        isBloodDonor: json["isBloodDonor"] as bool? ?? false,
        address: json["address"] != null ? Address.fromJson(json["address"]) : null,
        gender: json["gender"] as String? ?? '',
        imageUrl: json["image_url"] as String? ?? '',
        bloodDonationCategory: json["bloodDonationCategory"] != null ? List<String>.from(json["bloodDonationCategory"].map((x) => x as String)) : [],
        anyAllergies: json["anyAllergies"] as bool? ?? false,
        medication: json["medication"] as String? ?? '',
        countriesVisited: json["countriesVisited"] as String? ?? '',
        outOfCountryTravel12Months: json["outOfCountryTravel12months"] as bool? ?? false,
        takingMedication: json["takingMedication"] as bool? ?? false,
        bloodGroup: json["bloodGroup"] as String? ?? '',
        phone: json["phone"] as String? ?? '',
        name: json["name"] != null ? Name.fromJson(json["name"]) : null,
        isTransmissibleDiseaseHistory: json["isTransmissibleDiseaseHistory"] as bool? ?? false,
        lastDonatedDate: json["lastDonatedDate"] as int? ?? 0,
        transmissibleDiseaseHistory: json["transmissibleDiseaseHistory"] as String? ?? '',
        id: json["_id"] as String? ?? '',
        email: json["email"] as String? ?? '',
        isDonatedBefore: json["isDonatedBefore"] as bool? ?? false,
        isPlateletsDonor: json["isPlateletsDonor"] as bool? ?? false,
        username: json["username"] as String? ?? '',
    );

    Map<dynamic, dynamic> toJson() => {
        "noOfTimesDonated": noOfTimesDonated,
        "allergies": allergies,
        "isBloodDonor": isBloodDonor,
        "address": address?.toJson(),
        "gender": gender,
        "image_url": imageUrl,
        "bloodDonationCategory": bloodDonationCategory != null ? List<dynamic>.from(bloodDonationCategory!.map((x) => x)) : [],
        "anyAllergies": anyAllergies,
        "medication": medication,
        "countriesVisited": countriesVisited,
        "outOfCountryTravel12months": outOfCountryTravel12Months,
        "takingMedication": takingMedication,
        "bloodGroup": bloodGroup,
        "phone": phone,
        "name": name?.toJson(),
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
        this.country,
        this.city,
        this.district,
        this.state,
        this.village,
        this.line2,
        this.line1,
        this.zipCode,
        this.mandal,
    });

    String? country;
    String? city;
    String? district;
    String? state;
    String? village;
    String? line2;
    String? line1;
    String? zipCode;
    String? mandal;

    factory Address.fromJson(Map<dynamic, dynamic> json) => Address(
        country: json["country"] as String? ?? '',
        city: json["city"] as String? ?? '',
        district: json["district"] as String? ?? '',
        state: json["state"] as String? ?? '',
        village: json["village"] as String? ?? '',
        line2: json["line2"] as String? ?? '',
        line1: json["line1"] as String? ?? '',
        zipCode: json["zip_code"] as String? ?? '',
        mandal: json["mandal"] as String? ?? '',
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
        this.lastName,
        this.middleName,
        this.firstName,
    });

    String? lastName;
    String? middleName;
    String? firstName;

    factory Name.fromJson(Map<dynamic, dynamic> json) => Name(
        lastName: json["last_name"] as String? ?? '',
        middleName: json["middle_name"] as String? ?? '',
        firstName: json["first_name"] as String? ?? '',
    );

    Map<dynamic, dynamic> toJson() => {
        "last_name": lastName,
        "middle_name": middleName,
        "first_name": firstName,
    };
}