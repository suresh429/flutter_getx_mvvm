import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/ExploreModel.dart';
import '../model/LoginModel.dart';
import '../model/details_model.dart';
import '../service/ConnectivityService.dart';
import '../service/main_repository.dart';
import '../utilites/constants_Utils.dart';

class DetailsPageController extends GetxController {
  final storage = GetStorage();
  Rx<LoginModel?> loginResponse = Rx<LoginModel?>(
    null,
  ); // Initialize with a default value
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  final MainRepository repository = MainRepository(); // API service instance
  final ConnectivityService connectivityService =
      Get.find<ConnectivityService>(); // Connectivity service instance

  // Add currentRequestType
  RxString currentRequestType = ''.obs;

  // Observable variables for details data
  RxString title = ''.obs;
  RxString imageUrl = ''.obs;
  RxString daysLeft = ''.obs;
  RxString preferredIndustry = ''.obs;
  RxString preferredLanguage = ''.obs;
  RxString guestConfirmationDeadline = 'N/A'.obs;
  RxString expectedDuration = ''.obs;
  RxString commercial = ''.obs;
  RxString stipendFee = ''.obs;
  RxString guestRequirements = ''.obs;
  RxInt likeCount = 0.obs;
  RxInt commentCount = 0.obs;
  RxInt shareCount = 0.obs;

  // Additional observable variables
  RxString preferredTitle = "Preferred Industry:".obs;
  RxString languageTitle = "Preferred Language:".obs;
  RxString preferredValue = "N/A".obs;
  RxString languageValue = "N/A".obs;
  RxString location = "".obs;
  RxBool isScholarshipApplied = false.obs;
  RxBool isFavorite = false.obs;
  RxBool isLiked = false.obs;
  RxBool showInterestSent = false.obs;
  RxBool showConnectButton = true.obs;
  RxBool showWithdrawButton = false.obs;

  // Request Info variables
  RxString podcastDescription = ''.obs;
  RxString podcastName = ''.obs;
  RxString podcastType = ''.obs;
  RxString hostName = ''.obs;
  RxList<String> podcastDates = <String>[].obs;
  RxString podcastTopics = ''.obs;
  RxList<String> podcastLanguages = <String>[].obs;
  RxString podcastDeadline = ''.obs;
  RxString podcastDuration = ''.obs;
  RxString podcastMode = ''.obs;
  RxString podcastFee = ''.obs;

  RxString speakerDescription = ''.obs;
  RxString eventName = ''.obs;
  RxString eventType = ''.obs;
  RxString venueName = ''.obs;
  RxString eventLocation = ''.obs;
  RxString speakerResponsibilities = ''.obs;
  RxList<String> speakerQualifications = <String>[].obs;
  RxString speakerTopics = ''.obs;
  RxString speakerDuration = ''.obs;
  RxString audienceSize = ''.obs;
  RxString commercialMode = ''.obs;
  RxList<String> speakerLanguages = <String>[].obs;
  RxString speakerDeadline = ''.obs;
  RxString speakerFee = ''.obs;

  RxString mentorDescription = ''.obs;
  RxString mentorResponsibilities = ''.obs;
  RxString mentorExpectedTime = ''.obs;
  RxString mentorMode = ''.obs;
  RxString mentorDeadline = ''.obs;
  RxList<String> mentorQualifications = <String>[].obs;

  RxString boardDescription = ''.obs;
  RxList<String> boardExpertise = <String>[].obs;
  RxString boardExpectedTime = ''.obs;
  RxString boardTermLength = ''.obs;
  RxList<String> boardPersonalTraits = <String>[].obs;
  RxString boardResponsibilities = ''.obs;
  RxList<String> boardQualifications = <String>[].obs;
  RxString boardEndDate = ''.obs;

  // Profile info
  RxString profileName = ''.obs;
  RxString profileDate = ''.obs;
  RxString profileLocation = ''.obs;
  RxString profileImageUrl = ''.obs;

  // Organization info
  RxBool showOrganization = false.obs;
  RxString orgName = ''.obs;
  RxString orgDate = ''.obs;
  RxString orgLocation = ''.obs;
  RxString orgImageUrl = ''.obs;

  late final ExploreModel exploreModel;

  // Initialize with some mock data
  @override
  void onInit() {
    super.onInit();
    exploreModel = Get.arguments as ExploreModel;
    print('Received title: ${exploreModel.title}');
    print('Received requestType: ${exploreModel.requestType}');
    initializeController();
  }

  // initialize
  Future<void> initializeController() async {
    final response = await ConstantsUtils.getStoredLoginResponse();
    if (response != null) {
      loginResponse.value = response;
      await getDetailsData(
        loginResponse.value?.data?.uniqueId,
        exploreModel.requestType ?? '',
        exploreModel.id ?? '',
      );
    } else {
      errorMessage.value = 'Failed to load login response';
    }
  }

