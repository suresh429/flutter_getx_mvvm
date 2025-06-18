// To parse this JSON data, do
//
//     final voteLeader = voteLeaderFromJson(jsonString);

import 'dart:convert';

VoteLeader voteLeaderFromJson(String str) => VoteLeader.fromJson(json.decode(str));

String voteLeaderToJson(VoteLeader data) => json.encode(data.toJson());

class VoteLeader {
  final String? status;
  final int? statusCode;
  final String? message;
  final List<Datum>? data;
  final int? totalCountOfRecords;

  VoteLeader({
    this.status,
    this.statusCode,
    this.message,
    this.data,
    this.totalCountOfRecords,
  });

  VoteLeader copyWith({
    String? status,
    int? statusCode,
    String? message,
    List<Datum>? data,
    int? totalCountOfRecords,
  }) =>
      VoteLeader(
        status: status ?? this.status,
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
        totalCountOfRecords: totalCountOfRecords ?? this.totalCountOfRecords,
      );

  factory VoteLeader.fromJson(Map<String, dynamic> json) => VoteLeader(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    totalCountOfRecords: json["totalCountOfRecords"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "totalCountOfRecords": totalCountOfRecords,
  };
}

class Datum {
  final Name? name;
  final ReferredDetails? referredDetails;
  final Address? address;
  final Address? billingAddress;
  final Location? location;
  final SocialVerification? socialVerification;
  final VolunteerInfo? volunteerInfo;
  final MentorInfo? mentorInfo;
  final EstablishmentInformation? establishmentInformation;
  final Address? volunteerAddress;
  final String? imageUrl;
  final int? averageRating;
  final int? ratingCount;
  final String? id;
  final String? displayName;
  final String? username;
  final String? email;
  final bool? emailVerified;
  final String? phone;
  final bool? phoneVerified;
  final String? summary;
  final int? dob;
  final String? gender;
  final bool? isProfileCompleted;
  final String? institutionName;
  final String? studentId;
  final String? institutionUrl;
  final String? institutionalRole;
  final String? educationalQualification;
  final int? accountStatus;
  final bool? accountVerified;
  final bool? accountDeactivate;
  final bool? accountDelete;
  final int? kindnessScore;
  final List<String>? roles;
  final List<String>? areasOfInterest;
  final String? linkedInProfileUrl;
  final bool? isTourCompleted;
  final bool? isTourCompletedForTalHospitals;
  final bool? isKindnessEventRegistered;
  final bool? isKindnessEventRegistered2023;
  final bool? isHackathonRegistered;
  final int? totalEmailsPerMonth;
  final bool? isMentor;
  final String? sourceOfSignup;
  final String? sourceOfDevice;
  final List<dynamic>? languages;
  final bool? isAssignMentor;
  final bool? isTalLeader;
  final List<dynamic>? personalTraits;
  final List<dynamic>? functionalExpertise;
  final bool? isCertificationDownloaded;
  final List<dynamic>? specialities;
  final List<dynamic>? categoriesOfInterest;
  final List<dynamic>? typeOfHelpAndInvolvement;
  final List<dynamic>? interestedTypeOfOrgs;
  final List<dynamic>? interestedRegions;
  final int? profileVerificationStatus;
  final List<dynamic>? experience;
  final String? howDidYouHear;
  final String? referenceName;
  final bool? oneHourPerWeek;
  final bool? managementPosition;
  final String? serveAndMakeImpact;
  final String? currentRole;
  final String? currentCompanyName;
  final List<UserLike>? userLikes;
  final bool? acceptedTermsAndConditions;
  final dynamic notes;
  final bool? takingMedication;
  final bool? anyAllergies;
  final bool? outOfCountryTravel12Months;
  final bool? bloodRequirementAlerts;
  final bool? isPaidBootcamp;
  final List<dynamic>? educationInUkOrUs;
  final dynamic experienceInUkOrUs;
  final String? registeredForEvent;
  final bool? isBasicProfileCompleted;
  final bool? isEducationProfileCompleted;
  final bool? isExperienceProfileCompleted;
  final bool? isConferencesProfileCompleted;
  final bool? isCertificateProfileCompleted;
  final bool? isMembershipProfileCompleted;
  final bool? isSpecialitiesProfileCompleted;
  final bool? isAchievementsProfileCompleted;
  final bool? isProfileCompletedForTalHospitals;
  final String? salutation;
  final bool? isTalTalksRegistration2024;
  final bool? isBloodDonor;
  final bool? isPlateletsDonor;
  final List<dynamic>? bloodDonationCategory;
  final bool? isBulkUpload;
  final bool? isFacilityDoctor;
  final List<dynamic>? languagePreferences;
  final List<dynamic>? talLeaderPreferences;
  final List<dynamic>? eventRegistrations;
  final bool? isTourCompletedForTalLeaders;
  final bool? isTalhospitalVolunteer;
  final int? fcraDocumentStatus;
  final List<dynamic>? educationTimelines;
  final List<dynamic>? achievements;
  final List<dynamic>? userComments;
  final List<dynamic>? reviewedBy;
  final List<dynamic>? profileStatus;
  final List<dynamic>? certificates;
  final List<dynamic>? conferences;
  final List<dynamic>? memberships;
  final List<dynamic>? attendedEvents;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Datum({
    this.name,
    this.referredDetails,
    this.address,
    this.billingAddress,
    this.location,
    this.socialVerification,
    this.volunteerInfo,
    this.mentorInfo,
    this.establishmentInformation,
    this.volunteerAddress,
    this.imageUrl,
    this.averageRating,
    this.ratingCount,
    this.id,
    this.displayName,
    this.username,
    this.email,
    this.emailVerified,
    this.phone,
    this.phoneVerified,
    this.summary,
    this.dob,
    this.gender,
    this.isProfileCompleted,
    this.institutionName,
    this.studentId,
    this.institutionUrl,
    this.institutionalRole,
    this.educationalQualification,
    this.accountStatus,
    this.accountVerified,
    this.accountDeactivate,
    this.accountDelete,
    this.kindnessScore,
    this.roles,
    this.areasOfInterest,
    this.linkedInProfileUrl,
    this.isTourCompleted,
    this.isTourCompletedForTalHospitals,
    this.isKindnessEventRegistered,
    this.isKindnessEventRegistered2023,
    this.isHackathonRegistered,
    this.totalEmailsPerMonth,
    this.isMentor,
    this.sourceOfSignup,
    this.sourceOfDevice,
    this.languages,
    this.isAssignMentor,
    this.isTalLeader,
    this.personalTraits,
    this.functionalExpertise,
    this.isCertificationDownloaded,
    this.specialities,
    this.categoriesOfInterest,
    this.typeOfHelpAndInvolvement,
    this.interestedTypeOfOrgs,
    this.interestedRegions,
    this.profileVerificationStatus,
    this.experience,
    this.howDidYouHear,
    this.referenceName,
    this.oneHourPerWeek,
    this.managementPosition,
    this.serveAndMakeImpact,
    this.currentRole,
    this.currentCompanyName,
    this.userLikes,
    this.acceptedTermsAndConditions,
    this.notes,
    this.takingMedication,
    this.anyAllergies,
    this.outOfCountryTravel12Months,
    this.bloodRequirementAlerts,
    this.isPaidBootcamp,
    this.educationInUkOrUs,
    this.experienceInUkOrUs,
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
    this.isTalTalksRegistration2024,
    this.isBloodDonor,
    this.isPlateletsDonor,
    this.bloodDonationCategory,
    this.isBulkUpload,
    this.isFacilityDoctor,
    this.languagePreferences,
    this.talLeaderPreferences,
    this.eventRegistrations,
    this.isTourCompletedForTalLeaders,
    this.isTalhospitalVolunteer,
    this.fcraDocumentStatus,
    this.educationTimelines,
    this.achievements,
    this.userComments,
    this.reviewedBy,
    this.profileStatus,
    this.certificates,
    this.conferences,
    this.memberships,
    this.attendedEvents,
    this.createdAt,
    this.updatedAt,
  });

