// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? status;
  int? statusCode;
  String? message;
  Data? data;

  LoginModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? uniqueId;
  String? email;
  String? phone;
  String? username;
  String? displayName;
  Name? name;
  String? profileImageUrl;
  bool? accountVerified;
  int? accountStatus;
  bool? passwordVerified;
  String? loginProvider;
  bool? emailVerified;
  bool? phoneVerified;
  Address? address;
  List<String>? roles;
  SocialVerification? socialVerification;
  TokenDetail? tokenDetail;
  String? summary;
  String? gender;
  int? dob;
  String? stripeCustomerId;
  int? kindnessScore;
  VolunteerInfo? volunteerInfo;
  String? coverImageUrl;
  int? rating;
  String? facebookProfileUrl;
  String? twitterProfileUrl;
  String? linkedInProfileUrl;
  String? title;
  String? aboutMe;
  bool? isTourCompleted;
  bool? isKindnessEventRegistered;
  String? occupation;
  String? organization;
  int? yearsOfExperience;
  bool? isHackathonRegistered;
  Address? billingAddress;
  int? totalEmailsPerMonth;
  bool? isMentor;
  List<String>? languages;
  bool? isProfileCompleted;
  String? institutionName;
  String? studentId;
  String? institutionUrl;
  String? institutionalRole;
  String? educationalQualification;
  String? educationalQualificationOthers;
  MentorInfo? mentorInfo;
  bool? isAssignMentor;
  String? defaultChannel;
  String? sourceOfSignup;
  List<String>? personalTraits;
  List<String>? functionalExpertise;
  bool? isTalLeader;
  List<String>? areasOfInterest;
  bool? isCertificationDownloaded;
  MedicalRegistration? medicalRegistration;
  EstablishmentInformation? establishmentInformation;
  List<String>? specialities;
  List<String>? categoriesOfInterest;
  List<dynamic>? typeOfHelpAndInvolvement;
  List<dynamic>? interestedTypeOfOrgs;
  List<dynamic>? interestedRegions;
  int? profileVerificationStatus;
  String? referralCode;
  List<EducationTimeline>? educationTimelines;
  List<Experience>? experience;
  List<Conference>? conferences;
  List<Certificate>? certificates;
  List<Membership>? memberships;
  List<Achievement>? achievements;
  String? aadhaar;
  String? pan;
  bool? oneHourPerWeek;
  bool? managementPosition;
  String? currentRole;
  String? currentCompanyName;
  List<dynamic>? userComments;
  List<String>? userLikes;
  String? professionalExperience;
  Location? location;
  bool? acceptedTermsAndConditions;
  dynamic ipAddress;
  List<dynamic>? reviewedBy;
  dynamic notes;
  String? bloodGroup;
  bool? isDonatedBefore;
  int? noOfTimesDonated;
  int? lastDonatedDate;
  bool? isTransmissibleDiseaseHistory;
  String? transmissibleDiseaseHistory;
  bool? bloodRequirementAlerts;
  String? sourceOfDevice;
  bool? isPaidBootcamp;
  bool? isKindnessEventRegistered2023;
  String? userRegistrationCategory;
  List<dynamic>? educationInUkOrUs;
  dynamic experienceInUkOrUs;
  String? defaultHomePage;
  String? registeredForEvent;
  bool? isBasicProfileCompleted;
  bool? isEducationProfileCompleted;
  bool? isExperienceProfileCompleted;
  bool? isConferencesProfileCompleted;
  bool? isCertificateProfileCompleted;
  bool? isMembershipProfileCompleted;
  bool? isSpecialitiesProfileCompleted;
  bool? isAchievementsProfileCompleted;
  bool? isProfileCompletedForTalHospitals;
  String? salutation;
  bool? isBloodDonor;
  bool? isPlateletsDonor;
  List<String>? bloodDonationCategory;
  bool? takingMedication;
  bool? anyAllergies;
  bool? outOfCountryTravel12Months;
  String? countriesVisited;
  bool? isBulkUpload;
  bool? isTourCompletedForTalHospitals;
  Address? volunteerAddress;
  String? allergies;
  String? medication;
  dynamic hideProfileCategory;
  dynamic hideProfileReason;
  dynamic hideProfileEndDate;
  List<String>? languagePreferences;
  int? userNameUpdatedAt;
  List<String>? eventRegistrations;
  bool? isTourCompletedForTalLeaders;
  int? noOfCampaignsCreated;
  int? noOfLivesImpacted;
  List<String>? talLeaderPreferences;
  List<ProfileStatus>? profileStatus;

  Data({
    this.uniqueId,
    this.email,
    this.phone,
    this.username,
    this.displayName,
    this.name,
    this.profileImageUrl,
    this.accountVerified,
    this.accountStatus,
    this.passwordVerified,
    this.loginProvider,
    this.emailVerified,
    this.phoneVerified,
    this.address,
    this.roles,
    this.socialVerification,
    this.tokenDetail,
    this.summary,
    this.gender,
    this.dob,
    this.stripeCustomerId,
    this.kindnessScore,
    this.volunteerInfo,
    this.coverImageUrl,
    this.rating,
    this.facebookProfileUrl,
    this.twitterProfileUrl,
    this.linkedInProfileUrl,
    this.title,
    this.aboutMe,
    this.isTourCompleted,
    this.isKindnessEventRegistered,
    this.occupation,
    this.organization,
    this.yearsOfExperience,
    this.isHackathonRegistered,
    this.billingAddress,
    this.totalEmailsPerMonth,
    this.isMentor,
    this.languages,
    this.isProfileCompleted,
    this.institutionName,
    this.studentId,
    this.institutionUrl,
    this.institutionalRole,
    this.educationalQualification,
    this.educationalQualificationOthers,
    this.mentorInfo,
    this.isAssignMentor,
    this.defaultChannel,
    this.sourceOfSignup,
    this.personalTraits,
    this.functionalExpertise,
    this.isTalLeader,
    this.areasOfInterest,
    this.isCertificationDownloaded,
    this.medicalRegistration,
    this.establishmentInformation,
    this.specialities,
    this.categoriesOfInterest,
    this.typeOfHelpAndInvolvement,
    this.interestedTypeOfOrgs,
    this.interestedRegions,
    this.profileVerificationStatus,
    this.referralCode,
    this.educationTimelines,
    this.experience,
    this.conferences,
    this.certificates,
    this.memberships,
    this.achievements,
    this.aadhaar,
    this.pan,
    this.oneHourPerWeek,
    this.managementPosition,
    this.currentRole,
    this.currentCompanyName,
    this.userComments,
    this.userLikes,
    this.professionalExperience,
    this.location,
    this.acceptedTermsAndConditions,
    this.ipAddress,
    this.reviewedBy,
    this.notes,
    this.bloodGroup,
    this.isDonatedBefore,
    this.noOfTimesDonated,
    this.lastDonatedDate,
    this.isTransmissibleDiseaseHistory,
    this.transmissibleDiseaseHistory,
    this.bloodRequirementAlerts,
    this.sourceOfDevice,
    this.isPaidBootcamp,
    this.isKindnessEventRegistered2023,
    this.userRegistrationCategory,
    this.educationInUkOrUs,
    this.experienceInUkOrUs,
    this.defaultHomePage,
    this.registeredForEvent,
    this.isBasicProfileCompleted,
    this.isEducationProfileCompleted,
    this.isExperienceProfileCompleted,
    this.isConferencesProfileCompleted,
    this.isCertificateProfileCompleted,
    this.isMembershipProfileCompleted,
    this.isSpecialitiesProfileCompleted,
    this.isAchievementsProfileCompleted,
    this.isProfileCompletedForTalHospitals,
    this.salutation,
    this.isBloodDonor,
    this.isPlateletsDonor,
    this.bloodDonationCategory,
    this.takingMedication,
    this.anyAllergies,
    this.outOfCountryTravel12Months,
    this.countriesVisited,
    this.isBulkUpload,
    this.isTourCompletedForTalHospitals,
    this.volunteerAddress,
    this.allergies,
    this.medication,
    this.hideProfileCategory,
    this.hideProfileReason,
    this.hideProfileEndDate,
    this.languagePreferences,
    this.userNameUpdatedAt,
    this.eventRegistrations,
    this.isTourCompletedForTalLeaders,
    this.noOfCampaignsCreated,
    this.noOfLivesImpacted,
    this.talLeaderPreferences,
    this.profileStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uniqueId: json["unique_id"],
    email: json["email"],
    phone: json["phone"],
    username: json["username"],
    displayName: json["display_name"],
    name: json["name"] == null ? null : Name.fromJson(json["name"]),
    profileImageUrl: json["profile_image_url"],
    accountVerified: json["account_verified"],
    accountStatus: json["account_status"],
    passwordVerified: json["password_verified"],
    loginProvider: json["login_provider"],
    emailVerified: json["email_verified"],
    phoneVerified: json["phone_verified"],
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    socialVerification: json["social_verification"] == null ? null : SocialVerification.fromJson(json["social_verification"]),
    tokenDetail: json["token_detail"] == null ? null : TokenDetail.fromJson(json["token_detail"]),
    summary: json["summary"],
    gender: json["gender"],
    dob: json["dob"],
    stripeCustomerId: json["stripeCustomerId"],
    kindnessScore: json["kindness_score"],
    volunteerInfo: json["volunteerInfo"] == null ? null : VolunteerInfo.fromJson(json["volunteerInfo"]),
    coverImageUrl: json["coverImageUrl"],
    rating: json["rating"],
    facebookProfileUrl: json["facebookProfileUrl"],
    twitterProfileUrl: json["twitterProfileUrl"],
    linkedInProfileUrl: json["linkedInProfileUrl"],
    title: json["title"],
    aboutMe: json["aboutMe"],
    isTourCompleted: json["isTourCompleted"],
    isKindnessEventRegistered: json["isKindnessEventRegistered"],
    occupation: json["occupation"],
    organization: json["organization"],
    yearsOfExperience: json["yearsOfExperience"],
    isHackathonRegistered: json["isHackathonRegistered"],
    billingAddress: json["billingAddress"] == null ? null : Address.fromJson(json["billingAddress"]),
    totalEmailsPerMonth: json["totalEmailsPerMonth"],
    isMentor: json["isMentor"],
    languages: json["languages"] == null ? [] : List<String>.from(json["languages"]!.map((x) => x)),
    isProfileCompleted: json["isProfileCompleted"],
    institutionName: json["institutionName"],
    studentId: json["studentId"],
    institutionUrl: json["institutionUrl"],
    institutionalRole: json["institutionalRole"],
    educationalQualification: json["educationalQualification"],
    educationalQualificationOthers: json["educationalQualificationOthers"],
    mentorInfo: json["mentorInfo"] == null ? null : MentorInfo.fromJson(json["mentorInfo"]),
    isAssignMentor: json["isAssignMentor"],
    defaultChannel: json["defaultChannel"],
    sourceOfSignup: json["sourceOfSignup"],
    personalTraits: json["personalTraits"] == null ? [] : List<String>.from(json["personalTraits"]!.map((x) => x)),
    functionalExpertise: json["functionalExpertise"] == null ? [] : List<String>.from(json["functionalExpertise"]!.map((x) => x)),
    isTalLeader: json["isTALLeader"],
    areasOfInterest: json["areasOfInterest"] == null ? [] : List<String>.from(json["areasOfInterest"]!.map((x) => x)),
    isCertificationDownloaded: json["isCertificationDownloaded"],
    medicalRegistration: json["medicalRegistration"] == null ? null : MedicalRegistration.fromJson(json["medicalRegistration"]),
    establishmentInformation: json["establishmentInformation"] == null ? null : EstablishmentInformation.fromJson(json["establishmentInformation"]),
    specialities: json["specialities"] == null ? [] : List<String>.from(json["specialities"]!.map((x) => x)),
    categoriesOfInterest: json["categoriesOfInterest"] == null ? [] : List<String>.from(json["categoriesOfInterest"]!.map((x) => x)),
    typeOfHelpAndInvolvement: json["typeOfHelpAndInvolvement"] == null ? [] : List<dynamic>.from(json["typeOfHelpAndInvolvement"]!.map((x) => x)),
    interestedTypeOfOrgs: json["interestedTypeOfOrgs"] == null ? [] : List<dynamic>.from(json["interestedTypeOfOrgs"]!.map((x) => x)),
    interestedRegions: json["interestedRegions"] == null ? [] : List<dynamic>.from(json["interestedRegions"]!.map((x) => x)),
    profileVerificationStatus: json["profileVerificationStatus"],
    referralCode: json["referral_code"],
    educationTimelines: json["educationTimelines"] == null ? [] : List<EducationTimeline>.from(json["educationTimelines"]!.map((x) => EducationTimeline.fromJson(x))),
    experience: json["experience"] == null ? [] : List<Experience>.from(json["experience"]!.map((x) => Experience.fromJson(x))),
    conferences: json["conferences"] == null ? [] : List<Conference>.from(json["conferences"]!.map((x) => Conference.fromJson(x))),
    certificates: json["certificates"] == null ? [] : List<Certificate>.from(json["certificates"]!.map((x) => Certificate.fromJson(x))),
    memberships: json["memberships"] == null ? [] : List<Membership>.from(json["memberships"]!.map((x) => Membership.fromJson(x))),
    achievements: json["achievements"] == null ? [] : List<Achievement>.from(json["achievements"]!.map((x) => Achievement.fromJson(x))),
    aadhaar: json["aadhaar"],
    pan: json["pan"],
    oneHourPerWeek: json["oneHourPerWeek"],
    managementPosition: json["managementPosition"],
    currentRole: json["currentRole"],
    currentCompanyName: json["currentCompanyName"],
    userComments: json["userComments"] == null ? [] : List<dynamic>.from(json["userComments"]!.map((x) => x)),
    userLikes: json["userLikes"] == null ? [] : List<String>.from(json["userLikes"]!.map((x) => x)),
    professionalExperience: json["professionalExperience"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    acceptedTermsAndConditions: json["acceptedTermsAndConditions"],
    ipAddress: json["ipAddress"],
    reviewedBy: json["reviewedBy"] == null ? [] : List<dynamic>.from(json["reviewedBy"]!.map((x) => x)),
    notes: json["notes"],
    bloodGroup: json["bloodGroup"],
    isDonatedBefore: json["isDonatedBefore"],
    noOfTimesDonated: json["noOfTimesDonated"],
    lastDonatedDate: json["lastDonatedDate"],
    isTransmissibleDiseaseHistory: json["isTransmissibleDiseaseHistory"],
    transmissibleDiseaseHistory: json["transmissibleDiseaseHistory"],
    bloodRequirementAlerts: json["bloodRequirementAlerts"],
    sourceOfDevice: json["sourceOfDevice"],
    isPaidBootcamp: json["isPaidBootcamp"],
    isKindnessEventRegistered2023: json["isKindnessEventRegistered2023"],
    userRegistrationCategory: json["userRegistrationCategory"],
    educationInUkOrUs: json["educationInUKOrUS"] == null ? [] : List<dynamic>.from(json["educationInUKOrUS"]!.map((x) => x)),
    experienceInUkOrUs: json["experienceInUKOrUS"],
    defaultHomePage: json["defaultHomePage"],
    registeredForEvent: json["registeredForEvent"],
    isBasicProfileCompleted: json["isBasicProfileCompleted"],
    isEducationProfileCompleted: json["isEducationProfileCompleted"],
    isExperienceProfileCompleted: json["isExperienceProfileCompleted"],
    isConferencesProfileCompleted: json["isConferencesProfileCompleted"],
    isCertificateProfileCompleted: json["isCertificateProfileCompleted"],
    isMembershipProfileCompleted: json["isMembershipProfileCompleted"],
    isSpecialitiesProfileCompleted: json["isSpecialitiesProfileCompleted"],
    isAchievementsProfileCompleted: json["isAchievementsProfileCompleted"],
    isProfileCompletedForTalHospitals: json["isProfileCompletedForTalHospitals"],
    salutation: json["salutation"],
    isBloodDonor: json["isBloodDonor"],
    isPlateletsDonor: json["isPlateletsDonor"],
    bloodDonationCategory: json["bloodDonationCategory"] == null ? [] : List<String>.from(json["bloodDonationCategory"]!.map((x) => x)),
    takingMedication: json["takingMedication"],
    anyAllergies: json["anyAllergies"],
    outOfCountryTravel12Months: json["outOfCountryTravel12months"],
    countriesVisited: json["countriesVisited"],
    isBulkUpload: json["isBulkUpload"],
    isTourCompletedForTalHospitals: json["isTourCompletedForTalHospitals"],
    volunteerAddress: json["volunteerAddress"] == null ? null : Address.fromJson(json["volunteerAddress"]),
    allergies: json["allergies"],
    medication: json["medication"],
    hideProfileCategory: json["hideProfileCategory"],
    hideProfileReason: json["hideProfileReason"],
    hideProfileEndDate: json["hideProfileEndDate"],
    languagePreferences: json["languagePreferences"] == null ? [] : List<String>.from(json["languagePreferences"]!.map((x) => x)),
    userNameUpdatedAt: json["userNameUpdatedAt"],
    eventRegistrations: json["eventRegistrations"] == null ? [] : List<String>.from(json["eventRegistrations"]!.map((x) => x)),
    isTourCompletedForTalLeaders: json["isTourCompletedForTalLeaders"],
    noOfCampaignsCreated: json["noOfCampaignsCreated"],
    noOfLivesImpacted: json["noOfLivesImpacted"],
    talLeaderPreferences: json["talLeaderPreferences"] == null ? [] : List<String>.from(json["talLeaderPreferences"]!.map((x) => x)),
    profileStatus: json["profileStatus"] == null ? [] : List<ProfileStatus>.from(json["profileStatus"]!.map((x) => ProfileStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "unique_id": uniqueId,
    "email": email,
    "phone": phone,
    "username": username,
    "display_name": displayName,
    "name": name?.toJson(),
    "profile_image_url": profileImageUrl,
    "account_verified": accountVerified,
    "account_status": accountStatus,
    "password_verified": passwordVerified,
    "login_provider": loginProvider,
    "email_verified": emailVerified,
    "phone_verified": phoneVerified,
    "address": address?.toJson(),
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "social_verification": socialVerification?.toJson(),
    "token_detail": tokenDetail?.toJson(),
    "summary": summary,
    "gender": gender,
    "dob": dob,
    "stripeCustomerId": stripeCustomerId,
    "kindness_score": kindnessScore,
    "volunteerInfo": volunteerInfo?.toJson(),
    "coverImageUrl": coverImageUrl,
    "rating": rating,
    "facebookProfileUrl": facebookProfileUrl,
    "twitterProfileUrl": twitterProfileUrl,
    "linkedInProfileUrl": linkedInProfileUrl,
    "title": title,
    "aboutMe": aboutMe,
    "isTourCompleted": isTourCompleted,
    "isKindnessEventRegistered": isKindnessEventRegistered,
    "occupation": occupation,
    "organization": organization,
    "yearsOfExperience": yearsOfExperience,
    "isHackathonRegistered": isHackathonRegistered,
    "billingAddress": billingAddress?.toJson(),
    "totalEmailsPerMonth": totalEmailsPerMonth,
    "isMentor": isMentor,
    "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x)),
    "isProfileCompleted": isProfileCompleted,
    "institutionName": institutionName,
    "studentId": studentId,
    "institutionUrl": institutionUrl,
    "institutionalRole": institutionalRole,
    "educationalQualification": educationalQualification,
    "educationalQualificationOthers": educationalQualificationOthers,
    "mentorInfo": mentorInfo?.toJson(),
    "isAssignMentor": isAssignMentor,
    "defaultChannel": defaultChannel,
    "sourceOfSignup": sourceOfSignup,
    "personalTraits": personalTraits == null ? [] : List<dynamic>.from(personalTraits!.map((x) => x)),
    "functionalExpertise": functionalExpertise == null ? [] : List<dynamic>.from(functionalExpertise!.map((x) => x)),
    "isTALLeader": isTalLeader,
    "areasOfInterest": areasOfInterest == null ? [] : List<dynamic>.from(areasOfInterest!.map((x) => x)),
    "isCertificationDownloaded": isCertificationDownloaded,
    "medicalRegistration": medicalRegistration?.toJson(),
    "establishmentInformation": establishmentInformation?.toJson(),
    "specialities": specialities == null ? [] : List<dynamic>.from(specialities!.map((x) => x)),
    "categoriesOfInterest": categoriesOfInterest == null ? [] : List<dynamic>.from(categoriesOfInterest!.map((x) => x)),
    "typeOfHelpAndInvolvement": typeOfHelpAndInvolvement == null ? [] : List<dynamic>.from(typeOfHelpAndInvolvement!.map((x) => x)),
    "interestedTypeOfOrgs": interestedTypeOfOrgs == null ? [] : List<dynamic>.from(interestedTypeOfOrgs!.map((x) => x)),
    "interestedRegions": interestedRegions == null ? [] : List<dynamic>.from(interestedRegions!.map((x) => x)),
    "profileVerificationStatus": profileVerificationStatus,
    "referral_code": referralCode,
    "educationTimelines": educationTimelines == null ? [] : List<dynamic>.from(educationTimelines!.map((x) => x.toJson())),
    "experience": experience == null ? [] : List<dynamic>.from(experience!.map((x) => x.toJson())),
    "conferences": conferences == null ? [] : List<dynamic>.from(conferences!.map((x) => x.toJson())),
    "certificates": certificates == null ? [] : List<dynamic>.from(certificates!.map((x) => x.toJson())),
    "memberships": memberships == null ? [] : List<dynamic>.from(memberships!.map((x) => x.toJson())),
    "achievements": achievements == null ? [] : List<dynamic>.from(achievements!.map((x) => x.toJson())),
    "aadhaar": aadhaar,
    "pan": pan,
    "oneHourPerWeek": oneHourPerWeek,
    "managementPosition": managementPosition,
    "currentRole": currentRole,
    "currentCompanyName": currentCompanyName,
    "userComments": userComments == null ? [] : List<dynamic>.from(userComments!.map((x) => x)),
    "userLikes": userLikes == null ? [] : List<dynamic>.from(userLikes!.map((x) => x)),
    "professionalExperience": professionalExperience,
    "location": location?.toJson(),
    "acceptedTermsAndConditions": acceptedTermsAndConditions,
    "ipAddress": ipAddress,
    "reviewedBy": reviewedBy == null ? [] : List<dynamic>.from(reviewedBy!.map((x) => x)),
    "notes": notes,
    "bloodGroup": bloodGroup,
    "isDonatedBefore": isDonatedBefore,
    "noOfTimesDonated": noOfTimesDonated,
    "lastDonatedDate": lastDonatedDate,
    "isTransmissibleDiseaseHistory": isTransmissibleDiseaseHistory,
    "transmissibleDiseaseHistory": transmissibleDiseaseHistory,
    "bloodRequirementAlerts": bloodRequirementAlerts,
    "sourceOfDevice": sourceOfDevice,
    "isPaidBootcamp": isPaidBootcamp,
    "isKindnessEventRegistered2023": isKindnessEventRegistered2023,
    "userRegistrationCategory": userRegistrationCategory,
    "educationInUKOrUS": educationInUkOrUs == null ? [] : List<dynamic>.from(educationInUkOrUs!.map((x) => x)),
    "experienceInUKOrUS": experienceInUkOrUs,
    "defaultHomePage": defaultHomePage,
    "registeredForEvent": registeredForEvent,
    "isBasicProfileCompleted": isBasicProfileCompleted,
    "isEducationProfileCompleted": isEducationProfileCompleted,
    "isExperienceProfileCompleted": isExperienceProfileCompleted,
    "isConferencesProfileCompleted": isConferencesProfileCompleted,
    "isCertificateProfileCompleted": isCertificateProfileCompleted,
    "isMembershipProfileCompleted": isMembershipProfileCompleted,
    "isSpecialitiesProfileCompleted": isSpecialitiesProfileCompleted,
    "isAchievementsProfileCompleted": isAchievementsProfileCompleted,
    "isProfileCompletedForTalHospitals": isProfileCompletedForTalHospitals,
    "salutation": salutation,
    "isBloodDonor": isBloodDonor,
    "isPlateletsDonor": isPlateletsDonor,
    "bloodDonationCategory": bloodDonationCategory == null ? [] : List<dynamic>.from(bloodDonationCategory!.map((x) => x)),
    "takingMedication": takingMedication,
    "anyAllergies": anyAllergies,
    "outOfCountryTravel12months": outOfCountryTravel12Months,
    "countriesVisited": countriesVisited,
    "isBulkUpload": isBulkUpload,
    "isTourCompletedForTalHospitals": isTourCompletedForTalHospitals,
    "volunteerAddress": volunteerAddress?.toJson(),
    "allergies": allergies,
    "medication": medication,
    "hideProfileCategory": hideProfileCategory,
    "hideProfileReason": hideProfileReason,
    "hideProfileEndDate": hideProfileEndDate,
    "languagePreferences": languagePreferences == null ? [] : List<dynamic>.from(languagePreferences!.map((x) => x)),
    "userNameUpdatedAt": userNameUpdatedAt,
    "eventRegistrations": eventRegistrations == null ? [] : List<dynamic>.from(eventRegistrations!.map((x) => x)),
    "isTourCompletedForTalLeaders": isTourCompletedForTalLeaders,
    "noOfCampaignsCreated": noOfCampaignsCreated,
    "noOfLivesImpacted": noOfLivesImpacted,
    "talLeaderPreferences": talLeaderPreferences == null ? [] : List<dynamic>.from(talLeaderPreferences!.map((x) => x)),
    "profileStatus": profileStatus == null ? [] : List<dynamic>.from(profileStatus!.map((x) => x.toJson())),
  };
}

class Achievement {
  String? id;
  String? awardTitle;
  String? awardIssuedBy;
  String? awardDescription;
  DateTime? updatedAt;
  DateTime? createdAt;

  Achievement({
    this.id,
    this.awardTitle,
    this.awardIssuedBy,
    this.awardDescription,
    this.updatedAt,
    this.createdAt,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) => Achievement(
    id: json["_id"],
    awardTitle: json["awardTitle"],
    awardIssuedBy: json["awardIssuedBy"],
    awardDescription: json["awardDescription"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "awardTitle": awardTitle,
    "awardIssuedBy": awardIssuedBy,
    "awardDescription": awardDescription,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };

}

class Address {
  String? line1;
  String? line2;
  dynamic locality;
  String? city;
  String? state;
  String? district;
  String? mandal;
  String? village;
  String? country;
  String? zipCode;

  Address({
    this.line1,
    this.line2,
    this.locality,
    this.city,
    this.state,
    this.district,
    this.mandal,
    this.village,
    this.country,
    this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    line1: json["line1"],
    line2: json["line2"],
    locality: json["locality"],
    city: json["city"],
    state: json["state"],
    district: json["district"],
    mandal: json["mandal"],
    village: json["village"],
    country: json["country"],
    zipCode: json["zip_code"],
  );

  Map<String, dynamic> toJson() => {
    "line1": line1,
    "line2": line2,
    "locality": locality,
    "city": city,
    "state": state,
    "district": district,
    "mandal": mandal,
    "village": village,
    "country": country,
    "zip_code": zipCode,
  };
}

class Certificate {
  String? id;
  String? title;
  String? issuedBy;
  String? description;
  DateTime? updatedAt;
  DateTime? createdAt;

  Certificate({
    this.id,
    this.title,
    this.issuedBy,
    this.description,
    this.updatedAt,
    this.createdAt,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
    id: json["_id"],
    title: json["title"],
    issuedBy: json["issuedBy"],
    description: json["description"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "issuedBy": issuedBy,
    "description": description,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };
}

class Conference {
  String? id;
  String? name;
  int? date;
  DateTime? updatedAt;
  DateTime? createdAt;

  Conference({
    this.id,
    this.name,
    this.date,
    this.updatedAt,
    this.createdAt,
  });

  factory Conference.fromJson(Map<String, dynamic> json) => Conference(
    id: json["_id"],
    name: json["name"],
    date: json["date"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "date": date,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };
}

class EducationTimeline {
  String? id;
  String? education;
  String? degree;
  String? fieldOfStudy;
  int? educationalStartDate;
  int? educationalEndDate;
  DateTime? updatedAt;
  DateTime? createdAt;

  EducationTimeline({
    this.id,
    this.education,
    this.degree,
    this.fieldOfStudy,
    this.educationalStartDate,
    this.educationalEndDate,
    this.updatedAt,
    this.createdAt,
  });

  factory EducationTimeline.fromJson(Map<String, dynamic> json) => EducationTimeline(
    id: json["_id"],
    education: json["education"],
    degree: json["degree"],
    fieldOfStudy: json["fieldOfStudy"],
    educationalStartDate: json["educationalStartDate"],
    educationalEndDate: json["educationalEndDate"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "education": education,
    "degree": degree,
    "fieldOfStudy": fieldOfStudy,
    "educationalStartDate": educationalStartDate,
    "educationalEndDate": educationalEndDate,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };
}

class EstablishmentInformation {
  String? line1;
  String? line2;
  String? city;
  String? state;
  String? country;
  String? zipCode;

  EstablishmentInformation({
    this.line1,
    this.line2,
    this.city,
    this.state,
    this.country,
    this.zipCode,
  });

  factory EstablishmentInformation.fromJson(Map<String, dynamic> json) => EstablishmentInformation(
    line1: json["line1"],
    line2: json["line2"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    zipCode: json["zip_code"],
  );

  Map<String, dynamic> toJson() => {
    "line1": line1,
    "line2": line2,
    "city": city,
    "state": state,
    "country": country,
    "zip_code": zipCode,
  };
}

class Experience {
  String? id;
  String? role;
  String? company;
  int? experienceStartDate;
  int? experienceEndDate;
  String? logoUrl;
  int? status;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic description;
  dynamic designation;

  Experience({
    this.id,
    this.role,
    this.company,
    this.experienceStartDate,
    this.experienceEndDate,
    this.logoUrl,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.description,
    this.designation,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
    id: json["_id"],
    role: json["role"],
    company: json["company"],
    experienceStartDate: json["experienceStartDate"],
    experienceEndDate: json["experienceEndDate"],
    logoUrl: json["logoUrl"],
    status: json["status"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    description: json["description"],
    designation: json["designation"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "role": role,
    "company": company,
    "experienceStartDate": experienceStartDate,
    "experienceEndDate": experienceEndDate,
    "logoUrl": logoUrl,
    "status": status,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "description": description,
    "designation": designation,
  };
}

class Location {
  String? type;
  List<dynamic>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<dynamic>.from(json["coordinates"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}

class MedicalRegistration {
  String? registrationNumber;
  String? registrationCouncil;
  int? registrationYear;

  MedicalRegistration({
    this.registrationNumber,
    this.registrationCouncil,
    this.registrationYear,
  });

  factory MedicalRegistration.fromJson(Map<String, dynamic> json) => MedicalRegistration(
    registrationNumber: json["registrationNumber"],
    registrationCouncil: json["registrationCouncil"],
    registrationYear: json["registrationYear"],
  );

  Map<String, dynamic> toJson() => {
    "registrationNumber": registrationNumber,
    "registrationCouncil": registrationCouncil,
    "registrationYear": registrationYear,
  };
}

class Membership {
  String? id;
  String? membership;
  int? startDate;
  int? endDate;
  DateTime? updatedAt;
  DateTime? createdAt;

  Membership({
    this.id,
    this.membership,
    this.startDate,
    this.endDate,
    this.updatedAt,
    this.createdAt,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
    id: json["_id"],
    membership: json["membership"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "membership": membership,
    "startDate": startDate,
    "endDate": endDate,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };
}

class MentorInfo {
  String? firstName;
  String? lastName;
  String? phone;
  String? email;
  String? organization;
  String? organizationWebsite;
  String? educationalQualification;

  MentorInfo({
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.organization,
    this.organizationWebsite,
    this.educationalQualification,
  });

  factory MentorInfo.fromJson(Map<String, dynamic> json) => MentorInfo(
    firstName: json["firstName"],
    lastName: json["lastName"],
    phone: json["phone"],
    email: json["email"],
    organization: json["organization"],
    organizationWebsite: json["organizationWebsite"],
    educationalQualification: json["educationalQualification"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "email": email,
    "organization": organization,
    "organizationWebsite": organizationWebsite,
    "educationalQualification": educationalQualification,
  };
}

class Name {
  String? middleName;
  String? firstName;
  String? lastName;

  Name({
    this.middleName,
    this.firstName,
    this.lastName,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    middleName: json["middle_name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "middle_name": middleName,
    "first_name": firstName,
    "last_name": lastName,
  };
}

class ProfileStatus {
  String? id;
  String? type;
  String? reason;
  int? endDate;
  bool? hideStatus;
  DateTime? updatedAt;
  DateTime? createdAt;

  ProfileStatus({
    this.id,
    this.type,
    this.reason,
    this.endDate,
    this.hideStatus,
    this.updatedAt,
    this.createdAt,
  });

  factory ProfileStatus.fromJson(Map<String, dynamic> json) => ProfileStatus(
    id: json["_id"],
    type: json["type"],
    reason: json["reason"],
    endDate: json["endDate"],
    hideStatus: json["hideStatus"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": type,
    "reason": reason,
    "endDate": endDate,
    "hideStatus": hideStatus,
    "updatedAt": updatedAt?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
  };
}

class SocialVerification {
  bool? googleVerified;
  bool? facebookVerified;
  bool? linkedinVerified;
  bool? twitterVerified;
  bool? appleVerified;

  SocialVerification({
    this.googleVerified,
    this.facebookVerified,
    this.linkedinVerified,
    this.twitterVerified,
    this.appleVerified,
  });

  factory SocialVerification.fromJson(Map<String, dynamic> json) => SocialVerification(
    googleVerified: json["google_verified"],
    facebookVerified: json["facebook_verified"],
    linkedinVerified: json["linkedin_verified"],
    twitterVerified: json["twitter_verified"],
    appleVerified: json["apple_verified"],
  );

  Map<String, dynamic> toJson() => {
    "google_verified": googleVerified,
    "facebook_verified": facebookVerified,
    "linkedin_verified": linkedinVerified,
    "twitter_verified": twitterVerified,
    "apple_verified": appleVerified,
  };
}

class TokenDetail {
  String? token;
  String? type;

  TokenDetail({
    this.token,
    this.type,
  });

  factory TokenDetail.fromJson(Map<String, dynamic> json) => TokenDetail(
    token: json["token"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "type": type,
  };
}

class VolunteerInfo {
  dynamic isInterested;

  VolunteerInfo({
    this.isInterested,
  });

  factory VolunteerInfo.fromJson(Map<String, dynamic> json) => VolunteerInfo(
    isInterested: json["isInterested"],
  );

  Map<String, dynamic> toJson() => {
    "isInterested": isInterested,
  };
}
