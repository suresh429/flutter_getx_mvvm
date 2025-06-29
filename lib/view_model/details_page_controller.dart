import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_html/flutter_html.dart';

import '../model/ExploreModel.dart';
import '../model/LoginModel.dart';
import '../model/details_model.dart';
import '../service/ConnectivityService.dart';
import '../service/main_repository.dart';
import '../utilites/constants_Utils.dart';
import '../utilites/error_handler.dart';

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
  RxString connectId = ''.obs;
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
    initializeController();
    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      exploreModel = Get.arguments as ExploreModel;
      print('Received title: ${exploreModel.title}');
      print('Received requestType: ${exploreModel.requestType}');
      title.value = exploreModel.title;
      imageUrl.value = exploreModel.defaultImageUrl;
      final due = DateTime.fromMillisecondsSinceEpoch(exploreModel.dueDate ?? 0);
      daysLeft.value = '${due.difference(DateTime.now()).inDays} days left';

      await Future.delayed(const Duration(milliseconds: 500)); // Add small delay for smoother UX
      updateRequestInfo();
      updateDetailsData();
    } finally {
      isLoading.value = false;
    }
  }

  // initialize
  Future<void> initializeController() async {
    final response = await ConstantsUtils.getStoredLoginResponse();
    if (response != null) {
      loginResponse.value = response;
      // await getDetailsData(
      //   loginResponse.value?.data?.uniqueId,
      //   exploreModel.requestType ?? '',
      //   exploreModel.id ?? '',
      // );
    } else {
      errorMessage.value = 'Failed to load login response';
    }
  }

  // Fetch profile data from API
  // Future<void> getDetailsData(
  //     String? uniqueId,
  //     String requestType,
  //     String requestId,
  //     ) async {
  //   if (uniqueId == null || uniqueId.isEmpty) return;
  //
  //   try {
  //     isLoading(true);
  //     errorMessage.value = '';
  //
  //     final dataList = await repository.getDetailsData(
  //       uniqueId: uniqueId,
  //       requestType: requestType,
  //       requestId: requestId,
  //     );
  //
  //     if (dataList.isEmpty || dataList.first.  exploreModel == null) {
  //       errorMessage.value = 'No data found';
  //       return;
  //     }
  //
  //     final info = dataList.first.exploreModel;
  //     final userInfo = dataList.first.  exploreModel.userInfo;
  //     title.value = info.title ?? '';
  //     imageUrl.value = info.defaultImageUrl ?? '';
  //
  //     final due = DateTime.fromMillisecondsSinceEpoch(info.dueDate ?? 0);
  //     daysLeft.value = '${due.difference(DateTime.now()).inDays} days left';
  //
  //
  //     updateRequestInfo(info, userInfo);
  //     updateDetailsData(info);
  //
  //   } catch (e) {
  //     print('Details fetch error: $e');
  //     errorMessage.value = 'Something went wrong';
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  void updateDetailsData() {
    final requestType = exploreModel.requestType ?? '';
    print('Received title: $requestType');
    if (requestType == "podcast") {
      // Update titles
      preferredTitle.value = "Podcast Dates:";
      languageTitle.value = "Podcast Mode:";

      // Format podcast date
      final podcastDate = exploreModel.additionalInfo?.podcastDate;
      if (podcastDate != null && podcastDate > 0) {
        preferredValue.value =
            ConstantsUtils.convertMillisecondsToFormattedDate2(podcastDate);
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
    } else if (requestType == "eventSpeaker") {
      // Update titles
      preferredTitle.value = "Event Dates:";
      languageTitle.value = "Event Mode:";

      // Format event dates
      final startDate = ConstantsUtils.convertMillisecondsToFormattedDate2(
        exploreModel.startDate ?? 0,
      );
      final endDate = ConstantsUtils.convertMillisecondsToFormattedDate2(
        exploreModel.dueDate ?? 0,
      );
      preferredValue.value = "$startDate-$endDate";

      // Format event mode
      final mode = exploreModel.preferredConsultationMode;
      if (mode.isNotEmpty) {
        languageValue.value = capitalizeEachWord(mode);
      } else {
        languageValue.value = "No format available";
      }
    } else if (requestType == "mentoring") {
      // Update titles
      preferredTitle.value = "Preferred Industry:";
      languageTitle.value = "Preferred Language:";

      // Format industry
      final requestedFor = exploreModel.requestedFor;
      if (requestedFor != null && requestedFor.isNotEmpty) {
        preferredValue.value = ConstantsUtils.capitalizeFirst(requestedFor);
      } else {
        preferredValue.value = "N/A";
      }

      final langs = exploreModel.additionalInfo?.languages;
      print("object $langs");
      if (langs != null && langs.isNotEmpty) {
        languageValue.value = langs
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

      final langs =
          exploreModel.additionalInfo?.languages
              ?.whereType<String>()
              .map(ConstantsUtils.capitalizeFirst)
              .toList();

      languageValue.value =
          (langs != null && langs.isNotEmpty) ? langs.join(", ") : "N/A";
    }

    // Update UI states based on scholarship and favorites
    isScholarshipApplied.value = exploreModel.isScholarshipApplied.value ?? false;
    showInterestSent.value = isScholarshipApplied.value;
    showConnectButton.value = !isScholarshipApplied.value;
    showWithdrawButton.value = isScholarshipApplied.value;

    isFavorite.value = exploreModel.isFavorite.value;
    isLiked.value = exploreModel.isLike.value;
    likeCount.value = exploreModel.likesCount.value ?? 0;
    commentCount.value = exploreModel.commentsCount ?? 0;
    shareCount.value = exploreModel.sharesCount.value ?? 0;
  }

  // Update values in getDetailsData
  void updateRequestInfo() {
    currentRequestType.value = exploreModel.requestType;
    print('Current request type: ${currentRequestType.value}');

    /// PODCAST
    if (currentRequestType.value == "podcast") {
      final additionalInfo = exploreModel.additionalInfo;

      podcastDescription.value =
          additionalInfo?.interviewOrPanelDiscussion ?? 'N/A';
      podcastName.value = additionalInfo?.podcastName ?? 'N/A';
      podcastType.value = exploreModel.requestedFor;
      hostName.value = additionalInfo?.hostName ?? 'N/A';

      if (exploreModel.additionalInfo != null) {
        final additionalInfo = exploreModel.additionalInfo!;

        List<String> formattedDates = [];

        if (additionalInfo.podcastDate != null &&
            additionalInfo.podcastDate! > 0) {
          final date = DateTime.fromMillisecondsSinceEpoch(
            additionalInfo.podcastDate!,
          );
          formattedDates.add(ConstantsUtils.formatDateTime(date));
        }

        if (additionalInfo.podcastDate1 != null &&
            additionalInfo.podcastDate1! > 0) {
          final date = DateTime.fromMillisecondsSinceEpoch(
            additionalInfo.podcastDate1!,
          );
          formattedDates.add(ConstantsUtils.formatDateTime(date));
        }

        if (additionalInfo.podcastDate2 != null &&
            additionalInfo.podcastDate2! > 0) {
          final date = DateTime.fromMillisecondsSinceEpoch(
            additionalInfo.podcastDate2!,
          );
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

      guestRequirements.value = additionalInfo?.preferredTopics ?? 'N/A';
      preferredLanguage.value =
          ((additionalInfo?.languages?.isNotEmpty ?? false)
              ? additionalInfo!.languages?.join(', ')
              : 'N/A')!;

      expectedDuration.value = additionalInfo?.duration ?? 'N/A';
      commercial.value = additionalInfo?.preferredConsultationMode ?? 'N/A';
      stipendFee.value = exploreModel.quantity?.toString() ?? 'N/A';
    } else if (currentRequestType.value == "eventSpeaker") {
      final additionalInfo = exploreModel.additionalInfo;

      speakerDescription.value = exploreModel.description;
      eventName.value = exploreModel.eventName ?? 'N/A';
      eventType.value = exploreModel.requestedFor;
      venueName.value = '${exploreModel.shippingAddress?.line1}';

      final addressParts = [
        exploreModel.shippingAddress?.city,
        exploreModel.shippingAddress?.state,
        exploreModel.shippingAddress?.country
      ].where((e) => e != null && e.isNotEmpty).toList();

      eventLocation.value = addressParts.isNotEmpty
          ? addressParts.join(", ")
          : "N/A";

      speakerResponsibilities.value = additionalInfo?.speakerResponsibilities ?? 'N/A';
      final qualifications = additionalInfo?.qualificationsRequired;
      speakerQualifications.value = (qualifications != null && qualifications.isNotEmpty)
          ? qualifications
          : ["No qualifications available"];

      speakerTopics.value = additionalInfo?.speakingTopics ?? 'N/A';
      speakerDuration.value = additionalInfo?.speechduration ?? 'N/A';
      audienceSize.value = exploreModel.size != null ? exploreModel.size.toString() : 'N/A';
      commercialMode.value = additionalInfo?.preferredCommercialMode ?? 'N/A';

      // Handle languages
      speakerLanguages.value = exploreModel.languages;

      final deadline = additionalInfo?.speakerDeadline;
      speakerDeadline.value = (deadline != null && deadline > 0)
          ? ConstantsUtils.convertMillisecondsToFormattedDate2(deadline)
          : 'N/A';

      // Format speaker fee
      final symbol = (exploreModel.units.toLowerCase() == "usd") ? "\$" : "₹";
      speakerFee.value = exploreModel.quantity != null
          ? "$symbol ${exploreModel.quantity}"
          : "N/A";
    }
    else if (currentRequestType.value == "mentoring") {
      mentorDescription.value = exploreModel.description;
      mentorResponsibilities.value = exploreModel.whyYouNeedHelp ?? 'N/A';
      mentorExpectedTime.value = exploreModel.additionalInfo?.socialProblem != null
          ? "${exploreModel.additionalInfo!.socialProblem} hrs / months"
          : "N/A";
      mentorMode.value = exploreModel.additionalInfo?.preferredConsultationMode ?? 'N/A';
      mentorDeadline.value = exploreModel.dueDate != null && exploreModel.dueDate! > 0
          ? ConstantsUtils.convertMillisecondsToFormattedDate2(exploreModel.dueDate!)
          : 'N/A';

      // Handle qualifications similar to eventSpeaker
      mentorQualifications.value = exploreModel.additionalInfo?.qualificationsRequired is List
          ? (exploreModel.additionalInfo!.qualificationsRequired as List).whereType<String>().toList()
          : exploreModel.additionalInfo?.qualificationsRequired is String
              ? [exploreModel.additionalInfo!.qualificationsRequired as String]
              : ["N/A"];
    } else {
      // Board Member case
      boardDescription.value = exploreModel.description ?? 'N/A';

      // Handle functional expertise
      boardExpertise.value = exploreModel.additionalInfo?.functionalExpertise
          ?.map((e) => e ?? 'N/A')
          ?.toList() ?? [];

      boardExpectedTime.value = exploreModel.additionalInfo?.numberOfCommitsPerYear ?? 'N/A';
      boardTermLength.value = exploreModel.additionalInfo?.termLength ?? 'N/A';

      // Handle personal traits
      boardPersonalTraits.value = exploreModel.additionalInfo?.personalTraits
          ?.map((e) => e ?? 'N/A')
          ?.toList() ?? [];

      boardResponsibilities.value = exploreModel.additionalInfo?.responsibilities ?? 'N/A';

      // Handle qualifications similar to eventSpeaker
      boardQualifications.value = exploreModel.additionalInfo?.qualificationsRequired is List
          ? (exploreModel.additionalInfo!.qualificationsRequired as List).whereType<String>().toList()
          : exploreModel.additionalInfo?.qualificationsRequired is String
          ? [exploreModel.additionalInfo!.qualificationsRequired as String]
          : ["No qualifications available"];

      // Format end date
      boardEndDate.value = (exploreModel.dueDate ?? 0) > 0
          ? ConstantsUtils.convertMillisecondsToFormattedDate2(exploreModel.dueDate!)
          : 'N/A';

    }

    // Update profile info
    profileLocation.value = exploreModel.userInfo?.address?.city ?? '';

    final firstName = exploreModel.userInfo?.name?.firstName ?? '';
    final lastName = exploreModel.userInfo?.name?.lastName ?? '';
    profileName.value = "$firstName $lastName".trim();
    profileDate.value = ConstantsUtils.convertMillisecondsToFormattedDate(
      exploreModel.createdAt ?? 0,
    );
    profileImageUrl.value = exploreModel.userInfo?.imageUrl ?? '';

    // Update organization info if available
    final org = exploreModel.orgId;
    showOrganization.value = org != null;

    if (org != null) {
      orgName.value = org.orgName ?? 'N/A';
      orgLocation.value = org.orgAddress?.city ?? 'N/A';
      orgImageUrl.value = org.defaultImageUrl ?? 'N/A';
      orgDate.value = ConstantsUtils.formatDate(org.createdAt);
    }
  }

  // Helper method to capitalize each word in a string
  String capitalizeEachWord(String text) {
    if (text.isEmpty) return text;
    return text
        .split(" ")
        .map(
          (word) =>
              word.isEmpty
                  ? ""
                  : "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}",
        )
        .join(" ");
  }

  Future<void> sendConnectRequest({required String donationRequestId}) async {
    try {
      isLoading.value = true;

      final Map<String, dynamic> requestBody = {
        "donation_request_info": donationRequestId,
        "user_id": loginResponse.value?.data?.uniqueId,
      };

      print('Sending connect request payload: $requestBody');

      final response = await repository.connectRequest(
        loginResponse.value?.data?.tokenDetail?.token,
        requestBody,
      );

      if (response.status == "success") {
        print('Connect request Id: ${response.data?.id}');
        connectId.value = response.data?.id?? '';
        isScholarshipApplied.value = true;
        showInterestSent.value = true;
        showConnectButton.value = false;
        showWithdrawButton.value = true;
        Get.snackbar('Success', response.message ?? 'Successfully connected');
      } else {
        Get.snackbar('Error', response.message ?? 'Failed to connect');
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendWithdrawRequest({required String connectId}) async {
    print("Withdraw API called ${connectId}");
    try {
      if (isLoading.value || loginResponse.value == null) return;

      isLoading(true);

      final dataResponse = await repository.withdraw(connectId, loginResponse.value?.data?.tokenDetail?.token);

      print("Withdraw API response: $dataResponse");

      if (dataResponse['status'] == 'success') {
        isScholarshipApplied.value = false;
        showInterestSent.value = false;
        showConnectButton.value = true;
        showWithdrawButton.value = false;
        Get.snackbar('Success', 'Withdraw Successfully connected');
      } else {
        Get.snackbar('Error', 'Failed to connect');
      }

    } catch (e) {
      String errorMsg = await ErrorHandler.handleError(e);
      Get.snackbar('Error', errorMsg);
    } finally {
      isLoading(false);
    }
  }



  @override
  void dispose() {
    super.dispose();
  }

}
