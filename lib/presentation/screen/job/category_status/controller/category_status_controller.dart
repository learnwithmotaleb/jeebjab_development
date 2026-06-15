import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';

// ── Category types ─────────────────────────────────────────────────────────
enum PostCategory { move, recycle, buyForMe, giveAway }

class CategoryStatusController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // ── API-driven button state ───────────────────────────────────────────────
  // true  → user already sent a request  → show "Cancel Request"
  // false → no active request            → show "Send Request"
  final RxBool hasActiveRequest = false.obs;

  // ── Category ──────────────────────────────────────────────────────────────
  final Rx<PostCategory> category = PostCategory.move.obs;

  // ── Item Info ─────────────────────────────────────────────────────────────
  RxString itemType = AppStrings.move.obs;
  RxString itemSubtype = 'Ducati Bike'.obs;
  RxString publishedTime = AppStrings.publishedHoursAgo.obs;
  RxDouble itemPrice = 85.0.obs;

  // ── Meta ──────────────────────────────────────────────────────────────────
  RxString size = AppStrings.medium.obs;
  RxString preferredPickupTime = AppStrings.anytime.obs;

  // ── Carousel Images ───────────────────────────────────────────────────────
  RxList<String> images = <String>[
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600',
    'https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=600',
    'https://images.unsplash.com/photo-1571068316344-75bc76f77890?w=600',
  ].obs;

  // ── Pick-Up Info ──────────────────────────────────────────────────────────
  RxString pickupAddress = 'Abu Dhabi - 23052, Level 2, Door 6'.obs;
  RxList<String> pickupFeatures = <String>[].obs;

  // ── Delivery Info (Move only) ─────────────────────────────────────────────
  RxString deliveryAddress = 'Abu Dhabi - 23052'.obs;
  RxList<String> deliveryFeatures = <String>[].obs;

  // ── Advertiser Info ───────────────────────────────────────────────────────
  RxString advertiserName = 'Faris Shafi'.obs;
  RxDouble advertiserRating = 4.7.obs;
  RxString advertiserImage =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200'.obs;

  // ── Job ID ────────────────────────────────────────────────────────────────
  final RxString jobId = ''.obs;

  // ── Helpers ───────────────────────────────────────────────────────────────
  bool get isMove => category.value == PostCategory.move;
  bool get isRecycle => category.value == PostCategory.recycle;

  @override
  void onInit() {
    super.onInit();
    _initFeatures();
    _loadArguments();
  }

  // ── Build translated feature lists ───────────────────────────────────────
  void _initFeatures() {
    final features = [
      AppStrings.insideTheHouse.tr,
      AppStrings.needToMeet.tr,
      AppStrings.canHelpCarryAtDropOff.tr,
      AppStrings.fitsInTheElevator.tr,
    ];
    pickupFeatures.value = features;
    deliveryFeatures.value = List.from(features);
  }

  void _loadArguments() {
    if (Get.arguments == null) return;
    final args = Get.arguments as Map<String, dynamic>;
    final String? id = args['id'];

    if (id != null && id.isNotEmpty) {
      jobId.value = id;
      fetchPostDetails(id);
      return;
    }

    final cat = args['category'] ?? 'move';
    if (cat == 'recycle') {
      category.value = PostCategory.recycle;
      itemType.value = AppStrings.recycling.tr;
      itemSubtype.value = AppStrings.plasticAndPaper.tr;
      itemPrice.value = 260.0;
      preferredPickupTime.value = AppStrings.asap.tr;
      images.value = [
        'https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=600',
      ];
    } else {
      category.value = PostCategory.move;
      itemType.value = AppStrings.move.tr;
      itemSubtype.value = args['itemSubtype'] ?? 'Ducati Bike';
      itemPrice.value = (args['price'] ?? 85).toDouble();
    }

    size.value = args['size'] ?? AppStrings.medium.tr;
    preferredPickupTime.value = args['pickupTime'] ?? preferredPickupTime.value;
    pickupAddress.value =
        args['pickupAddress'] ?? 'Abu Dhabi - 23052, Level 2, Door 6';
    deliveryAddress.value = args['deliveryAddress'] ?? 'Abu Dhabi - 23052';
    if (args['images'] != null) {
      images.value = List<String>.from(args['images']);
    }
  }

  // ── Fetch post details + check driver's request status ───────────────────
  Future<void> fetchPostDetails(String id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiClient.get(
        url: ApiUrl.getPostDetails(id),
        isToken: true,
      );

      if (response.statusCode == 200) {
        _mapPostData(response.body['data']);
        // After loading the post, check if driver has a pending request
        await _fetchDriverJobStatus(id);
      } else {
        errorMessage.value =
            response.statusText ?? 'Failed to load post details';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      debugPrint('❌ fetchPostDetails exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Check driver-specific request status via API ─────────────────────────
  // We call the send endpoint; if the server says "already have pending request"
  // it means the driver already sent one → show Cancel button.
  // Any other non-200 response means no active request → show Send button.
  Future<void> _fetchDriverJobStatus(String id) async {
    try {
      final response = await _apiClient.post(
        url: ApiUrl.postSendJobRequest(id),
        isToken: true,
      );

      final msg = (response.body['message'] ?? '').toString().toLowerCase();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Server accepted → request just sent (rare edge case on status check)
        hasActiveRequest.value = true;
      } else if (msg.contains('pending') || msg.contains('already')) {
        // Driver already has a pending request for this job
        hasActiveRequest.value = true;
      } else {
        // No active request
        hasActiveRequest.value = false;
      }
    } catch (e) {
      // On error keep false (show Send Request)
      hasActiveRequest.value = false;
      debugPrint('❌ _fetchDriverJobStatus error: $e');
    }
  }

  // ── Map API response to observables ──────────────────────────────────────
  void _mapPostData(Map<String, dynamic> data) {
    final typeStr = data['type'] ?? '';
    if (typeStr == 'recycling') {
      category.value = PostCategory.recycle;
      itemType.value = AppStrings.recycling.tr;
      if (data['wasteType'] != null) {
        itemSubtype.value = data['wasteType'] is List
            ? (data['wasteType'] as List).join(', ')
            : data['wasteType'].toString();
      } else {
        itemSubtype.value = AppStrings.plasticAndPaper.tr;
      }
    } else if (typeStr == 'buy_for_me') {
      category.value = PostCategory.buyForMe;
      itemType.value = AppStrings.buyForMe.tr;
      itemSubtype.value = data['title'] ?? '';
    } else if (typeStr == 'give_away') {
      category.value = PostCategory.giveAway;
      itemType.value = AppStrings.giveAway.tr;
      itemSubtype.value = data['title'] ?? '';
    } else {
      category.value = PostCategory.move;
      itemType.value = AppStrings.move.tr;
      itemSubtype.value = data['title'] ?? '';
    }

    itemPrice.value = (data['price'] ?? 0).toDouble();
    size.value =
        data['size']?.toString().capitalizeFirst ?? AppStrings.medium.tr;

    final dt = data['dateTimeSlot'];
    if (dt != null) {
      final scheduledDate = dt['scheduledDate'] ?? '';
      final scheduledTime = dt['scheduledTime'] ?? '';
      preferredPickupTime.value = scheduledDate.isNotEmpty
          ? '$scheduledDate, $scheduledTime'
          : dt['slotType'] ?? AppStrings.anytime.tr;
    } else {
      preferredPickupTime.value = AppStrings.anytime.tr;
    }

    if (data['photos'] is List && (data['photos'] as List).isNotEmpty) {
      images.value = (data['photos'] as List)
          .map((p) => ApiUrl.buildImageUrl(p.toString()))
          .toList();
    } else if (data['photo'] != null && data['photo'].toString().isNotEmpty) {
      images.value = [ApiUrl.buildImageUrl(data['photo'].toString())];
    } else {
      images.value = [];
    }

    final pickup = data['pickup'];
    if (pickup != null) {
      pickupAddress.value = pickup['address']?['text'] ?? '';
      pickupFeatures.value = _buildFeatures(pickup['placement']);
    } else {
      pickupAddress.value = '';
      pickupFeatures.value = [];
    }

    final dropoff = data['dropoff'];
    if (dropoff != null) {
      deliveryAddress.value = dropoff['address']?['text'] ?? '';
      deliveryFeatures.value = _buildFeatures(dropoff['placement']);
    } else {
      deliveryAddress.value = '';
      deliveryFeatures.value = [];
    }

    final user = data['user'];
    if (user != null) {
      advertiserName.value = user['name'] ?? '';
      advertiserRating.value = (user['ratingAsAdvertiser'] ?? 0).toDouble();
      advertiserImage.value = user['avatar'] != null
          ? ApiUrl.buildImageUrl(user['avatar'].toString())
          : 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200';
    } else {
      advertiserName.value = '';
      advertiserRating.value = 0.0;
      advertiserImage.value =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200';
    }

    publishedTime.value = data['createdAt'] != null
        ? data['createdAt'].toString().substring(0, 10)
        : AppStrings.publishedHoursAgo.tr;
  }

  List<String> _buildFeatures(Map<String, dynamic>? placement) {
    if (placement == null) return [];
    final list = <String>[];
    if (placement['placement'] == 'inside') list.add(AppStrings.insideTheHouse.tr);
    if (placement['needToMeet'] == true) list.add(AppStrings.needToMeet.tr);
    if (placement['canHelpCarry'] == true) list.add(AppStrings.canHelpCarryAtDropOff.tr);
    if (placement['fitsInElevator'] == true) list.add(AppStrings.fitsInTheElevator.tr);
    return list;
  }

  // ── Button Actions ────────────────────────────────────────────────────────

  void onSendRequest() => _sendJobRequest();

  Future<void> _sendJobRequest() async {
    if (jobId.value.isEmpty) return;

    try {
      isLoading.value = true;

      final response = await _apiClient.post(
        url: ApiUrl.postSendJobRequest(jobId.value),
        isToken: true,
      );

      final body = response.body;
      final msg = (body['message'] ?? '').toString().toLowerCase();

      if (response.statusCode == 200 || response.statusCode == 201) {
        // ✅ Request sent → switch button to "Cancel Request"
        hasActiveRequest.value = true;
        Get.snackbar('Success', body['message'] ?? 'Request sent successfully');
      } else if (msg.contains('pending') || msg.contains('already')) {
        // Already sent → still show Cancel
        hasActiveRequest.value = true;
        Get.snackbar('Info', 'Request already sent');
      } else {
        errorMessage.value = body['message'] ?? 'Failed to send request';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void onCancelRequest() => _cancelJobRequest();

  Future<void> _cancelJobRequest() async {
    if (jobId.value.isEmpty) return;

    try {
      isLoading.value = true;

      final response = await _apiClient.delete(
        url: ApiUrl.deleteCancelJobRequest(jobId.value),
        isToken: true,
      );

      final body = response.body;
      final msg = (body['message'] ?? '').toString().toLowerCase();

      if (response.statusCode == 200) {
        // ✅ Cancelled → switch button back to "Send Request"
        hasActiveRequest.value = false;
        Get.snackbar('Success', body['message'] ?? 'Request cancelled');
      } else if (msg.contains('only pending')) {
        // Already cancelled
        hasActiveRequest.value = false;
        Get.snackbar('Info', 'Request already cancelled');
      } else {
        errorMessage.value = body['message'] ?? 'Failed to cancel request';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void onOpenPickupMap() => Get.toNamed(RoutePath.showMap);
  void onOpenDeliveryMap() => Get.toNamed(RoutePath.showMap);

  void onDelivery() {
    AppAlerts.confirm(
      title: 'Are you sure',
      message: 'Are you sure, you are picked-up?',
      onConfirm: () {
        AppAlerts.proof(
          title: 'Proof',
          message: 'Upload picture as a proof!',
          buttonLabel: 'Continue',
        );
      },
    );
  }

  void onShare() {}
  void onReportAd() {}
}