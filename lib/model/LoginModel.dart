// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

import 'achievement.dart';
import 'experience_model.dart';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String? status;
  final int? statusCode;
  final String? message;
  final Data? data;

  LoginModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  LoginModel copyWith({
    String? status,
    int? statusCode,
    String? message,
    Data? data,
  }) =>
      LoginModel(
        status: status ?? this.status,
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

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
  final String? uniqueId;
  final String? email;
  final String? phone;
  final String? username;
  final String? displayName;
  final Name? name;
  final String? profileImageUrl;
  final bool? accountVerified;
  final int? accountStatus;
  final bool? passwordVerified;
  final String? loginProvider;
  final bool? emailVerified;
  final bool? phoneVerified;
  final Address? address;
  final List<String>? roles;
  final SocialVerification? socialVerification;
  final TokenDetail? tokenDetail;
  final String? summary;
  final String? gender;
  final int? dob;
  final String? stripeCustomerId;
  final int? kindnessScore;
  final VolunteerInfo? volunteerInfo;
  final String? coverImageUrl;
  final int? rating;
  final String? facebookProfileUrl;
  final String? twitterProfileUrl;
  final String? linkedInProfileUrl;
  final String? title;
  final String? aboutMe;
  final bool? isTourCompleted;
  final bool? isKindnessEventRegistered;
  final String? occupation;
  final String? organization;
  final int? yearsOfExperience;
  final bool? isHackathonRegistered;
  final Address? billingAddress;
  final int? totalEmailsPerMonth;
  final bool? isMentor;
  final List<String>? languages;
  final bool? isProfileCompleted;
  final String? institutionName;
  final String? studentId;
  final String? institutionUrl;
  final String? institutionalRole;
  final String? educationalQualification;
  final String? educationalQualificationOthers;
  final MentorInfo? mentorInfo;
  final bool? isAssignMentor;
  final String? defaultChannel;
  final String? sourceOfSignup;
  final List<String>? personalTraits;
  final List<String>? functionalExpertise;
  final bool? isTalLeader;
  final List<String>? areasOfInterest;
  final bool? isCertificationDownloaded;
  final MedicalRegistration? medicalRegistration;
  final EstablishmentInformation? establishmentInformation;
  final List<String>? specialities;
  final List<String>? categoriesOfInterest;
  final List<String>? typeOfHelpAndInvolvement;
  final int? hoursPerMonth;
  final List<String>? interestedTypeOfOrgs;
  final List<String>? interestedRegions;
  final int? profileVerificationStatus;
  final String? referralCode;
  final List<dynamic>? educationTimelines;
  final List<Experience>? experience;
  final List<Conference>? conferences;
  final List<Certificate>? certificates;
  final List<Membership>? memberships;
  final List<Achievement>? achievements;
  final String? aadhaar;
  final String? pan;
  final bool? oneHourPerWeek;
  final bool? managementPosition;
  final String? currentRole;
  final String? currentCompanyName;
  final List<dynamic>? userComments;
  final List<String>? userLikes;
  final String? professionalExperience;
  final Location? location;
  final bool? acceptedTermsAndConditions;
  final dynamic ipAddress;
  final List<dynamic>? reviewedBy;
  final dynamic notes;
  final String? bloodGroup;
  final bool? isDonatedBefore;
  final int? noOfTimesDonated;
  final int? lastDonatedDate;
  final bool? isTransmissibleDiseaseHistory;
  final String? transmissibleDiseaseHistory;
  final bool? bloodRequirementAlerts;
  final bool? researchParticipationInterest;
  final String? sourceOfDevice;
  final bool? isPaidBootcamp;
  final bool? isKindnessEventRegistered2023;
  final String? userRegistrationCategory;
  final List<dynamic>? educationInUkOrUs;
  final dynamic experienceInUkOrUs;
  final String? defaultHomePage;
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
  final bool? isBloodDonor;
  final bool? isPlateletsDonor;
  final List<String>? bloodDonationCategory;
  final bool? takingMedication;
  final bool? anyAllergies;
  final bool? outOfCountryTravel12Months;
  final String? countriesVisited;
  final bool? isBulkUpload;
  final bool? isTourCompletedForTalHospitals;
  final Address? volunteerAddress;
  final String? allergies;
  final String? medication;
  final dynamic hideProfileCategory;
  final dynamic hideProfileReason;
  final dynamic hideProfileEndDate;
  final List<String>? languagePreferences;
  final int? userNameUpdatedAt;
  final List<String>? eventRegistrations;
  final bool? isTourCompletedForTalLeaders;
  final int? noOfCampaignsCreated;
  final int? noOfLivesImpacted;
  final List<String>? talLeaderPreferences;
  final int? weight;
  final List<ProfileStatus>? profileStatus;
  final bool? isTalhospitalVolunteer;
  final int? fcraDocumentStatus;
  final int? ratingCount;
  final int? averageRating;

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
    this.hoursPerMonth,
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
    this.researchParticipationInterest,
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
    this.weight,
    this.profileStatus,
    this.isTalhospitalVolunteer,
    this.fcraDocumentStatus,
    this.ratingCount,
    this.averageRating,
  });

  Data copyWith({
    String? uniqueId,
    String? email,
    String? phone,
    String? username,
    String? displayName,
    Name? name,
    String? profileImageUrl,
    bool? accountVerified,
    int? accountStatus,
    bool? passwordVerified,
    String? loginProvider,
    bool? emailVerified,
    bool? phoneVerified,
    Address? address,
    List<String>? roles,
    SocialVerification? socialVerification,
    TokenDetail? tokenDetail,
    String? summary,
    String? gender,
    int? dob,
    String? stripeCustomerId,
    int? kindnessScore,
    VolunteerInfo? volunteerInfo,
    String? coverImageUrl,
    int? rating,
    String? facebookProfileUrl,
    String? twitterProfileUrl,
    String? linkedInProfileUrl,
    String? title,
    String? aboutMe,
    bool? isTourCompleted,
    bool? isKindnessEventRegistered,
    String? occupation,
    String? organization,
    int? yearsOfExperience,
    bool? isHackathonRegistered,
    Address? billingAddress,
    int? totalEmailsPerMonth,
    bool? isMentor,
    List<String>? languages,
    bool? isProfileCompleted,
    String? institutionName,
    String? studentId,
    String? institutionUrl,
    String? institutionalRole,
    String? educationalQualification,
    String? educationalQualificationOthers,
    MentorInfo? mentorInfo,
    bool? isAssignMentor,
    String? defaultChannel,
    String? sourceOfSignup,
    List<String>? personalTraits,
    List<String>? functionalExpertise,
    bool? isTalLeader,
    List<String>? areasOfInterest,
    bool? isCertificationDownloaded,
    MedicalRegistration? medicalRegistration,
    EstablishmentInformation? establishmentInformation,
    List<String>? specialities,
    List<String>? categoriesOfInterest,
    List<String>? typeOfHelpAndInvolvement,
    int? hoursPerMonth,
    List<String>? interestedTypeOfOrgs,
    List<String>? interestedRegions,
    int? profileVerificationStatus,
    String? referralCode,
    List<dynamic>? educationTimelines,
    List<Experience>? experience,
    List<Conference>? conferences,
    List<Certificate>? certificates,
    List<Membership>? memberships,
    List<Achievement>? achievements,
    String? aadhaar,
    String? pan,
    bool? oneHourPerWeek,
    bool? managementPosition,
    String? currentRole,
    String? currentCompanyName,
    List<dynamic>? userComments,
    List<String>? userLikes,
    String? professionalExperience,
    Location? location,
    bool? acceptedTermsAndConditions,
    dynamic ipAddress,
    List<dynamic>? reviewedBy,
    dynamic notes,
    String? bloodGroup,
    bool? isDonatedBefore,
    int? noOfTimesDonated,
    int? lastDonatedDate,
    bool? isTransmissibleDiseaseHistory,
    String? transmissibleDiseaseHistory,
    bool? bloodRequirementAlerts,
    bool? researchParticipationInterest,
    String? sourceOfDevice,
    bool? isPaidBootcamp,
    bool? isKindnessEventRegistered2023,
    String? userRegistrationCategory,
    List<dynamic>? educationInUkOrUs,
    dynamic experienceInUkOrUs,
    String? defaultHomePage,
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
    bool? isBloodDonor,
    bool? isPlateletsDonor,
    List<String>? bloodDonationCategory,
    bool? takingMedication,
    bool? anyAllergies,
    bool? outOfCountryTravel12Months,
    String? countriesVisited,
    bool? isBulkUpload,
    bool? isTourCompletedForTalHospitals,
    Address? volunteerAddress,
    String? allergies,
    String? medication,
    dynamic hideProfileCategory,
    dynamic hideProfileReason,
    dynamic hideProfileEndDate,
    List<String>? languagePreferences,
    int? userNameUpdatedAt,
    List<String>? eventRegistrations,
    bool? isTourCompletedForTalLeaders,
    int? noOfCampaignsCreated,
    int? noOfLivesImpacted,
    List<String>? talLeaderPreferences,
    int? weight,
    List<ProfileStatus>? profileStatus,
    bool? isTalhospitalVolunteer,
    int? fcraDocumentStatus,
    int? ratingCount,
    int? averageRating,
  }) =>
      Data(
        uniqueId: uniqueId ?? this.uniqueId,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        username: username ?? this.username,
        displayName: displayName ?? this.displayName,
        name: name ?? this.name,
        profileImageUrl: profileImageUrl ?? this.profileImageUrl,
        accountVerified: accountVerified ?? this.accountVerified,
        accountStatus: accountStatus ?? this.accountStatus,
        passwordVerified: passwordVerified ?? this.passwordVerified,
        loginProvider: loginProvider ?? this.loginProvider,
        emailVerified: emailVerified ?? this.emailVerified,
        phoneVerified: phoneVerified ?? this.phoneVerified,
        address: address ?? this.address,
        roles: roles ?? this.roles,
        socialVerification: socialVerification ?? this.socialVerification,
        tokenDetail: tokenDetail ?? this.tokenDetail,
        summary: summary ?? this.summary,
        gender: gender ?? this.gender,
        dob: dob ?? this.dob,
        stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
        kindnessScore: kindnessScore ?? this.kindnessScore,
        volunteerInfo: volunteerInfo ?? this.volunteerInfo,
        coverImageUrl: coverImageUrl ?? this.coverImageUrl,
        rating: rating ?? this.rating,
        facebookProfileUrl: facebookProfileUrl ?? this.facebookProfileUrl,
        twitterProfileUrl: twitterProfileUrl ?? this.twitterProfileUrl,
        linkedInProfileUrl: linkedInProfileUrl ?? this.linkedInProfileUrl,
        title: title ?? this.title,
        aboutMe: aboutMe ?? this.aboutMe,
        isTourCompleted: isTourCompleted ?? this.isTourCompleted,
        isKindnessEventRegistered: isKindnessEventRegistered ?? this.isKindnessEventRegistered,
        occupation: occupation ?? this.occupation,
        organization: organization ?? this.organization,
        yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
        isHackathonRegistered: isHackathonRegistered ?? this.isHackathonRegistered,
        billingAddress: billingAddress ?? this.billingAddress,
        totalEmailsPerMonth: totalEmailsPerMonth ?? this.totalEmailsPerMonth,
        isMentor: isMentor ?? this.isMentor,
        languages: languages ?? this.languages,
        isProfileCompleted: isProfileCompleted ?? this.isProfileCompleted,
        institutionName: institutionName ?? this.institutionName,
        studentId: studentId ?? this.studentId,
        institutionUrl: institutionUrl ?? this.institutionUrl,
        institutionalRole: institutionalRole ?? this.institutionalRole,
        educationalQualification: educationalQualification ?? this.educationalQualification,
        educationalQualificationOthers: educationalQualificationOthers ?? this.educationalQualificationOthers,
        mentorInfo: mentorInfo ?? this.mentorInfo,
        isAssignMentor: isAssignMentor ?? this.isAssignMentor,
        defaultChannel: defaultChannel ?? this.defaultChannel,
        sourceOfSignup: sourceOfSignup ?? this.sourceOfSignup,
        personalTraits: personalTraits ?? this.personalTraits,
        functionalExpertise: functionalExpertise ?? this.functionalExpertise,
        isTalLeader: isTalLeader ?? this.isTalLeader,
        areasOfInterest: areasOfInterest ?? this.areasOfInterest,
        isCertificationDownloaded: isCertificationDownloaded ?? this.isCertificationDownloaded,
        medicalRegistration: medicalRegistration ?? this.medicalRegistration,
        establishmentInformation: establishmentInformation ?? this.establishmentInformation,
        specialities: specialities ?? this.specialities,
        categoriesOfInterest: categoriesOfInterest ?? this.categoriesOfInterest,
        typeOfHelpAndInvolvement: typeOfHelpAndInvolvement ?? this.typeOfHelpAndInvolvement,
        hoursPerMonth: hoursPerMonth ?? this.hoursPerMonth,
        interestedTypeOfOrgs: interestedTypeOfOrgs ?? this.interestedTypeOfOrgs,
        interestedRegions: interestedRegions ?? this.interestedRegions,
        profileVerificationStatus: profileVerificationStatus ?? this.profileVerificationStatus,
        referralCode: referralCode ?? this.referralCode,
        educationTimelines: educationTimelines ?? this.educationTimelines,
        experience: experience ?? this.experience,
        conferences: conferences ?? this.conferences,
        certificates: certificates ?? this.certificates,
        memberships: memberships ?? this.memberships,
        achievements: achievements ?? this.achievements,
        aadhaar: aadhaar ?? this.aadhaar,
        pan: pan ?? this.pan,
        oneHourPerWeek: oneHourPerWeek ?? this.oneHourPerWeek,
        managementPosition: managementPosition ?? this.managementPosition,
        currentRole: currentRole ?? this.currentRole,
        currentCompanyName: currentCompanyName ?? this.currentCompanyName,
        userComments: userComments ?? this.userComments,
        userLikes: userLikes ?? this.userLikes,
        professionalExperience: professionalExperience ?? this.professionalExperience,
        location: location ?? this.location,
        acceptedTermsAndConditions: acceptedTermsAndConditions ?? this.acceptedTermsAndConditions,
        ipAddress: ipAddress ?? this.ipAddress,
        reviewedBy: reviewedBy ?? this.reviewedBy,
        notes: notes ?? this.notes,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        isDonatedBefore: isDonatedBefore ?? this.isDonatedBefore,
        noOfTimesDonated: noOfTimesDonated ?? this.noOfTimesDonated,
        lastDonatedDate: lastDonatedDate ?? this.lastDonatedDate,
        isTransmissibleDiseaseHistory: isTransmissibleDiseaseHistory ?? this.isTransmissibleDiseaseHistory,
        transmissibleDiseaseHistory: transmissibleDiseaseHistory ?? this.transmissibleDiseaseHistory,
        bloodRequirementAlerts: bloodRequirementAlerts ?? this.bloodRequirementAlerts,
        researchParticipationInterest: researchParticipationInterest ?? this.researchParticipationInterest,
        sourceOfDevice: sourceOfDevice ?? this.sourceOfDevice,
        isPaidBootcamp: isPaidBootcamp ?? this.isPaidBootcamp,
        isKindnessEventRegistered2023: isKindnessEventRegistered2023 ?? this.isKindnessEventRegistered2023,
        userRegistrationCategory: userRegistrationCategory ?? this.userRegistrationCategory,
        educationInUkOrUs: educationInUkOrUs ?? this.educationInUkOrUs,
        experienceInUkOrUs: experienceInUkOrUs ?? this.experienceInUkOrUs,
        defaultHomePage: defaultHomePage ?? this.defaultHomePage,
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
        isBloodDonor: isBloodDonor ?? this.isBloodDonor,
        isPlateletsDonor: isPlateletsDonor ?? this.isPlateletsDonor,
        bloodDonationCategory: bloodDonationCategory ?? this.bloodDonationCategory,
        takingMedication: takingMedication ?? this.takingMedication,
        anyAllergies: anyAllergies ?? this.anyAllergies,
        outOfCountryTravel12Months: outOfCountryTravel12Months ?? this.outOfCountryTravel12Months,
        countriesVisited: countriesVisited ?? this.countriesVisited,
        isBulkUpload: isBulkUpload ?? this.isBulkUpload,
        isTourCompletedForTalHospitals: isTourCompletedForTalHospitals ?? this.isTourCompletedForTalHospitals,
        volunteerAddress: volunteerAddress ?? this.volunteerAddress,
        allergies: allergies ?? this.allergies,
        medication: medication ?? this.medication,
        hideProfileCategory: hideProfileCategory ?? this.hideProfileCategory,
        hideProfileReason: hideProfileReason ?? this.hideProfileReason,
        hideProfileEndDate: hideProfileEndDate ?? this.hideProfileEndDate,
        languagePreferences: languagePreferences ?? this.languagePreferences,
        userNameUpdatedAt: userNameUpdatedAt ?? this.userNameUpdatedAt,
        eventRegistrations: eventRegistrations ?? this.eventRegistrations,
        isTourCompletedForTalLeaders: isTourCompletedForTalLeaders ?? this.isTourCompletedForTalLeaders,
        noOfCampaignsCreated: noOfCampaignsCreated ?? this.noOfCampaignsCreated,
        noOfLivesImpacted: noOfLivesImpacted ?? this.noOfLivesImpacted,
        talLeaderPreferences: talLeaderPreferences ?? this.talLeaderPreferences,
        weight: weight ?? this.weight,
        profileStatus: profileStatus ?? this.profileStatus,
        isTalhospitalVolunteer: isTalhospitalVolunteer ?? this.isTalhospitalVolunteer,
        fcraDocumentStatus: fcraDocumentStatus ?? this.fcraDocumentStatus,
        ratingCount: ratingCount ?? this.ratingCount,
        averageRating: averageRating ?? this.averageRating,
      );

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
    typeOfHelpAndInvolvement: json["typeOfHelpAndInvolvement"] == null ? [] : List<String>.from(json["typeOfHelpAndInvolvement"]!.map((x) => x)),
    hoursPerMonth: json["hoursPerMonth"],
    interestedTypeOfOrgs: json["interestedTypeOfOrgs"] == null ? [] : List<String>.from(json["interestedTypeOfOrgs"]!.map((x) => x)),
    interestedRegions: json["interestedRegions"] == null ? [] : List<String>.from(json["interestedRegions"]!.map((x) => x)),
    profileVerificationStatus: json["profileVerificationStatus"],
    referralCode: json["referral_code"],
    educationTimelines: json["educationTimelines"] == null ? [] : List<dynamic>.from(json["educationTimelines"]!.map((x) => x)),
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
    researchParticipationInterest: json["researchParticipationInterest"],
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
    weight: json["weight"],
    profileStatus: json["profileStatus"] == null ? [] : List<ProfileStatus>.from(json["profileStatus"]!.map((x) => ProfileStatus.fromJson(x))),
    isTalhospitalVolunteer: json["isTalhospitalVolunteer"],
    fcraDocumentStatus: json["fcraDocumentStatus"],
    ratingCount: json["ratingCount"],
    averageRating: json["averageRating"],
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
    "hoursPerMonth": hoursPerMonth,
    "interestedTypeOfOrgs": interestedTypeOfOrgs == null ? [] : List<dynamic>.from(interestedTypeOfOrgs!.map((x) => x)),
    "interestedRegions": interestedRegions == null ? [] : List<dynamic>.from(interestedRegions!.map((x) => x)),
    "profileVerificationStatus": profileVerificationStatus,
    "referral_code": referralCode,
    "educationTimelines": educationTimelines == null ? [] : List<dynamic>.from(educationTimelines!.map((x) => x)),
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
    "researchParticipationInterest": researchParticipationInterest,
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
    "weight": weight,
    "profileStatus": profileStatus == null ? [] : List<dynamic>.from(profileStatus!.map((x) => x.toJson())),
    "isTalhospitalVolunteer": isTalhospitalVolunteer,
    "fcraDocumentStatus": fcraDocumentStatus,
    "ratingCount": ratingCount,
    "averageRating": averageRating,
  };
}


