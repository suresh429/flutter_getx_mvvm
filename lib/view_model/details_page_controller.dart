import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/ExploreModel.dart';
import '../model/LoginModel.dart';
import '../model/MedialModel.dart';
import '../model/RevieModel.dart';
import '../model/details_model.dart';
import '../service/ConnectivityService.dart';
import '../service/main_repository.dart';
import '../utilites/constants_Utils.dart';
import '../utilites/error_handler.dart';

class DetailsPageController extends GetxController {
  final databaseReviews = FirebaseDatabase.instance.ref('conversations');
  final commentController = TextEditingController();
  bool hasReplyListener = false;
  StreamSubscription<DatabaseEvent>? replySubscription;


  final storage = GetStorage();
  Rx<LoginModel?> loginResponse = Rx<LoginModel?>(
    null,
  ); // Initialize with a default value
  RxBool isLoading = false.obs;
  RxBool hasLoadedReplies = false.obs; // add this to your controller

  RxString errorMessage = ''.obs;
  final MainRepository repository = MainRepository(); // API service instance
  final ConnectivityService connectivityService =
      Get.find<ConnectivityService>(); // Connectivity service instance

  // Add currentRequestType
  RxString currentRequestType = ''.obs;

  // Observable variables for details data
  RxString currentUserProfileUrl = ''.obs;
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

