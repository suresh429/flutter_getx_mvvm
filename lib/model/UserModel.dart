// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'LoginModel.dart';
import 'achievement.dart';
import 'experience_model.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String status;
  int statusCode;
  String message;
  Data data;

  UserModel({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String uniqueId;
  String email;
  String phone;
  String username;
  String displayName;
  Name name;
  String profileImageUrl;
  bool accountVerified;
  int accountStatus;
  bool passwordVerified;
  String loginProvider;
  bool emailVerified;
  bool phoneVerified;
  Address address;
  List<String> roles;
  SocialVerification socialVerification;
  TokenDetail tokenDetail;
  String summary;
  String gender;
  int dob;
  String stripeCustomerId;
  int kindnessScore;
  VolunteerInfo volunteerInfo;
  String coverImageUrl;
  int rating;
  String facebookProfileUrl;
  String twitterProfileUrl;
  String linkedInProfileUrl;
  String title;
  String aboutMe;
  bool isTourCompleted;
  bool isKindnessEventRegistered;
  String occupation;
  String organization;
  int yearsOfExperience;
  bool isHackathonRegistered;
  Address billingAddress;
  int totalEmailsPerMonth;
  bool isMentor;
  List<String> languages;
  bool isProfileCompleted;
  String institutionName;
  String studentId;
  String institutionUrl;
  String institutionalRole;
  String educationalQualification;
  String educationalQualificationOthers;
  MentorInfo mentorInfo;
  bool isAssignMentor;
  String defaultChannel;
  String sourceOfSignup;
  List<String> personalTraits;
  List<String> functionalExpertise;
  bool isTalLeader;
  List<String> areasOfInterest;
  bool isCertificationDownloaded;
  MedicalRegistration medicalRegistration;
  EstablishmentInformation establishmentInformation;
  List<String> specialities;
  List<dynamic> categoriesOfInterest;
  List<dynamic> typeOfHelpAndInvolvement;
  List<dynamic> interestedTypeOfOrgs;
  List<dynamic> interestedRegions;
  int profileVerificationStatus;
  String referralCode;
  List<EducationTimeline> educationTimelines;
  List<Experience> experience;
  List<Conference> conferences;
  List<Certificate> certificates;
  List<Membership> memberships;
  List<Achievement> achievements;
  String aadhaar;
  String pan;
  bool oneHourPerWeek;
  bool managementPosition;
  String currentRole;
  String currentCompanyName;
  List<dynamic> userComments;
  List<UserLike> userLikes;
  String professionalExperience;
  Location location;
  bool acceptedTermsAndConditions;
  dynamic ipAddress;
  List<dynamic> reviewedBy;
  dynamic notes;
  String bloodGroup;
  bool isDonatedBefore;
  int noOfTimesDonated;
  int lastDonatedDate;
  bool isTransmissibleDiseaseHistory;
  String transmissibleDiseaseHistory;
  bool bloodRequirementAlerts;
  bool researchParticipationInterest;
  String sourceOfDevice;
  bool isPaidBootcamp;
  bool isKindnessEventRegistered2023;
  String userRegistrationCategory;
  List<dynamic> educationInUkOrUs;
  dynamic experienceInUkOrUs;
  String defaultHomePage;
  String registeredForEvent;
  bool isBasicProfileCompleted;
  bool isEducationProfileCompleted;
  bool isExperienceProfileCompleted;
  bool isConferencesProfileCompleted;
  bool isCertificateProfileCompleted;
  bool isMembershipProfileCompleted;
  bool isSpecialitiesProfileCompleted;
  bool isAchievementsProfileCompleted;
  bool isProfileCompletedForTalHospitals;
  String salutation;
  bool isBloodDonor;
  bool isPlateletsDonor;
  List<String> bloodDonationCategory;
  bool takingMedication;
  bool anyAllergies;
  bool outOfCountryTravel12Months;
  String countriesVisited;
  bool isBulkUpload;
  bool isTourCompletedForTalHospitals;
  Address volunteerAddress;
  String allergies;
  String medication;
  dynamic hideProfileCategory;
  dynamic hideProfileReason;
  dynamic hideProfileEndDate;
  List<String> languagePreferences;
  int userNameUpdatedAt;
  List<String> eventRegistrations;
  bool isTourCompletedForTalLeaders;
  int noOfCampaignsCreated;
  int noOfLivesImpacted;
  List<String> talLeaderPreferences;
  int weight;
  List<ProfileStatus> profileStatus;

  Data({
    required this.uniqueId,
    required this.email,
    required this.phone,
    required this.username,
    required this.displayName,
    required this.name,
    required this.profileImageUrl,
    required this.accountVerified,
    required this.accountStatus,
    required this.passwordVerified,
    required this.loginProvider,
    required this.emailVerified,
    required this.phoneVerified,
    required this.address,
    required this.roles,
    required this.socialVerification,
    required this.tokenDetail,
    required this.summary,
    required this.gender,
    required this.dob,
    required this.stripeCustomerId,
    required this.kindnessScore,
    required this.volunteerInfo,
    required this.coverImageUrl,
    required this.rating,
    required this.facebookProfileUrl,
    required this.twitterProfileUrl,
    required this.linkedInProfileUrl,
    required this.title,
    required this.aboutMe,
    required this.isTourCompleted,
    required this.isKindnessEventRegistered,
    required this.occupation,
    required this.organization,
    required this.yearsOfExperience,
    required this.isHackathonRegistered,
    required this.billingAddress,
    required this.totalEmailsPerMonth,
    required this.isMentor,
    required this.languages,
    required this.isProfileCompleted,
    required this.institutionName,
    required this.studentId,
    required this.institutionUrl,
    required this.institutionalRole,
    required this.educationalQualification,
    required this.educationalQualificationOthers,
    required this.mentorInfo,
    required this.isAssignMentor,
    required this.defaultChannel,
    required this.sourceOfSignup,
    required this.personalTraits,
    required this.functionalExpertise,
    required this.isTalLeader,
    required this.areasOfInterest,
    required this.isCertificationDownloaded,
    required this.medicalRegistration,
    required this.establishmentInformation,
    required this.specialities,
    required this.categoriesOfInterest,
    required this.typeOfHelpAndInvolvement,
    required this.interestedTypeOfOrgs,
    required this.interestedRegions,
    required this.profileVerificationStatus,
    required this.referralCode,
    required this.educationTimelines,
    required this.experience,
    required this.conferences,
    required this.certificates,
    required this.memberships,
    required this.achievements,
    required this.aadhaar,
    required this.pan,
    required this.oneHourPerWeek,
    required this.managementPosition,
    required this.currentRole,
    required this.currentCompanyName,
    required this.userComments,
    required this.userLikes,
    required this.professionalExperience,
    required this.location,
    required this.acceptedTermsAndConditions,
    required this.ipAddress,
    required this.reviewedBy,
    required this.notes,
    required this.bloodGroup,
    required this.isDonatedBefore,
    required this.noOfTimesDonated,
    required this.lastDonatedDate,
    required this.isTransmissibleDiseaseHistory,
    required this.transmissibleDiseaseHistory,
    required this.bloodRequirementAlerts,
    required this.researchParticipationInterest,
    required this.sourceOfDevice,
    required this.isPaidBootcamp,
    required this.isKindnessEventRegistered2023,
    required this.userRegistrationCategory,
    required this.educationInUkOrUs,
    required this.experienceInUkOrUs,
    required this.defaultHomePage,
    required this.registeredForEvent,
    required this.isBasicProfileCompleted,
    required this.isEducationProfileCompleted,
    required this.isExperienceProfileCompleted,
    required this.isConferencesProfileCompleted,
    required this.isCertificateProfileCompleted,
    required this.isMembershipProfileCompleted,
    required this.isSpecialitiesProfileCompleted,
    required this.isAchievementsProfileCompleted,
    required this.isProfileCompletedForTalHospitals,
    required this.salutation,
    required this.isBloodDonor,
    required this.isPlateletsDonor,
    required this.bloodDonationCategory,
    required this.takingMedication,
    required this.anyAllergies,
    required this.outOfCountryTravel12Months,
    required this.countriesVisited,
    required this.isBulkUpload,
    required this.isTourCompletedForTalHospitals,
    required this.volunteerAddress,
    required this.allergies,
    required this.medication,
    required this.hideProfileCategory,
    required this.hideProfileReason,
    required this.hideProfileEndDate,
    required this.languagePreferences,
    required this.userNameUpdatedAt,
    required this.eventRegistrations,
    required this.isTourCompletedForTalLeaders,
    required this.noOfCampaignsCreated,
    required this.noOfLivesImpacted,
    required this.talLeaderPreferences,
    required this.weight,
    required this.profileStatus,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    uniqueId: json["unique_id"] ?? '',
    email: json["email"] ?? '',
    phone: json["phone"] ?? '',
    username: json["username"] ?? '',
    displayName: json["display_name"] ?? '',
    name: Name.fromJson(json["name"] ?? {}),
    profileImageUrl: json["profile_image_url"] ?? '',
    accountVerified: json["account_verified"] ?? false,
    accountStatus: json["account_status"] ?? 0,
    passwordVerified: json["password_verified"] ?? false,
    loginProvider: json["login_provider"] ?? '',
    emailVerified: json["email_verified"] ?? false,
    phoneVerified: json["phone_verified"] ?? false,
    address: Address.fromJson(json["address"] ?? {}),
    roles: List<String>.from((json["roles"] ?? []).map((x) => x ?? '')),
    socialVerification: SocialVerification.fromJson(json["social_verification"] ?? {}),
    tokenDetail: TokenDetail.fromJson(json["token_detail"] ?? {}),
    summary: json["summary"] ?? '',
    gender: json["gender"] ?? '',
    dob: json["dob"] ?? 0,
    stripeCustomerId: json["stripeCustomerId"] ?? '',
    kindnessScore: json["kindness_score"] ?? 0,
    volunteerInfo: VolunteerInfo.fromJson(json["volunteerInfo"] ?? {}),
    coverImageUrl: json["coverImageUrl"] ?? '',
    rating: json["rating"] ?? 0,
    facebookProfileUrl: json["facebookProfileUrl"] ?? '',
    twitterProfileUrl: json["twitterProfileUrl"] ?? '',
    linkedInProfileUrl: json["linkedInProfileUrl"] ?? '',
    title: json["title"] ?? '',
    aboutMe: json["aboutMe"] ?? '',
    isTourCompleted: json["isTourCompleted"] ?? false,
    isKindnessEventRegistered: json["isKindnessEventRegistered"] ?? false,
    occupation: json["occupation"] ?? '',
    organization: json["organization"] ?? '',
    yearsOfExperience: json["yearsOfExperience"] ?? 0,
    isHackathonRegistered: json["isHackathonRegistered"] ?? false,
    billingAddress: Address.fromJson(json["billingAddress"] ?? {}),
    totalEmailsPerMonth: json["totalEmailsPerMonth"] ?? 0,
    isMentor: json["isMentor"] ?? false,
    languages: List<String>.from((json["languages"] ?? []).map((x) => x ?? '')),
    isProfileCompleted: json["isProfileCompleted"] ?? false,
    institutionName: json["institutionName"] ?? '',
    studentId: json["studentId"] ?? '',
    institutionUrl: json["institutionUrl"] ?? '',
    institutionalRole: json["institutionalRole"] ?? '',
    educationalQualification: json["educationalQualification"] ?? '',
    educationalQualificationOthers: json["educationalQualificationOthers"] ?? '',
    mentorInfo: MentorInfo.fromJson(json["mentorInfo"] ?? {}),
    isAssignMentor: json["isAssignMentor"] ?? false,
    defaultChannel: json["defaultChannel"] ?? '',
    sourceOfSignup: json["sourceOfSignup"] ?? '',
    personalTraits: List<String>.from((json["personalTraits"] ?? []).map((x) => x ?? '')),
    functionalExpertise: List<String>.from((json["functionalExpertise"] ?? []).map((x) => x ?? '')),
    isTalLeader: json["isTALLeader"] ?? false,
    areasOfInterest: List<String>.from((json["areasOfInterest"] ?? []).map((x) => x ?? '')),
    isCertificationDownloaded: json["isCertificationDownloaded"] ?? false,
    medicalRegistration: MedicalRegistration.fromJson(json["medicalRegistration"] ?? {}),
    establishmentInformation: EstablishmentInformation.fromJson(json["establishmentInformation"] ?? {}),
    specialities: List<String>.from((json["specialities"] ?? []).map((x) => x ?? '')),
    categoriesOfInterest: List<dynamic>.from((json["categoriesOfInterest"] ?? []).map((x) => x)),
    typeOfHelpAndInvolvement: List<dynamic>.from((json["typeOfHelpAndInvolvement"] ?? []).map((x) => x)),
    interestedTypeOfOrgs: List<dynamic>.from((json["interestedTypeOfOrgs"] ?? []).map((x) => x)),
    interestedRegions: List<dynamic>.from((json["interestedRegions"] ?? []).map((x) => x)),
    profileVerificationStatus: json["profileVerificationStatus"] ?? 0,
    referralCode: json["referral_code"] ?? '',
    educationTimelines: List<EducationTimeline>.from((json["educationTimelines"] ?? []).map((x) => EducationTimeline.fromJson(x ?? {}))),
    experience: List<Experience>.from((json["experience"] ?? []).map((x) => Experience.fromJson(x ?? {}))),
    conferences: List<Conference>.from((json["conferences"] ?? []).map((x) => Conference.fromJson(x ?? {}))),
    certificates: List<Certificate>.from((json["certificates"] ?? []).map((x) => Certificate.fromJson(x ?? {}))),
    memberships: List<Membership>.from((json["memberships"] ?? []).map((x) => Membership.fromJson(x ?? {}))),
    achievements: List<Achievement>.from((json["achievements"] ?? []).map((x) => Achievement.fromJson(x ?? {}))),
    aadhaar: json["aadhaar"] ?? '',
    pan: json["pan"] ?? '',
    oneHourPerWeek: json["oneHourPerWeek"] ?? false,
    managementPosition: json["managementPosition"] ?? false,
    currentRole: json["currentRole"] ?? '',
    currentCompanyName: json["currentCompanyName"] ?? '',
    userComments: List<dynamic>.from(json["userComments"].map((x) => x)),
    userLikes: List<UserLike>.from(json["userLikes"].map((x) => UserLike.fromJson(x))),
    professionalExperience: json["professionalExperience"] ?? '',
    location: Location.fromJson(json["location"] ?? {}),
    acceptedTermsAndConditions: json["acceptedTermsAndConditions"] ?? false,
    ipAddress: json["ipAddress"],
    reviewedBy: List<dynamic>.from(json["reviewedBy"].map((x) => x)),
    notes: json["notes"],
    bloodGroup: json["bloodGroup"] ?? '',
    isDonatedBefore: json["isDonatedBefore"] ?? false,
    noOfTimesDonated: json["noOfTimesDonated"] ?? 0,
    lastDonatedDate: json["lastDonatedDate"] ?? 0,
    isTransmissibleDiseaseHistory: json["isTransmissibleDiseaseHistory"] ?? false,
    transmissibleDiseaseHistory: json["transmissibleDiseaseHistory"] ?? '',
    bloodRequirementAlerts: json["bloodRequirementAlerts"] ?? false,
    researchParticipationInterest: json["researchParticipationInterest"] ?? false,
    sourceOfDevice: json["sourceOfDevice"] ?? '',
    isPaidBootcamp: json["isPaidBootcamp"] ?? false,
    isKindnessEventRegistered2023: json["isKindnessEventRegistered2023"] ?? false,
    userRegistrationCategory: json["userRegistrationCategory"] ?? '',
    educationInUkOrUs: List<dynamic>.from(json["educationInUKOrUS"].map((x) => x)),
    experienceInUkOrUs: json["experienceInUKOrUS"],
    defaultHomePage: json["defaultHomePage"] ?? '',
    registeredForEvent: json["registeredForEvent"] ?? '',
    isBasicProfileCompleted: json["isBasicProfileCompleted"] ?? false,
    isEducationProfileCompleted: json["isEducationProfileCompleted"] ?? false,
    isExperienceProfileCompleted: json["isExperienceProfileCompleted"] ?? false,
    isConferencesProfileCompleted: json["isConferencesProfileCompleted"] ?? false,
    isCertificateProfileCompleted: json["isCertificateProfileCompleted"] ?? false,
    isMembershipProfileCompleted: json["isMembershipProfileCompleted"] ?? false,
    isSpecialitiesProfileCompleted: json["isSpecialitiesProfileCompleted"] ?? false,
    isAchievementsProfileCompleted: json["isAchievementsProfileCompleted"] ?? false,
    isProfileCompletedForTalHospitals: json["isProfileCompletedForTalHospitals"] ?? false,
    salutation: json["salutation"] ?? '',
    isBloodDonor: json["isBloodDonor"] ?? false,
    isPlateletsDonor: json["isPlateletsDonor"] ?? false,
    bloodDonationCategory: List<String>.from((json["bloodDonationCategory"] ?? []).map((x) => x ?? '')),
    takingMedication: json["takingMedication"] ?? false,
    anyAllergies: json["anyAllergies"] ?? false,
    outOfCountryTravel12Months: json["outOfCountryTravel12months"] ?? false,
    countriesVisited: json["countriesVisited"] ?? '',
    isBulkUpload: json["isBulkUpload"] ?? false,
    isTourCompletedForTalHospitals: json["isTourCompletedForTalHospitals"] ?? false,
    volunteerAddress: Address.fromJson(json["volunteerAddress"] ?? {}),
    allergies: json["allergies"] ?? '',
    medication: json["medication"] ?? '',
    hideProfileCategory: json["hideProfileCategory"],
    hideProfileReason: json["hideProfileReason"],
    hideProfileEndDate: json["hideProfileEndDate"],
    languagePreferences: List<String>.from((json["languagePreferences"] ?? []).map((x) => x ?? '')),
    userNameUpdatedAt: json["userNameUpdatedAt"] ?? 0,
    eventRegistrations: List<String>.from((json["eventRegistrations"] ?? []).map((x) => x ?? '')),
    isTourCompletedForTalLeaders: json["isTourCompletedForTalLeaders"] ?? false,
    noOfCampaignsCreated: json["noOfCampaignsCreated"] ?? 0,
    noOfLivesImpacted: json["noOfLivesImpacted"] ?? 0,
    talLeaderPreferences: List<String>.from((json["talLeaderPreferences"] ?? []).map((x) => x ?? '')),
    weight: json["weight"] ?? 0,
    profileStatus: List<ProfileStatus>.from(json["profileStatus"].map((x) => ProfileStatus.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "unique_id": uniqueId,
    "email": email,
    "phone": phone,
    "username": username,
    "display_name": displayName,
    "name": name.toJson(),
    "profile_image_url": profileImageUrl,
    "account_verified": accountVerified,
    "account_status": accountStatus,
    "password_verified": passwordVerified,
    "login_provider": loginProvider,
    "email_verified": emailVerified,
    "phone_verified": phoneVerified,
    "address": address.toJson(),
    "roles": List<dynamic>.from(roles.map((x) => x)),
    "social_verification": socialVerification.toJson(),
    "token_detail": tokenDetail.toJson(),
    "summary": summary,
    "gender": gender,
    "dob": dob,
    "stripeCustomerId": stripeCustomerId,
    "kindness_score": kindnessScore,
    "volunteerInfo": volunteerInfo.toJson(),
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
    "billingAddress": billingAddress.toJson(),
    "totalEmailsPerMonth": totalEmailsPerMonth,
    "isMentor": isMentor,
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "isProfileCompleted": isProfileCompleted,
    "institutionName": institutionName,
    "studentId": studentId,
    "institutionUrl": institutionUrl,
    "institutionalRole": institutionalRole,
    "educationalQualification": educationalQualification,
    "educationalQualificationOthers": educationalQualificationOthers,
    "mentorInfo": mentorInfo.toJson(),
    "isAssignMentor": isAssignMentor,
    "defaultChannel": defaultChannel,
    "sourceOfSignup": sourceOfSignup,
    "personalTraits": List<dynamic>.from(personalTraits.map((x) => x)),
    "functionalExpertise": List<dynamic>.from(functionalExpertise.map((x) => x)),
    "isTALLeader": isTalLeader,
    "areasOfInterest": List<dynamic>.from(areasOfInterest.map((x) => x)),
    "isCertificationDownloaded": isCertificationDownloaded,
    "medicalRegistration": medicalRegistration.toJson(),
    "establishmentInformation": establishmentInformation.toJson(),
    "specialities": List<dynamic>.from(specialities.map((x) => x)),
    "categoriesOfInterest": List<dynamic>.from(categoriesOfInterest.map((x) => x)),
    "typeOfHelpAndInvolvement": List<dynamic>.from(typeOfHelpAndInvolvement.map((x) => x)),
    "interestedTypeOfOrgs": List<dynamic>.from(interestedTypeOfOrgs.map((x) => x)),
    "interestedRegions": List<dynamic>.from(interestedRegions.map((x) => x)),
    "profileVerificationStatus": profileVerificationStatus,
    "referral_code": referralCode,
    "educationTimelines": List<dynamic>.from(educationTimelines.map((x) => x.toJson())),
    "experience": List<dynamic>.from(experience.map((x) => x.toJson())),
    "conferences": List<dynamic>.from(conferences.map((x) => x.toJson())),
    "certificates": List<dynamic>.from(certificates.map((x) => x.toJson())),
    "memberships": List<dynamic>.from(memberships.map((x) => x.toJson())),
    "achievements": List<dynamic>.from(achievements.map((x) => x.toJson())),
    "aadhaar": aadhaar,
    "pan": pan,
    "oneHourPerWeek": oneHourPerWeek,
    "managementPosition": managementPosition,
    "currentRole": currentRole,
    "currentCompanyName": currentCompanyName,
    "userComments": List<dynamic>.from(userComments.map((x) => x)),
    "userLikes": List<dynamic>.from(userLikes.map((x) => x.toJson())),
    "professionalExperience": professionalExperience,
    "location": location.toJson(),
    "acceptedTermsAndConditions": acceptedTermsAndConditions,
    "ipAddress": ipAddress,
    "reviewedBy": List<dynamic>.from(reviewedBy.map((x) => x)),
    "notes": notes,
    "bloodGroup": bloodGroup,
    "isDonatedBefore": isDonatedBefore,
    "noOfTimesDonated": noOfTimesDonated,
    "lastDonatedDate": lastDonatedDate,
    "isTransmissibleDiseaseHistory": isTransmissibleDiseaseHistory,
    "transmissibleDiseaseHistory": transmissibleDiseaseHistory,
    "bloodRequirementAlerts": bloodRequirementAlerts,
    "researchParticipationInterest": researchParticipationInterest,
    "sourceOfDevice": sourceOfDevice,
    "isPaidBootcamp": isPaidBootcamp,
    "isKindnessEventRegistered2023": isKindnessEventRegistered2023,
    "userRegistrationCategory": userRegistrationCategory,
    "educationInUKOrUS": List<dynamic>.from(educationInUkOrUs.map((x) => x)),
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
    "bloodDonationCategory": List<dynamic>.from(bloodDonationCategory.map((x) => x)),
    "takingMedication": takingMedication,
    "anyAllergies": anyAllergies,
    "outOfCountryTravel12months": outOfCountryTravel12Months,
    "countriesVisited": countriesVisited,
    "isBulkUpload": isBulkUpload,
    "isTourCompletedForTalHospitals": isTourCompletedForTalHospitals,
    "volunteerAddress": volunteerAddress.toJson(),
    "allergies": allergies,
    "medication": medication,
    "hideProfileCategory": hideProfileCategory,
    "hideProfileReason": hideProfileReason,
    "hideProfileEndDate": hideProfileEndDate,
    "languagePreferences": List<dynamic>.from(languagePreferences.map((x) => x)),
    "userNameUpdatedAt": userNameUpdatedAt,
    "eventRegistrations": List<dynamic>.from(eventRegistrations.map((x) => x)),
    "isTourCompletedForTalLeaders": isTourCompletedForTalLeaders,
    "noOfCampaignsCreated": noOfCampaignsCreated,
    "noOfLivesImpacted": noOfLivesImpacted,
    "talLeaderPreferences": List<dynamic>.from(talLeaderPreferences.map((x) => x)),
    "weight": weight,
    "profileStatus": List<dynamic>.from(profileStatus.map((x) => x.toJson())),
  };
}


class Address {
  String line1;
  String line2;
  dynamic locality;
  String city;
  String state;
  String district;
  String mandal;
  String village;
  String country;
  String zipCode;

  Address({
    required this.line1,
    required this.line2,
    this.locality,
    required this.city,
    required this.state,
    required this.district,
    required this.mandal,
    required this.village,
    required this.country,
    required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    line1: json["line1"] ?? '',
    line2: json["line2"] ?? '',
    locality: json["locality"],
    city: json["city"] ?? '',
    state: json["state"] ?? '',
    district: json["district"] ?? '',
    mandal: json["mandal"] ?? '',
    village: json["village"] ?? '',
    country: json["country"] ?? '',
    zipCode: json["zip_code"] ?? '',
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
  String id;
  String title;
  String issuedBy;
  String description;
  DateTime updatedAt;
  DateTime createdAt;

  Certificate({
    required this.id,
    required this.title,
    required this.issuedBy,
    required this.description,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
    id: json["_id"] ?? '',
    title: json["title"] ?? '',
    issuedBy: json["issuedBy"] ?? '',
    description: json["description"] ?? '',
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "issuedBy": issuedBy,
    "description": description,
    "updatedAt": updatedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
  };
}

class Conference {
  String id;
  String name;
  int date;
  DateTime updatedAt;
  DateTime createdAt;

  Conference({
    required this.id,
    required this.name,
    required this.date,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Conference.fromJson(Map<String, dynamic> json) => Conference(
    id: json["_id"] ?? '',
    name: json["name"] ?? '',
    date: json["date"] ?? 0,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "date": date,
    "updatedAt": updatedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
  };
}

class EducationTimeline {
  String id;
  String education;
  String degree;
  String fieldOfStudy;
  int educationalStartDate;
  int educationalEndDate;
  DateTime updatedAt;
  DateTime createdAt;

  EducationTimeline({
    required this.id,
    required this.education,
    required this.degree,
    required this.fieldOfStudy,
    required this.educationalStartDate,
    required this.educationalEndDate,
    required this.updatedAt,
    required this.createdAt,
  });

  factory EducationTimeline.fromJson(Map<String, dynamic> json) => EducationTimeline(
    id: json["_id"] ?? '',
    education: json["education"] ?? '',
    degree: json["degree"] ?? '',
    fieldOfStudy: json["fieldOfStudy"] ?? '',
    educationalStartDate: json["educationalStartDate"] ?? 0,
    educationalEndDate: json["educationalEndDate"] ?? 0,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "education": education,
    "degree": degree,
    "fieldOfStudy": fieldOfStudy,
    "educationalStartDate": educationalStartDate,
    "educationalEndDate": educationalEndDate,
    "updatedAt": updatedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
  };
}

class EstablishmentInformation {
  String line1;
  String line2;
  String city;
  String state;
  String country;
  String zipCode;

  EstablishmentInformation({
    required this.line1,
    required this.line2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  factory EstablishmentInformation.fromJson(Map<String, dynamic> json) => EstablishmentInformation(
    line1: json["line1"] ?? '',
    line2: json["line2"] ?? '',
    city: json["city"] ?? '',
    state: json["state"] ?? '',
    country: json["country"] ?? '',
    zipCode: json["zip_code"] ?? '',
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


class Location {
  String type;
  List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"] ?? '',
    coordinates: json["coordinates"] == null ? <double>[] : List<double>.from((json["coordinates"] as List).map((x) => (x ?? 0.0).toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}

class MedicalRegistration {
  String registrationNumber;
  String registrationCouncil;
  int registrationYear;

  MedicalRegistration({
    required this.registrationNumber,
    required this.registrationCouncil,
    required this.registrationYear,
  });

  factory MedicalRegistration.fromJson(Map<String, dynamic> json) => MedicalRegistration(
    registrationNumber: json["registrationNumber"] ?? '',
    registrationCouncil: json["registrationCouncil"] ?? '',
    registrationYear: json["registrationYear"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "registrationNumber": registrationNumber,
    "registrationCouncil": registrationCouncil,
    "registrationYear": registrationYear,
  };
}

class Membership {
  String id;
  String membership;
  int startDate;
  int endDate;
  DateTime updatedAt;
  DateTime createdAt;

  Membership({
    required this.id,
    required this.membership,
    required this.startDate,
    required this.endDate,
    required this.updatedAt,
    required this.createdAt,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
    id: json["_id"] ?? '',
    membership: json["membership"] ?? '',
    startDate: json["startDate"] ?? 0,
    endDate: json["endDate"] ?? 0,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : DateTime.fromMillisecondsSinceEpoch(0),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "membership": membership,
    "startDate": startDate,
    "endDate": endDate,
    "updatedAt": updatedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
  };
}

class UserLike {
  Name name;
  Address address;
  String displayName;
  String phone;
  String imageUrl;
  String studentId;
  bool isTalLeader;
  String id;
  String username;
  String email;
  String currentRole;
  String currentCompanyName;

  UserLike({
    required this.name,
    required this.address,
    required this.displayName,
    required this.phone,
    required this.imageUrl,
    required this.studentId,
    required this.isTalLeader,
    required this.id,
    required this.username,
    required this.email,
    required this.currentRole,
    required this.currentCompanyName,
  });

  factory UserLike.fromJson(Map<String, dynamic> json) => UserLike(
    name: Name.fromJson(json["name"] ?? {}),
    address: Address.fromJson(json["address"] ?? {}),
    displayName: json["display_name"] ?? '',
    phone: json["phone"] ?? '',
    imageUrl: json["image_url"] ?? '',
    studentId: json["studentId"] ?? '',
    isTalLeader: json["isTALLeader"] ?? false,
    id: json["_id"] ?? '',
    username: json["username"] ?? '',
    email: json["email"] ?? '',
    currentRole: json["currentRole"] ?? '',
    currentCompanyName: json["currentCompanyName"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "name": name.toJson(),
    "address": address.toJson(),
    "display_name": displayName,
    "phone": phone,
    "image_url": imageUrl,
    "studentId": studentId,
    "isTALLeader": isTalLeader,
    "_id": id,
    "username": username,
    "email": email,
    "currentRole": currentRole,
    "currentCompanyName": currentCompanyName,
  };
}

class VolunteerInfo {
  dynamic isInterested;

  VolunteerInfo({
    required this.isInterested,
  });

  factory VolunteerInfo.fromJson(Map<String, dynamic> json) => VolunteerInfo(
    isInterested: json["isInterested"],
  );

  Map<String, dynamic> toJson() => {
    "isInterested": isInterested,
  };
}

class Name {
  String middleName;
  String firstName;
  String lastName;

  Name({
    required this.middleName,
    required this.firstName,
    required this.lastName,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    middleName: json["middle_name"] ?? '',
    firstName: json["first_name"] ?? '',
    lastName: json["last_name"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "middle_name": middleName,
    "first_name": firstName,
    "last_name": lastName,
  };
}

class ProfileStatus {
  String id;
  String type;
  String reason;
  int endDate;
  bool hideStatus;
  DateTime updatedAt;
  DateTime createdAt;

  ProfileStatus({
    required this.id,
    required this.type,
    required this.reason,
    required this.endDate,
    required this.hideStatus,
    required this.updatedAt,
    required this.createdAt,
  });

  factory ProfileStatus.fromJson(Map<String, dynamic> json) => ProfileStatus(
    id: json["_id"],
    type: json["type"],
    reason: json["reason"],
    endDate: json["endDate"] ?? 0,
    hideStatus: json["hideStatus"],
    updatedAt: DateTime.parse(json["updatedAt"]),
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "type": type,
    "reason": reason,
    "endDate": endDate,
    "hideStatus": hideStatus,
    "updatedAt": updatedAt.toIso8601String(),
    "createdAt": createdAt.toIso8601String(),
  };
}

class SocialVerification {
  bool googleVerified;
  bool facebookVerified;
  bool linkedinVerified;
  bool twitterVerified;
  bool appleVerified;

  SocialVerification({
    required this.googleVerified,
    required this.facebookVerified,
    required this.linkedinVerified,
    required this.twitterVerified,
    required this.appleVerified,
  });

  factory SocialVerification.fromJson(Map<String, dynamic> json) => SocialVerification(
    googleVerified: json["google_verified"] ?? false,
    facebookVerified: json["facebook_verified"] ?? false,
    linkedinVerified: json["linkedin_verified"] ?? false,
    twitterVerified: json["twitter_verified"] ?? false,
    appleVerified: json["apple_verified"] ?? false,
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
  String token;
  String type;

  TokenDetail({
    required this.token,
    required this.type,
  });

  factory TokenDetail.fromJson(Map<String, dynamic> json) => TokenDetail(
    token: json["token"] ?? '',
    type: json["type"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "type": type,
  };
}