  // Fetch profile data from API
  Future<void> getDetailsData(
      String? uniqueId,
      String requestType,
      String requestId,
      ) async {
    if (uniqueId == null || uniqueId.isEmpty) return;

    try {
      isLoading(true);
      errorMessage.value = '';

      final dataList = await repository.getDetailsData(
        uniqueId: uniqueId,
        requestType: requestType,
        requestId: requestId,
      );

      if (dataList.isEmpty || dataList.first.donationRequestInfo == null) {
        errorMessage.value = 'No data found';
        return;
      }

      final info = dataList.first.donationRequestInfo;
      final userInfo = dataList.first.donationRequestInfo.userInfo;
      title.value = info.title ?? '';
      imageUrl.value = info.defaultImageUrl ?? '';

      final due = DateTime.fromMillisecondsSinceEpoch(info.dueDate ?? 0);
      daysLeft.value = '${due.difference(DateTime.now()).inDays} days left';

      // Handle podcast specific data
      if (info.additionalInfo != null) {
        final additionalInfo = info.additionalInfo!;

        // Format podcast dates
        List<String> formattedDates = [];
        if (additionalInfo.podcastDate > 0) {
          final date = DateTime.fromMillisecondsSinceEpoch(additionalInfo.podcastDate);
          formattedDates.add(ConstantsUtils.formatDateTime(date));
        }
        if (additionalInfo.podcastDate1 > 0) {
          final date = DateTime.fromMillisecondsSinceEpoch(additionalInfo.podcastDate1);
          formattedDates.add(ConstantsUtils.formatDateTime(date));
        }
        if (additionalInfo.podcastDate2 > 0) {
          final date = DateTime.fromMillisecondsSinceEpoch(additionalInfo.podcastDate2);
          formattedDates.add(ConstantsUtils.formatDateTime(date));
        }

        podcastDates.value = formattedDates.isEmpty ? ["N/A"] : formattedDates;

        // Set podcast mode and other details
        podcastMode.value = additionalInfo.interviewOrPanelDiscussion ?? 'N/A';
        preferredLanguage.value = additionalInfo.languages?.join(', ') ?? 'N/A';
        expectedDuration.value = additionalInfo.duration ?? 'N/A';
        commercial.value = additionalInfo.format ?? 'N/A';
        preferredIndustry.value = additionalInfo.preferredTopics ?? 'N/A';
      }

      likeCount.value = info.likeCount ?? 0;
      commentCount.value = info.commentCount ?? 0;
      shareCount.value = info.shareCount ?? 0;
      
      updateRequestInfo(info, userInfo);
      updateDetailsData(info);

    } catch (e) {
      print('Details fetch error: $e');
      errorMessage.value = 'Something went wrong';
    } finally {
      isLoading(false);
    }
  }


  void updateDetailsData(DonationRequestInfo donationRequestInfo) {
    final requestType = donationRequestInfo.requestType ?? '';
     print('Received title: $requestType');
    if (requestType == "podcast") {
      // Update titles
      preferredTitle.value = "Podcast Dates:";
      languageTitle.value = "Podcast Mode:";

      // Format podcast date
      final podcastDate = exploreModel.dueDate;
      if (podcastDate != null && podcastDate > 0) {
        preferredValue.value = formatDateFromMillis(podcastDate);
      } else {
        preferredValue.value = "N/A";
      }

      // Format podcast mode
      final format = exploreModel.format;
      if (format != null && format.isNotEmpty) {
        languageValue.value = capitalizeEachWord(format);
      } else {
        languageValue.value = "No format available";
      }

    }
    else if (requestType == "eventSpeaker") {
      // Update titles
      preferredTitle.value = "Event Dates:";
      languageTitle.value = "Event Mode:";

      // Format event dates
      final startDate = formatDateFromMillis(exploreModel.startDate ?? 0);
      final endDate = formatDateFromMillis(exploreModel.dueDate ?? 0);
      preferredValue.value = "$startDate-$endDate";

      // Format event mode
      final mode = exploreModel.format;
      if (mode != null && mode.isNotEmpty) {
        languageValue.value = capitalizeEachWord(mode);
      } else {
        languageValue.value = "No format available";
      }

    } else if (requestType == "mentoring") {
      // Update titles
      preferredTitle.value = "Preferred Industry:";
      languageTitle.value = "Preferred Language:";

      // Format industry
      final requestedFor = donationRequestInfo.requestedFor;
      if (requestedFor != null && requestedFor.isNotEmpty) {
        preferredValue.value = ConstantsUtils.capitalizeFirst(requestedFor);
      } else {
        preferredValue.value = "N/A";
      }

      if (donationRequestInfo.additionalInfo?.languages != null &&
          donationRequestInfo.additionalInfo!.languages.isNotEmpty) {
        languageValue.value = donationRequestInfo.additionalInfo!.languages
            .map((lang) => ConstantsUtils.capitalizeFirst(lang))
            .join(", ");
      } else {
        languageValue.value = "N/A";
      }
    } else {
      // Default case (board member)
      preferredTitle.value = "Preferred Industry:";
      languageTitle.value = "Preferred Language:";

      // Format expertise
      final expertise = exploreModel.functionalExpertise
          .where((e) => e.isNotEmpty)
          .join(", ");
      preferredValue.value = expertise.isNotEmpty ? expertise : "N/A";

      if (donationRequestInfo.additionalInfo?.languages != null &&
          donationRequestInfo.additionalInfo!.languages.isNotEmpty) {
        languageValue.value = donationRequestInfo.additionalInfo!.languages
            .map((lang) => ConstantsUtils.capitalizeFirst(lang))
            .join(", ");
      } else {
        languageValue.value = "N/A";
      }
    }

    // Update UI states based on scholarship and favorites
    isScholarshipApplied.value = exploreModel.isScholarshipApplied.value ?? false;
    showInterestSent.value = isScholarshipApplied.value;
    showConnectButton.value = !isScholarshipApplied.value;
    showWithdrawButton.value = isScholarshipApplied.value;

    isFavorite.value = exploreModel.isFavorite.value;
    isLiked.value = exploreModel.isLike.value;

  }