  var allMediaList = <MediaItem>[].obs;
  final listReviews = <ReviewModel>[].obs;
  final replyComments = <ReviewModel>[].obs;
  var isEditClicked = false.obs;
  var isReplyEditClicked = false.obs;
  var editReviewModel = Rxn<ReviewModel>();
  var adapterPosition = 0.obs;



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
      getAllMediaByRequestId(exploreModel.id?? '');
      fetchComments(exploreModel.id ?? '');
      fetchCommentCount(exploreModel);
    } finally {
      isLoading.value = false;
    }
  }

  // initialize
  Future<void> initializeController() async {
    final response = await ConstantsUtils.getStoredLoginResponse();
    if (response != null) {
      loginResponse.value = response;
      currentUserProfileUrl.value = loginResponse.value?.data?.profileImageUrl?? '';
      // await getDetailsData(
      //   loginResponse.value?.data?.uniqueId,
      //   exploreModel.requestType ?? '',
      //   exploreModel.id ?? '',
      // );
    } else {
      errorMessage.value = 'Failed to load login response';
    }
  }

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
   // commentCount.value = exploreModel.commentsCount.value ?? 0;
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


  Future<void> reportSpamRequest({required String reportId,required String reason}) async {
    print("Withdraw API called ${reportId}");
    try {
      if (isLoading.value || loginResponse.value == null) return;

      isLoading(true);

      final Map<String, dynamic> requestBody = {
        "status": -3,
        "user_id": loginResponse.value?.data?.uniqueId,
        "flagReason": reason,
      };

      final dataResponse = await repository.reportSpam(loginResponse.value?.data?.tokenDetail?.token, requestBody,reportId);

      print("Withdraw API response: $dataResponse");

      if (dataResponse.status == 'success') {

        Get.snackbar('Success', 'Report Successfully submitted');
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


  // Fetch all media items for a specific request ID
  Future<void> getAllMediaByRequestId(String requestId) async {
    final storage = FirebaseStorage.instance;
    final imagesPath = 'DonationRequest/$requestId/images';
    final documentsPath = 'DonationRequest/$requestId/documents';
    print('Fetching media from: $imagesPath and $documentsPath');
    final allMediaItems = <MediaItem>[];

    try {
      // Get images
      final imagesResult = await storage.ref(imagesPath).listAll();
      print('Found ${imagesResult.items.length} images and ${imagesResult.prefixes.length} subfolders in images path.');
      for (var item in imagesResult.items) {
        final metadata = await item.getMetadata();
        final url = await item.getDownloadURL();
        final created = metadata.timeCreated ?? DateTime.now();
        final userGivenName = metadata.customMetadata?['userGivenName'] ?? item.name;
        print('Image file: ${item.fullPath} (${userGivenName})');
        allMediaItems.add(MediaItem(userGivenName, url, created));
      }

      // Get documents
      final docsResult = await storage.ref(documentsPath).listAll();
      print('Found ${docsResult.items.length} documents and ${docsResult.prefixes.length} subfolders in documents path.');
      for (var item in docsResult.items) {
        final metadata = await item.getMetadata();
        final url = await item.getDownloadURL();
        final created = metadata.timeCreated ?? DateTime.now();
        final userGivenName = metadata.customMetadata?['userGivenName'] ?? item.name;
        print('Document file: ${item.fullPath} (${userGivenName})');
        allMediaItems.add(MediaItem(userGivenName, url, created));
      }

      allMediaList.value = allMediaItems;
      print('Total media items fetched: ${allMediaList.length}');
    } catch (e) {
      print('Error: $e');
      errorMessage.value = 'Error: $e';
    }
  }

  // fetch comments
  Future<void> fetchComments(String reqId) async {
    isLoading.value = true;
    databaseReviews.child(reqId).onValue.listen((event) {
      listReviews.clear();
      final dataSnapshot = event.snapshot;

      if (dataSnapshot.exists) {
        final children = dataSnapshot.children;
        for (final child in children) {
          final data = child.value as Map<dynamic, dynamic>;
          final review = ReviewModel.fromMap(data)
            ..id = child.key; // assign firebase key
          listReviews.add(review);
        }
        // sort by descending whenSent
        listReviews.sort((a, b) => (b.whenSent ?? 0).compareTo(a.whenSent ?? 0));
      }

      isLoading.value = false;
    }, onError: (error) {
      print('Error fetching comments: $error');
      isLoading.value = false;
    });
  }


  // ADD/Edit comment
  Future<void> submitComment(String text, String requestId) async{
    final now = DateTime.now().millisecondsSinceEpoch;

    if (isEditClicked.value) {
      final reviewId = editReviewModel.value?.id;
      if (reviewId != null) {
        final reviewRef = databaseReviews.child(requestId).child(reviewId);

        final updatedReview = ReviewModel(
          id: reviewId,
          userId: loginResponse.value?.data?.uniqueId, // from shared pref or auth
          senderProfileImageUrl: currentUserProfileUrl.value,
          senderName: '${loginResponse.value?.data?.name?.firstName} ${loginResponse.value?.data?.name?.lastName}'?? 'N/A',
          text: text,
          whenSent: now,
          type: editReviewModel.value?.type ?? "Text",
        );

        reviewRef.set(updatedReview.toMap());

        // update locally
        listReviews[adapterPosition.value] = updatedReview;

        isEditClicked.value = false;
        adapterPosition.value = 0;
        editReviewModel.value = null;

        Get.snackbar("Updated", "Comment updated successfully");
      }
    } else {
      final newId = databaseReviews.child(requestId).push().key;
      final newReview = ReviewModel(
        id: newId,
        userId: loginResponse.value?.data?.uniqueId, // from shared pref or auth
        senderProfileImageUrl: currentUserProfileUrl.value,
        senderName: '${loginResponse.value?.data?.name?.firstName} ${loginResponse.value?.data?.name?.lastName}'?? 'N/A',
        text: text,
        whenSent: now,
        type: "Text",
      );

      databaseReviews.child(requestId).child(newId!).set(newReview.toMap());

      // update locally
      listReviews.insert(0, newReview);

      Get.snackbar("Added", "Comment added successfully");
    }

  //  fetchCommentCount(requestId);
  }

  // delete comment
  Future<void> deleteComment(String reviewId, String requestId) async {
    try {
      final reviewRef = databaseReviews.child(requestId).child(reviewId);
      await reviewRef.remove();

      // update locally
      listReviews.removeWhere((element) => element.id == reviewId);
      listReviews.refresh(); // if using RxList to trigger UI update

      Get.snackbar("Deleted", "Comment deleted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete comment: $e");
    }
  }

  // Fetch comment count for a specific request ID
  Future<void> fetchCommentCount(ExploreModel exploreModel) async {
    final reqId = exploreModel.id;
    databaseReviews.child(reqId).onValue.listen((event) {
      int count = 0;
      final dataSnapshot = event.snapshot;

      if (dataSnapshot.exists) {
        for (final child in dataSnapshot.children) {
          if (child.key != null) {
            count++;
          }
        }
      }

      exploreModel.commentsCount.value = count;  // updates automatically
    }, onError: (error) {
      print('Error fetching comment count: $error');
    });
  }


  // fetch reply comments for a specific review under a request
  Future<void> fetchReplyComments(String requestId, String reviewId) async {
    print("Always cancelling previous subscription...");
    await replySubscription?.cancel();
    replySubscription = null;
    hasReplyListener = false;

    isLoading.value = true;
    hasLoadedReplies.value = false;

    final DatabaseReference repliesRef = databaseReviews
        .child(requestId)
        .child(reviewId)
        .child('replies');

    replySubscription = repliesRef.onValue.listen((event) {
      replyComments.clear();
      final dataSnapshot = event.snapshot;

      if (dataSnapshot.exists) {
        for (final child in dataSnapshot.children) {
          final data = child.value as Map<dynamic, dynamic>;
          final review = ReviewModel.fromMap(data)..id = child.key;
          replyComments.add(review);
        }

        replyComments.sort((a, b) => (b.whenSent ?? 0).compareTo(a.whenSent ?? 0));
      }

      isLoading.value = false;
      hasLoadedReplies.value = true;

      print("Replies loaded for $reviewId: ${replyComments.length}");
    }, onError: (error) {
      print('Error fetching reply comments: $error');
      isLoading.value = false;
      hasLoadedReplies.value = true;
    });

    hasReplyListener = true;
  }


  // Future<void> addReplyComment(String requestId, String reviewId, String text) async {
  //   if (text.trim().isEmpty) {
  //     Get.snackbar("Validation", "Please type a comment...");
  //     return;
  //   }
  //
  //   final currentTime = DateTime.now().millisecondsSinceEpoch;
  //
  //   if (isEditClicked.value && editReviewModel.value != null) {
  //     // ✏️ Update existing comment
  //     final review = ReviewModel(
  //       id: editReviewModel.value!.id,
  //       userId: loginResponse.value?.data?.uniqueId,
  //       senderProfileImageUrl: currentUserProfileUrl.value,
  //       senderName: editReviewModel.value?.senderName ?? '${loginResponse.value?.data?.name?.firstName} ${loginResponse.value?.data?.name?.lastName}'?? 'N/A',
  //       text: text,
  //       whenSent: currentTime,
  //       type: editReviewModel.value?.type ?? "Text",
  //     );
  //
  //     final reviewRef = databaseReviews
  //         .child(requestId)
  //         .child(reviewId)
  //         .child("replies")
  //         .child(review.id!);
  //
  //     await reviewRef.set(review.toMap());
  //
  //     // update locally (optional, you can refresh Firebase listener)
  //     final index = replyComments.indexWhere((c) => c.id == review.id);
  //     if (index != -1) {
  //       replyComments[index] = review;
  //       replyComments.refresh();
  //     }
  //
  //     Get.snackbar("Updated", "Comment updated");
  //
  //     isEditClicked.value = false;
  //     adapterPosition.value = 0;
  //     editReviewModel.value = null;
  //   } else {
  //     // ➕ Add new comment
  //     final newRef = databaseReviews
  //         .child(requestId)
  //         .child(reviewId)
  //         .child("replies")
  //         .push();
  //
  //     final newReview = ReviewModel(
  //       id: newRef.key,
  //       userId: loginResponse.value?.data?.uniqueId,
  //       senderProfileImageUrl: currentUserProfileUrl.value,
  //       senderName: editReviewModel.value?.senderName ?? '${loginResponse.value?.data?.name?.firstName} ${loginResponse.value?.data?.name?.lastName}'?? 'N/A',
  //       text: text,
  //       whenSent: currentTime,
  //       type: "Text",
  //     );
  //
  //     await newRef.set(newReview.toMap());
  //     Get.snackbar("Success", "Comment added");
  //
  //     replyComments.add(newReview);
  //   }
  // }


  Future<void> addReplyComment(String requestId, String reviewId, String text) async {
    if (text.trim().isEmpty) {
      Get.snackbar("Validation", "Please type a comment...");
      return;
    }

    final currentTime = DateTime.now().millisecondsSinceEpoch;

    print("isReplyEditClicked: ${isReplyEditClicked.value}");
    print("editReviewModel: ${editReviewModel.value}");

    if (isReplyEditClicked.value && editReviewModel.value?.id != null) {
      final reviewIdToEdit = editReviewModel.value!.id!;
      print("Editing reply with ID: $reviewIdToEdit");

      // Immediately reset state
      isReplyEditClicked.value = false;
      editReviewModel.value = null;

      final editedReview = ReviewModel(
        id: reviewIdToEdit,
        userId: loginResponse.value?.data?.uniqueId,
        senderProfileImageUrl: currentUserProfileUrl.value,
        senderName: '${loginResponse.value?.data?.name?.firstName} ${loginResponse.value?.data?.name?.lastName}' ?? 'N/A',
        text: text,
        whenSent: currentTime,
        type: "Text",
      );

      final reviewRef = databaseReviews
          .child(requestId)
          .child(reviewId)
          .child("replies")
          .child(reviewIdToEdit);

      await reviewRef.set(editedReview.toMap());
      Get.snackbar("Updated", "Comment updated");
      return;
    }

    // ➕ Adding new reply
    final newRef = databaseReviews
        .child(requestId)
        .child(reviewId)
        .child("replies")
        .push();

    final newReview = ReviewModel(
      id: newRef.key,
      userId: loginResponse.value?.data?.uniqueId,
      senderProfileImageUrl: currentUserProfileUrl.value,
      senderName: '${loginResponse.value?.data?.name?.firstName} ${loginResponse.value?.data?.name?.lastName}' ?? 'N/A',
      text: text,
      whenSent: currentTime,
      type: "Text",
    );

    await newRef.set(newReview.toMap());
    Get.snackbar("Success", "Comment added");
  }


  Future<void> deleteReplyComment(String requestId, String reviewId, String replyId) async {
    try {
      final replyRef = databaseReviews
          .child(requestId)
          .child(reviewId)
          .child("replies")
          .child(replyId);

      await replyRef.remove();

      // remove locally if you maintain a list
      replyComments.removeWhere((element) => element.id == replyId);
      replyComments.refresh();

      Get.snackbar("Deleted", "Review deleted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to delete review: $e");
    }
  }


  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
    print("Closing DetailsPageController & cancelling reply subscription");
    replySubscription?.cancel();
    hasReplyListener = false;
  }

}