  Datum copyWith({
    Name? name,
    ReferredDetails? referredDetails,
    Address? address,
    Address? billingAddress,
    Location? location,
    SocialVerification? socialVerification,
    VolunteerInfo? volunteerInfo,
    MentorInfo? mentorInfo,
    EstablishmentInformation? establishmentInformation,
    Address? volunteerAddress,
    String? imageUrl,
    int? averageRating,
    int? ratingCount,
    String? id,
    String? displayName,
    String? username,
    String? email,
    bool? emailVerified,
    String? phone,
    bool? phoneVerified,
    String? summary,
    int? dob,
    String? gender,
    bool? isProfileCompleted,
    String? institutionName,
    String? studentId,
    String? institutionUrl,
    String? institutionalRole,
    String? educationalQualification,
    int? accountStatus,
    bool? accountVerified,
    bool? accountDeactivate,
    bool? accountDelete,
    int? kindnessScore,
    List<String>? roles,
    List<String>? areasOfInterest,
    String? linkedInProfileUrl,
    bool? isTourCompleted,
    bool? isTourCompletedForTalHospitals,
    bool? isKindnessEventRegistered,
    bool? isKindnessEventRegistered2023,
    bool? isHackathonRegistered,
    int? totalEmailsPerMonth,
    bool? isMentor,
    String? sourceOfSignup,
    String? sourceOfDevice,
    List<dynamic>? languages,
    bool? isAssignMentor,
    bool? isTalLeader,
    List<dynamic>? personalTraits,
    List<dynamic>? functionalExpertise,
    bool? isCertificationDownloaded,
    List<dynamic>? specialities,
    List<dynamic>? categoriesOfInterest,
    List<dynamic>? typeOfHelpAndInvolvement,
    List<dynamic>? interestedTypeOfOrgs,
    List<dynamic>? interestedRegions,
    int? profileVerificationStatus,
    List<dynamic>? experience,
    String? howDidYouHear,
    String? referenceName,
    bool? oneHourPerWeek,
    bool? managementPosition,
    String? serveAndMakeImpact,
    String? currentRole,
    String? currentCompanyName,
    List<UserLike>? userLikes,
    bool? acceptedTermsAndConditions,
    dynamic notes,
    bool? takingMedication,
    bool? anyAllergies,
    bool? outOfCountryTravel12Months,
    bool? bloodRequirementAlerts,
    bool? isPaidBootcamp,
    List<dynamic>? educationInUkOrUs,
    dynamic experienceInUkOrUs,
    String? registeredForEvent,
    bool? isBasicProfileCompleted,
    bool? isEducationProfileCompleted,
    bool? isExperienceProfileCompleted,
    bool? isConferencesProfileCompleted,
    bool? isCertificateProfileCompleted,
    bool? isMembershipProfileCompleted,
    bool? isSpecialitiesProfileCompleted,
    bool? isAchievementsProfileCompleted,
    bool? isProfileCompletedForTalHospitals,
    String? salutation,
    bool? isTalTalksRegistration2024,
    bool? isBloodDonor,
    bool? isPlateletsDonor,
    List<dynamic>? bloodDonationCategory,
    bool? isBulkUpload,
    bool? isFacilityDoctor,
    List<dynamic>? languagePreferences,
    List<dynamic>? talLeaderPreferences,
    List<dynamic>? eventRegistrations,
    bool? isTourCompletedForTalLeaders,
    bool? isTalhospitalVolunteer,
    int? fcraDocumentStatus,
    List<dynamic>? educationTimelines,
    List<dynamic>? achievements,
    List<dynamic>? userComments,
    List<dynamic>? reviewedBy,
    List<dynamic>? profileStatus,
    List<dynamic>? certificates,
    List<dynamic>? conferences,
    List<dynamic>? memberships,
    List<dynamic>? attendedEvents,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Datum(
        name: name ?? this.name,
        referredDetails: referredDetails ?? this.referredDetails,
        address: address ?? this.address,
        billingAddress: billingAddress ?? this.billingAddress,
        location: location ?? this.location,
        socialVerification: socialVerification ?? this.socialVerification,
        volunteerInfo: volunteerInfo ?? this.volunteerInfo,
        mentorInfo: mentorInfo ?? this.mentorInfo,
        establishmentInformation: establishmentInformation ?? this.establishmentInformation,
        volunteerAddress: volunteerAddress ?? this.volunteerAddress,
        imageUrl: imageUrl ?? this.imageUrl,
        averageRating: averageRating ?? this.averageRating,
        ratingCount: ratingCount ?? this.ratingCount,
        id: id ?? this.id,
        displayName: displayName ?? this.displayName,
        username: username ?? this.username,
        email: email ?? this.email,
        emailVerified: emailVerified ?? this.emailVerified,
        phone: phone ?? this.phone,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        summary: summary ?? this.summary,
        dob: dob ?? this.dob,
        gender: gender ?? this.gender,
        isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
        institutionName: institutionName ?? this.institutionName,
        studentId: studentId ?? this.studentId,
        institutionUrl: institutionUrl ?? this.institutionUrl,
        institutionalRole: institutionalRole ?? this.institutionalRole,
        educationalQualification: educationalQualification ?? this.educationalQualification,
        accountStatus: accountStatus ?? this.accountStatus,
        accountVerified: accountVerified ?? this.accountVerified,
        accountDeactivate: accountDeactivate ?? this.accountDeactivate,
        accountDelete: accountDelete ?? this.accountDelete,
        kindnessScore: kindnessScore ?? this.kindnessScore,
        roles: roles ?? this.roles,
        areasOfInterest: areasOfInterest ?? this.areasOfInterest,
        linkedInProfileUrl: linkedInProfileUrl ?? this.linkedInProfileUrl,
        isTourCompleted: isTourCompleted ?? this.isTourCompleted,
        isTourCompletedForTalHospitals: isTourCompletedForTalHospitals ?? this.isTourCompletedForTalHospitals,
        isKindnessEventRegistered: isKindnessEventRegistered ?? this.isKindnessEventRegistered,
        isKindnessEventRegistered2023: isKindnessEventRegistered2023 ?? this.isKindnessEventRegistered2023,
        isHackathonRegistered: isHackathonRegistered ?? this.isHackathonRegistered,
        totalEmailsPerMonth: totalEmailsPerMonth ?? this.totalEmailsPerMonth,
        isMentor: isMentor ?? this.isMentor,
        sourceOfSignup: sourceOfSignup ?? this.sourceOfSignup,
        sourceOfDevice: sourceOfDevice ?? this.sourceOfDevice,
        languages: languages ?? this.languages,
        isAssignMentor: isAssignMentor ?? this.isAssignMentor,
        isTalLeader: isTalLeader ?? this.isTalLeader,
        personalTraits: personalTraits ?? this.personalTraits,
        functionalExpertise: functionalExpertise ?? this.functionalExpertise,
        isCertificationDownloaded: isCertificationDownloaded ?? this.isCertificationDownloaded,
        specialities: specialities ?? this.specialities,
        categoriesOfInterest: categoriesOfInterest ?? this.categoriesOfInterest,
        typeOfHelpAndInvolvement: typeOfHelpAndInvolvement ?? this.typeOfHelpAndInvolvement,
        interestedTypeOfOrgs: interestedTypeOfOrgs ?? this.interestedTypeOfOrgs,
        interestedRegions: interestedRegions ?? this.interestedRegions,
        profileVerificationStatus: profileVerificationStatus ?? this.profileVerificationStatus,
        experience: experience ?? this.experience,
        howDidYouHear: howDidYouHear ?? this.howDidYouHear,
        referenceName: referenceName ?? this.referenceName,
        oneHourPerWeek: oneHourPerWeek ?? this.oneHourPerWeek,
        managementPosition: managementPosition ?? this.managementPosition,
        serveAndMakeImpact: serveAndMakeImpact ?? this.serveAndMakeImpact,
        currentRole: currentRole ?? this.currentRole,
        currentCompanyName: currentCompanyName ?? this.currentCompanyName,
        userLikes: userLikes ?? this.userLikes,
        acceptedTermsAndConditions: acceptedTermsAndConditions ?? this.acceptedTermsAndConditions,
        notes: notes ?? this.notes,
        takingMedication: takingMedication ?? this.takingMedication,
        anyAllergies: anyAllergies ?? this.anyAllergies,
        outOfCountryTravel12Months: outOfCountryTravel12Months ?? this.outOfCountryTravel12Months,
        bloodRequirementAlerts: bloodRequirementAlerts ?? this.bloodRequirementAlerts,
        isPaidBootcamp: isPaidBootcamp ?? this.isPaidBootcamp,
        educationInUkOrUs: educationInUkOrUs ?? this.educationInUkOrUs,
        experienceInUkOrUs: experienceInUkOrUs ?? this.experienceInUkOrUs,
        registeredForEvent: registeredForEvent ?? this.registeredForEvent,
        isBasicProfileCompleted: isBasicProfileCompleted ?? this.isBasicProfileCompleted,
        isEducationProfileCompleted: isEducationProfileCompleted ?? this.isEducationProfileCompleted,
        isExperienceProfileCompleted: isExperienceProfileCompleted ?? this.isExperienceProfileCompleted,
        isConferencesProfileCompleted: isConferencesProfileCompleted ?? this.isConferencesProfileCompleted,
        isCertificateProfileCompleted: isCertificateProfileCompleted ?? this.isCertificateProfileCompleted,
        isMembershipProfileCompleted: isMembershipProfileCompleted ?? this.isMembershipProfileCompleted,
        isSpecialitiesProfileCompleted: isSpecialitiesProfileCompleted ?? this.isSpecialitiesProfileCompleted,
        isAchievementsProfileCompleted: isAchievementsProfileCompleted ?? this.isAchievementsProfileCompleted,
        isProfileCompletedForTalHospitals: isProfileCompletedForTalHospitals ?? this.isProfileCompletedForTalHospitals,
        salutation: salutation ?? this.salutation,
        isTalTalksRegistration2024: isTalTalksRegistration2024 ?? this.isTalTalksRegistration2024,
        isBloodDonor: isBloodDonor ?? this.isBloodDonor,
        isPlateletsDonor: isPlateletsDonor ?? this.isPlateletsDonor,
        bloodDonationCategory: bloodDonationCategory ?? this.bloodDonationCategory,
        isBulkUpload: isBulkUpload ?? this.isBulkUpload,
        isFacilityDoctor: isFacilityDoctor ?? this.isFacilityDoctor,
        languagePreferences: languagePreferences ?? this.languagePreferences,
        talLeaderPreferences: talLeaderPreferences ?? this.talLeaderPreferences,
        eventRegistrations: eventRegistrations ?? this.eventRegistrations,
        isTourCompletedForTalLeaders: isTourCompletedForTalLeaders ?? this.isTourCompletedForTalLeaders,
        isTalhospitalVolunteer: isTalhospitalVolunteer ?? this.isTalhospitalVolunteer,
        fcraDocumentStatus: fcraDocumentStatus ?? this.fcraDocumentStatus,
        educationTimelines: educationTimelines ?? this.educationTimelines,
        achievements: achievements ?? this.achievements,
        userComments: userComments ?? this.userComments,
        reviewedBy: reviewedBy ?? this.reviewedBy,
        profileStatus: profileStatus ?? this.profileStatus,
        certificates: certificates ?? this.certificates,
        conferences: conferences ?? this.conferences,
        memberships: memberships ?? this.memberships,
        attendedEvents: attendedEvents ?? this.attendedEvents,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    name: json["name"] == null ? null : Name.fromJson(json["name"]),
    referredDetails: json["referred_details"] == null ? null : ReferredDetails.fromJson(json["referred_details"]),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    billingAddress: json["billingAddress"] == null ? null : Address.fromJson(json["billingAddress"]),
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    socialVerification: json["social_verification"] == null ? null : SocialVerification.fromJson(json["social_verification"]),
    volunteerInfo: json["volunteerInfo"] == null ? null : VolunteerInfo.fromJson(json["volunteerInfo"]),
    mentorInfo: json["mentorInfo"] == null ? null : MentorInfo.fromJson(json["mentorInfo"]),
    establishmentInformation: json["establishmentInformation"] == null ? null : EstablishmentInformation.fromJson(json["establishmentInformation"]),
    volunteerAddress: json["volunteerAddress"] == null ? null : Address.fromJson(json["volunteerAddress"]),
    imageUrl: json["image_url"],
    averageRating: json["averageRating"],
    ratingCount: json["ratingCount"],
    id: json["_id"],
    displayName: json["display_name"],
    username: json["username"],
    email: json["email"],
    emailVerified: json["email_verified"],
    phone: json["phone"],
    phoneVerified: json["phone_verified"],
    summary: json["summary"],
    dob: json["dob"],
    gender: json["gender"],
    isProfileCompleted: json["isProfileCompleted"],
    institutionName: json["institutionName"],
    studentId: json["studentId"],
    institutionUrl: json["institutionUrl"],
    institutionalRole: json["institutionalRole"],
    educationalQualification: json["educationalQualification"],
    accountStatus: json["account_status"],
    accountVerified: json["account_verified"],
    accountDeactivate: json["accountDeactivate"],
    accountDelete: json["accountDelete"],
    kindnessScore: json["kindness_score"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    areasOfInterest: json["areasOfInterest"] == null ? [] : List<String>.from(json["areasOfInterest"]!.map((x) => x)),
    linkedInProfileUrl: json["linkedInProfileUrl"],
    isTourCompleted: json["isTourCompleted"],
    isTourCompletedForTalHospitals: json["isTourCompletedForTalHospitals"],
    isKindnessEventRegistered: json["isKindnessEventRegistered"],
    isKindnessEventRegistered2023: json["isKindnessEventRegistered2023"],
    isHackathonRegistered: json["isHackathonRegistered"],
    totalEmailsPerMonth: json["totalEmailsPerMonth"],
    isMentor: json["isMentor"],
    sourceOfSignup: json["sourceOfSignup"],
    sourceOfDevice: json["sourceOfDevice"],
    languages: json["languages"] == null ? [] : List<dynamic>.from(json["languages"]!.map((x) => x)),
    isAssignMentor: json["isAssignMentor"],
    isTalLeader: json["isTALLeader"],
    personalTraits: json["personalTraits"] == null ? [] : List<dynamic>.from(json["personalTraits"]!.map((x) => x)),
    functionalExpertise: json["functionalExpertise"] == null ? [] : List<dynamic>.from(json["functionalExpertise"]!.map((x) => x)),
    isCertificationDownloaded: json["isCertificationDownloaded"],
    specialities: json["specialities"] == null ? [] : List<dynamic>.from(json["specialities"]!.map((x) => x)),
    categoriesOfInterest: json["categoriesOfInterest"] == null ? [] : List<dynamic>.from(json["categoriesOfInterest"]!.map((x) => x)),
    typeOfHelpAndInvolvement: json["typeOfHelpAndInvolvement"] == null ? [] : List<dynamic>.from(json["typeOfHelpAndInvolvement"]!.map((x) => x)),
    interestedTypeOfOrgs: json["interestedTypeOfOrgs"] == null ? [] : List<dynamic>.from(json["interestedTypeOfOrgs"]!.map((x) => x)),
    interestedRegions: json["interestedRegions"] == null ? [] : List<dynamic>.from(json["interestedRegions"]!.map((x) => x)),
    profileVerificationStatus: json["profileVerificationStatus"],
    experience: json["experience"] == null ? [] : List<dynamic>.from(json["experience"]!.map((x) => x)),
    howDidYouHear: json["howDidYouHear"],
    referenceName: json["referenceName"],
    oneHourPerWeek: json["oneHourPerWeek"],
    managementPosition: json["managementPosition"],
    serveAndMakeImpact: json["serveAndMakeImpact"],
    currentRole: json["currentRole"],
    currentCompanyName: json["currentCompanyName"],
    userLikes: json["userLikes"] == null ? [] : List<UserLike>.from(json["userLikes"]!.map((x) => UserLike.fromJson(x))),
    acceptedTermsAndConditions: json["acceptedTermsAndConditions"],
    notes: json["notes"],
    takingMedication: json["takingMedication"],
    anyAllergies: json["anyAllergies"],
    outOfCountryTravel12Months: json["outOfCountryTravel12months"],
    bloodRequirementAlerts: json["bloodRequirementAlerts"],
    isPaidBootcamp: json["isPaidBootcamp"],
    educationInUkOrUs: json["educationInUKOrUS"] == null ? [] : List<dynamic>.from(json["educationInUKOrUS"]!.map((x) => x)),
    experienceInUkOrUs: json["experienceInUKOrUS"],
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
    isTalTalksRegistration2024: json["isTalTalksRegistration2024"],
    isBloodDonor: json["isBloodDonor"],
    isPlateletsDonor: json["isPlateletsDonor"],
    bloodDonationCategory: json["bloodDonationCategory"] == null ? [] : List<dynamic>.from(json["bloodDonationCategory"]!.map((x) => x)),
    isBulkUpload: json["isBulkUpload"],
    isFacilityDoctor: json["isFacilityDoctor"],
    languagePreferences: json["languagePreferences"] == null ? [] : List<dynamic>.from(json["languagePreferences"]!.map((x) => x)),
    talLeaderPreferences: json["talLeaderPreferences"] == null ? [] : List<dynamic>.from(json["talLeaderPreferences"]!.map((x) => x)),
    eventRegistrations: json["eventRegistrations"] == null ? [] : List<dynamic>.from(json["eventRegistrations"]!.map((x) => x)),
    isTourCompletedForTalLeaders: json["isTourCompletedForTalLeaders"],
    isTalhospitalVolunteer: json["isTalhospitalVolunteer"],
    fcraDocumentStatus: json["fcraDocumentStatus"],
    educationTimelines: json["educationTimelines"] == null ? [] : List<dynamic>.from(json["educationTimelines"]!.map((x) => x)),
    achievements: json["achievements"] == null ? [] : List<dynamic>.from(json["achievements"]!.map((x) => x)),
    userComments: json["userComments"] == null ? [] : List<dynamic>.from(json["userComments"]!.map((x) => x)),
    reviewedBy: json["reviewedBy"] == null ? [] : List<dynamic>.from(json["reviewedBy"]!.map((x) => x)),
    profileStatus: json["profileStatus"] == null ? [] : List<dynamic>.from(json["profileStatus"]!.map((x) => x)),
    certificates: json["certificates"] == null ? [] : List<dynamic>.from(json["certificates"]!.map((x) => x)),
    conferences: json["conferences"] == null ? [] : List<dynamic>.from(json["conferences"]!.map((x) => x)),
    memberships: json["memberships"] == null ? [] : List<dynamic>.from(json["memberships"]!.map((x) => x)),
    attendedEvents: json["attendedEvents"] == null ? [] : List<dynamic>.from(json["attendedEvents"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name?.toJson(),
    "referred_details": referredDetails?.toJson(),
    "address": address?.toJson(),
    "billingAddress": billingAddress?.toJson(),
    "location": location?.toJson(),
    "social_verification": socialVerification?.toJson(),
    "volunteerInfo": volunteerInfo?.toJson(),
    "mentorInfo": mentorInfo?.toJson(),
    "establishmentInformation": establishmentInformation?.toJson(),
    "volunteerAddress": volunteerAddress?.toJson(),
    "image_url": imageUrl,
    "averageRating": averageRating,
    "ratingCount": ratingCount,
    "_id": id,
    "display_name": displayName,
    "username": username,
    "email": email,
    "email_verified": emailVerified,
    "phone": phone,
    "phone_verified": phoneVerified,
    "summary": summary,
    "dob": dob,
    "gender": gender,
    "isProfileCompleted": isProfileCompleted,
    "institutionName": institutionName,
    "studentId": studentId,
    "institutionUrl": institutionUrl,
    "institutionalRole": institutionalRole,
    "educationalQualification": educationalQualification,
    "account_status": accountStatus,
    "account_verified": accountVerified,
    "accountDeactivate": accountDeactivate,
    "accountDelete": accountDelete,
    "kindness_score": kindnessScore,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "areasOfInterest": areasOfInterest == null ? [] : List<dynamic>.from(areasOfInterest!.map((x) => x)),
    "linkedInProfileUrl": linkedInProfileUrl,
    "isTourCompleted": isTourCompleted,
    "isTourCompletedForTalHospitals": isTourCompletedForTalHospitals,
    "isKindnessEventRegistered": isKindnessEventRegistered,
    "isKindnessEventRegistered2023": isKindnessEventRegistered2023,
    "isHackathonRegistered": isHackathonRegistered,
    "totalEmailsPerMonth": totalEmailsPerMonth,
    "isMentor": isMentor,
    "sourceOfSignup": sourceOfSignup,
    "sourceOfDevice": sourceOfDevice,
    "languages": languages == null ? [] : List<dynamic>.from(languages!.map((x) => x)),
    "isAssignMentor": isAssignMentor,
    "isTALLeader": isTalLeader,
    "personalTraits": personalTraits == null ? [] : List<dynamic>.from(personalTraits!.map((x) => x)),
    "functionalExpertise": functionalExpertise == null ? [] : List<dynamic>.from(functionalExpertise!.map((x) => x)),
    "isCertificationDownloaded": isCertificationDownloaded,
    "specialities": specialities == null ? [] : List<dynamic>.from(specialities!.map((x) => x)),
    "categoriesOfInterest": categoriesOfInterest == null ? [] : List<dynamic>.from(categoriesOfInterest!.map((x) => x)),
    "typeOfHelpAndInvolvement": typeOfHelpAndInvolvement == null ? [] : List<dynamic>.from(typeOfHelpAndInvolvement!.map((x) => x)),
    "interestedTypeOfOrgs": interestedTypeOfOrgs == null ? [] : List<dynamic>.from(interestedTypeOfOrgs!.map((x) => x)),
    "interestedRegions": interestedRegions == null ? [] : List<dynamic>.from(interestedRegions!.map((x) => x)),
    "profileVerificationStatus": profileVerificationStatus,
    "experience": experience == null ? [] : List<dynamic>.from(experience!.map((x) => x)),
    "howDidYouHear": howDidYouHear,
    "referenceName": referenceName,
    "oneHourPerWeek": oneHourPerWeek,
    "managementPosition": managementPosition,
    "serveAndMakeImpact": serveAndMakeImpact,
    "currentRole": currentRole,
    "currentCompanyName": currentCompanyName,
    "userLikes": userLikes == null ? [] : List<dynamic>.from(userLikes!.map((x) => x.toJson())),
    "acceptedTermsAndConditions": acceptedTermsAndConditions,
    "notes": notes,
    "takingMedication": takingMedication,
    "anyAllergies": anyAllergies,
    "outOfCountryTravel12months": outOfCountryTravel12Months,
    "bloodRequirementAlerts": bloodRequirementAlerts,
    "isPaidBootcamp": isPaidBootcamp,
    "educationInUKOrUS": educationInUkOrUs == null ? [] : List<dynamic>.from(educationInUkOrUs!.map((x) => x)),
    "experienceInUKOrUS": experienceInUkOrUs,
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
    "isTalTalksRegistration2024": isTalTalksRegistration2024,
    "isBloodDonor": isBloodDonor,
    "isPlateletsDonor": isPlateletsDonor,
    "bloodDonationCategory": bloodDonationCategory == null ? [] : List<dynamic>.from(bloodDonationCategory!.map((x) => x)),
    "isBulkUpload": isBulkUpload,
    "isFacilityDoctor": isFacilityDoctor,
    "languagePreferences": languagePreferences == null ? [] : List<dynamic>.from(languagePreferences!.map((x) => x)),
    "talLeaderPreferences": talLeaderPreferences == null ? [] : List<dynamic>.from(talLeaderPreferences!.map((x) => x)),
    "eventRegistrations": eventRegistrations == null ? [] : List<dynamic>.from(eventRegistrations!.map((x) => x)),
    "isTourCompletedForTalLeaders": isTourCompletedForTalLeaders,
    "isTalhospitalVolunteer": isTalhospitalVolunteer,
    "fcraDocumentStatus": fcraDocumentStatus,
    "educationTimelines": educationTimelines == null ? [] : List<dynamic>.from(educationTimelines!.map((x) => x)),
    "achievements": achievements == null ? [] : List<dynamic>.from(achievements!.map((x) => x)),
    "userComments": userComments == null ? [] : List<dynamic>.from(userComments!.map((x) => x)),
    "reviewedBy": reviewedBy == null ? [] : List<dynamic>.from(reviewedBy!.map((x) => x)),
    "profileStatus": profileStatus == null ? [] : List<dynamic>.from(profileStatus!.map((x) => x)),
    "certificates": certificates == null ? [] : List<dynamic>.from(certificates!.map((x) => x)),
    "conferences": conferences == null ? [] : List<dynamic>.from(conferences!.map((x) => x)),
    "memberships": memberships == null ? [] : List<dynamic>.from(memberships!.map((x) => x)),
    "attendedEvents": attendedEvents == null ? [] : List<dynamic>.from(attendedEvents!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Address {
  final String? city;
  final String? state;
  final String? country;
  final String? line1;
  final String? line2;
  final dynamic locality;
  final String? district;
  final String? mandal;
  final String? village;
  final String? zipCode;

  Address({
    this.city,
    this.state,
    this.country,
    this.line1,
    this.line2,
    this.locality,
    this.district,
    this.mandal,
    this.village,
    this.zipCode,
  });

  Address copyWith({
    String? city,
    String? state,
    String? country,
    String? line1,
    String? line2,
    dynamic locality,
    String? district,
    String? mandal,
    String? village,
    String? zipCode,
  }) =>
      Address(
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        line1: line1 ?? this.line1,
        line2: line2 ?? this.line2,
        locality: locality ?? this.locality,
        district: district ?? this.district,
        mandal: mandal ?? this.mandal,
        village: village ?? this.village,
        zipCode: zipCode ?? this.zipCode,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    city: json["city"],
    state: json["state"],
    country: json["country"],
    line1: json["line1"],
    line2: json["line2"],
    locality: json["locality"],
    district: json["district"],
    mandal: json["mandal"],
    village: json["village"],
    zipCode: json["zip_code"],
  );

  Map<String, dynamic> toJson() => {
    "city": city,
    "state": state,
    "country": country,
    "line1": line1,
    "line2": line2,
    "locality": locality,
    "district": district,
    "mandal": mandal,
    "village": village,
    "zip_code": zipCode,
  };
}

class EstablishmentInformation {
  final String? line1;
  final String? line2;
  final String? city;
  final String? state;
  final String? country;
  final String? zipCode;

  EstablishmentInformation({
    this.line1,
    this.line2,
    this.city,
    this.state,
    this.country,
    this.zipCode,
  });

  EstablishmentInformation copyWith({
    String? line1,
    String? line2,
    String? city,
    String? state,
    String? country,
    String? zipCode,
  }) =>
      EstablishmentInformation(
        line1: line1 ?? this.line1,
        line2: line2 ?? this.line2,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
        zipCode: zipCode ?? this.zipCode,
      );

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

class Location {
  final String? type;
  final List<dynamic>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  Location copyWith({
    String? type,
    List<dynamic>? coordinates,
  }) =>
      Location(
        type: type ?? this.type,
        coordinates: coordinates ?? this.coordinates,
      );

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<dynamic>.from(json["coordinates"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
  };
}

class MentorInfo {
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;
  final String? organization;
  final String? organizationWebsite;
  final String? educationalQualification;

  MentorInfo({
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.organization,
    this.organizationWebsite,
    this.educationalQualification,
  });

  MentorInfo copyWith({
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? organization,
    String? organizationWebsite,
    String? educationalQualification,
  }) =>
      MentorInfo(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        organization: organization ?? this.organization,
        organizationWebsite: organizationWebsite ?? this.organizationWebsite,
        educationalQualification: educationalQualification ?? this.educationalQualification,
      );

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
  final String? firstName;
  final String? middleName;
  final String? lastName;

  Name({
    this.firstName,
    this.middleName,
    this.lastName,
  });

  Name copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
  }) =>
      Name(
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
      );

  factory Name.fromJson(Map<String, dynamic> json) => Name(
    firstName: json["first_name"],
    middleName: json["middle_name"],
    lastName: json["last_name"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
  };
}

class ReferredDetails {
  final String? referredById;
  final String? referredByCode;
  final String? referredByCategory;

  ReferredDetails({
    this.referredById,
    this.referredByCode,
    this.referredByCategory,
  });

  ReferredDetails copyWith({
    String? referredById,
    String? referredByCode,
    String? referredByCategory,
  }) =>
      ReferredDetails(
        referredById: referredById ?? this.referredById,
        referredByCode: referredByCode ?? this.referredByCode,
        referredByCategory: referredByCategory ?? this.referredByCategory,
      );

  factory ReferredDetails.fromJson(Map<String, dynamic> json) => ReferredDetails(
    referredById: json["referred_by_id"],
    referredByCode: json["referred_by_code"],
    referredByCategory: json["referred_by_category"],
  );

  Map<String, dynamic> toJson() => {
    "referred_by_id": referredById,
    "referred_by_code": referredByCode,
    "referred_by_category": referredByCategory,
  };
}

class SocialVerification {
  final bool? googleVerified;
  final bool? facebookVerified;
  final bool? linkedinVerified;
  final bool? twitterVerified;
  final bool? appleVerified;

  SocialVerification({
    this.googleVerified,
    this.facebookVerified,
    this.linkedinVerified,
    this.twitterVerified,
    this.appleVerified,
  });

  SocialVerification copyWith({
    bool? googleVerified,
    bool? facebookVerified,
    bool? linkedinVerified,
    bool? twitterVerified,
    bool? appleVerified,
  }) =>
      SocialVerification(
        googleVerified: googleVerified ?? this.googleVerified,
        facebookVerified: facebookVerified ?? this.facebookVerified,
        linkedinVerified: linkedinVerified ?? this.linkedinVerified,
        twitterVerified: twitterVerified ?? this.twitterVerified,
        appleVerified: appleVerified ?? this.appleVerified,
      );

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

class UserLike {
  final Name? name;
  final Address? address;
  final String? id;
  final String? displayName;
  final String? username;
  final String? email;
  final String? phone;
  final String? imageUrl;
  final String? studentId;
  final bool? isTalLeader;
  final String? currentRole;
  final String? currentCompanyName;

  UserLike({
    this.name,
    this.address,
    this.id,
    this.displayName,
    this.username,
    this.email,
    this.phone,
    this.imageUrl,
    this.studentId,
    this.isTalLeader,
    this.currentRole,
    this.currentCompanyName,
  });

  UserLike copyWith({
    Name? name,
    Address? address,
    String? id,
    String? displayName,
    String? username,
    String? email,
    String? phone,
    String? imageUrl,
    String? studentId,
    bool? isTalLeader,
    String? currentRole,
    String? currentCompanyName,
  }) =>
      UserLike(
        name: name ?? this.name,
        address: address ?? this.address,
        id: id ?? this.id,
        displayName: displayName ?? this.displayName,
        username: username ?? this.username,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        imageUrl: imageUrl ?? this.imageUrl,
        studentId: studentId ?? this.studentId,
        isTalLeader: isTalLeader ?? this.isTalLeader,
        currentRole: currentRole ?? this.currentRole,
        currentCompanyName: currentCompanyName ?? this.currentCompanyName,
      );

  factory UserLike.fromJson(Map<String, dynamic> json) => UserLike(
    name: json["name"] == null ? null : Name.fromJson(json["name"]),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    id: json["_id"],
    displayName: json["display_name"],
    username: json["username"],
    email: json["email"],
    phone: json["phone"],
    imageUrl: json["image_url"],
    studentId: json["studentId"],
    isTalLeader: json["isTALLeader"],
    currentRole: json["currentRole"],
    currentCompanyName: json["currentCompanyName"],
  );

  Map<String, dynamic> toJson() => {
    "name": name?.toJson(),
    "address": address?.toJson(),
    "_id": id,
    "display_name": displayName,
    "username": username,
    "email": email,
    "phone": phone,
    "image_url": imageUrl,
    "studentId": studentId,
    "isTALLeader": isTalLeader,
    "currentRole": currentRole,
    "currentCompanyName": currentCompanyName,
  };
}

class VolunteerInfo {
  final bool? isInterested;

  VolunteerInfo({
    this.isInterested,
  });

  VolunteerInfo copyWith({
    bool? isInterested,
  }) =>
      VolunteerInfo(
        isInterested: isInterested ?? this.isInterested,
      );

  factory VolunteerInfo.fromJson(Map<String, dynamic> json) => VolunteerInfo(
    isInterested: json["isInterested"],
  );

  Map<String, dynamic> toJson() => {
    "isInterested": isInterested,
  };
}