  // Helper method to capitalize each word in a string
  String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text.split(" ")
        .map((word) => word.isEmpty ? "" : "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}")
        .join(" ");
  }

  String formatDateFromMillis(int millis) {
    final date = DateTime.fromMillisecondsSinceEpoch(millis);
    return "${date.day}-${date.month}-${date.year}";
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Update values in getDetailsData
  void updateRequestInfo(DonationRequestInfo? donationRequestInfo, UserInfo? userInfo) {
    if (donationRequestInfo == null) return;

    currentRequestType.value = donationRequestInfo.requestType ?? '';
    print('Current request type: ${currentRequestType.value}');

    if (currentRequestType.value == "podcast") {
      final additionalInfo = donationRequestInfo.additionalInfo;
      podcastDescription.value = additionalInfo?.interviewOrPanelDiscussion ?? 'N/A';
      podcastName.value = additionalInfo?.podcastName ?? 'N/A';
      podcastType.value = donationRequestInfo.requestedFor ?? 'N/A';
      hostName.value = additionalInfo?.hostName ?? 'N/A';

      // Set single podcast date for now
      List<String> formattedDates = [];
      if (additionalInfo.podcastDate > 0) {
        final date = DateTime.fromMillisecondsSinceEpoch(additionalInfo.podcastDate);
        formattedDates.add(ConstantsUtils.formatDateTime(date));
      }
      if (additionalInfo.podcastDate1 > 0) {
        final date = DateTime.fromMillisecondsSinceEpoch(additionalInfo.podcastDate1);
        formattedDates.add(ConstantsUtils.formatDateTime(date));
      }
      if (additionalInfo.podcastDate2 > 0) {
        final date = DateTime.fromMillisecondsSinceEpoch(additionalInfo.podcastDate2);
        formattedDates.add(ConstantsUtils.formatDateTime(date));
}
      podcastDates.value = formattedDates.isNotEmpty? formattedDates : ["N/A"];

      guestRequirements.value = donationRequestInfo.additionalInfo.preferredTopics?? 'N/A';

      preferredLanguage.value = donationRequestInfo.additionalInfo.languages.join(', ')?? 'N/A';
     // guestConfirmationDeadline.value = formatDateFromMillis(donationRequestInfo.guestConfirmationDeadline ?? 0);
      expectedDuration.value = donationRequestInfo.additionalInfo.duration?? 'N/A';
      commercial.value = donationRequestInfo.additionalInfo.preferredConsultationMode?? 'N/A';
      stipendFee.value = donationRequestInfo.quantity.toString() ?? "N/A";
    }

    // Update profile info
    final firstName = userInfo?.name.firstName ?? '';
    final lastName = userInfo?.name.lastName ?? '';
    profileName.value = "$firstName $lastName".trim();
    profileDate.value = ConstantsUtils.convertMillisecondsToFormattedDate(exploreModel.createdAt?? 0);
    profileLocation.value = userInfo?.address.city ?? '';
    profileImageUrl.value = userInfo?.imageUrl ?? '';

    // Update organization info if available
    final orgId = donationRequestInfo.orgId;
    showOrganization.value = orgId != null;
    if (showOrganization.value) {
      orgName.value = orgId?.orgName ?? 'N/A';
      orgLocation.value = orgId?.orgAddress?.city ?? '';
      orgImageUrl.value = orgId?.defaultImageUrl ?? '';
      orgDate.value = ConstantsUtils.formatDate(exploreModel.orgId?.createdAt);
    }
  }

  // Helper method
  String orNA(String? value) =>
      value?.trim().isNotEmpty == true ? value! : "N/A";

  bool isOrgIdEmpty(OrgId? orgId) {
    if (orgId == null) return true;
    return orgId.id.toString().isEmpty;
  }



}