class Address {
  final String? line1;
  final String? line2;
  final dynamic locality;
  final String? district;
  final String? mandal;
  final String? village;
  final String? zipCode;
  final String? city;
  final String? state;
  final String? country;

  Address({
    this.line1,
    this.line2,
    this.locality,
    this.district,
    this.mandal,
    this.village,
    this.zipCode,
    this.city,
    this.state,
    this.country,
  });

  Address copyWith({
    String? line1,
    String? line2,
    dynamic locality,
    String? district,
    String? mandal,
    String? village,
    String? zipCode,
    String? city,
    String? state,
    String? country,
  }) =>
      Address(
        line1: line1 ?? this.line1,
        line2: line2 ?? this.line2,
        locality: locality ?? this.locality,
        district: district ?? this.district,
        mandal: mandal ?? this.mandal,
        village: village ?? this.village,
        zipCode: zipCode ?? this.zipCode,
        city: city ?? this.city,
        state: state ?? this.state,
        country: country ?? this.country,
      );

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    line1: json["line1"],
    line2: json["line2"],
    locality: json["locality"],
    district: json["district"],
    mandal: json["mandal"],
    village: json["village"],
    zipCode: json["zip_code"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "line1": line1,
    "line2": line2,
    "locality": locality,
    "district": district,
    "mandal": mandal,
    "village": village,
    "zip_code": zipCode,
    "city": city,
    "state": state,
    "country": country,
  };
}

class Certificate {
  final String? title;
  final String? issuedBy;
  final String? description;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Certificate({
    this.title,
    this.issuedBy,
    this.description,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Certificate copyWith({
    String? title,
    String? issuedBy,
    String? description,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Certificate(
        title: title ?? this.title,
        issuedBy: issuedBy ?? this.issuedBy,
        description: description ?? this.description,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
    title: json["title"],
    issuedBy: json["issuedBy"],
    description: json["description"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "issuedBy": issuedBy,
    "description": description,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Conference {
  final String? name;
  final int? date;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Conference({
    this.name,
    this.date,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Conference copyWith({
    String? name,
    int? date,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Conference(
        name: name ?? this.name,
        date: date ?? this.date,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Conference.fromJson(Map<String, dynamic> json) => Conference(
    name: json["name"],
    date: json["date"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "date": date,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
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

class MedicalRegistration {
  final String? registrationNumber;
  final String? registrationCouncil;
  final int? registrationYear;

  MedicalRegistration({
    this.registrationNumber,
    this.registrationCouncil,
    this.registrationYear,
  });

  MedicalRegistration copyWith({
    String? registrationNumber,
    String? registrationCouncil,
    int? registrationYear,
  }) =>
      MedicalRegistration(
        registrationNumber: registrationNumber ?? this.registrationNumber,
        registrationCouncil: registrationCouncil ?? this.registrationCouncil,
        registrationYear: registrationYear ?? this.registrationYear,
      );

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
  final String? membership;
  final int? startDate;
  final int? endDate;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Membership({
    this.membership,
    this.startDate,
    this.endDate,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  Membership copyWith({
    String? membership,
    int? startDate,
    int? endDate,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Membership(
        membership: membership ?? this.membership,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
    membership: json["membership"],
    startDate: json["startDate"],
    endDate: json["endDate"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "membership": membership,
    "startDate": startDate,
    "endDate": endDate,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class MentorInfo {
  final String? organization;
  final String? organizationWebsite;
  final String? educationalQualification;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? email;

  MentorInfo({
    this.organization,
    this.organizationWebsite,
    this.educationalQualification,
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
  });

  MentorInfo copyWith({
    String? organization,
    String? organizationWebsite,
    String? educationalQualification,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
  }) =>
      MentorInfo(
        organization: organization ?? this.organization,
        organizationWebsite: organizationWebsite ?? this.organizationWebsite,
        educationalQualification: educationalQualification ?? this.educationalQualification,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phone: phone ?? this.phone,
        email: email ?? this.email,
      );

  factory MentorInfo.fromJson(Map<String, dynamic> json) => MentorInfo(
    organization: json["organization"],
    organizationWebsite: json["organizationWebsite"],
    educationalQualification: json["educationalQualification"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    phone: json["phone"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "organization": organization,
    "organizationWebsite": organizationWebsite,
    "educationalQualification": educationalQualification,
    "firstName": firstName,
    "lastName": lastName,
    "phone": phone,
    "email": email,
  };
}

class Name {
  final String? middleName;
  final String? firstName;
  final String? lastName;

  Name({
    this.middleName,
    this.firstName,
    this.lastName,
  });

  Name copyWith({
    String? middleName,
    String? firstName,
    String? lastName,
  }) =>
      Name(
        middleName: middleName ?? this.middleName,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
      );

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
  final bool? hideStatus;
  final String? type;
  final String? reason;
  final int? endDate;
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProfileStatus({
    this.hideStatus,
    this.type,
    this.reason,
    this.endDate,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  ProfileStatus copyWith({
    bool? hideStatus,
    String? type,
    String? reason,
    int? endDate,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      ProfileStatus(
        hideStatus: hideStatus ?? this.hideStatus,
        type: type ?? this.type,
        reason: reason ?? this.reason,
        endDate: endDate ?? this.endDate,
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ProfileStatus.fromJson(Map<String, dynamic> json) => ProfileStatus(
    hideStatus: json["hideStatus"],
    type: json["type"],
    reason: json["reason"],
    endDate: json["endDate"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "hideStatus": hideStatus,
    "type": type,
    "reason": reason,
    "endDate": endDate,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
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

class TokenDetail {
  final String? token;
  final String? type;

  TokenDetail({
    this.token,
    this.type,
  });

  TokenDetail copyWith({
    String? token,
    String? type,
  }) =>
      TokenDetail(
        token: token ?? this.token,
        type: type ?? this.type,
      );

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
  final dynamic isInterested;

  VolunteerInfo({
    this.isInterested,
  });

  VolunteerInfo copyWith({
    dynamic isInterested,
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
