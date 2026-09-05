import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/helper/tost_message/show_snackbar.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';

enum PostCategory { move, recycle, buyForMe, giveAway }

class CategoryStatusController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // true  = "Cancel Request" দেখাবে
  // false = "Send Request" দেখাবে
  // Set হয়: GET response থেকে (screen load), Send 201, Cancel 200
  // Screen load এ কোনো POST call হয় না।
  final RxBool hasActiveRequest = false.obs;

  final Rx<PostCategory> category = PostCategory.move.obs;
  RxString itemType = AppStrings.move.obs;
  RxString itemSubtype = 'Ducati Bike'.obs;
  RxString publishedTime = AppStrings.publishedHoursAgo.obs;
  RxDouble itemPrice = 85.0.obs;
  RxString size = AppStrings.medium.obs;
  RxString preferredPickupTime = AppStrings.anytime.obs;
  RxList<String> images = <String>[].obs;
  RxString pickupAddress = ''.obs;
  RxList<String> pickupFeatures = <String>[].obs;
  double? pickupLat;
  double? pickupLng;
  RxString deliveryAddress = ''.obs;
  RxList<String> deliveryFeatures = <String>[].obs;
  double? dropoffLat;
  double? dropoffLng;
  RxString advertiserName = ''.obs;
  RxDouble advertiserRating = 0.0.obs;
  RxString advertiserImage =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200'.obs;
  final RxString jobId = ''.obs;

  bool get isMove => category.value == PostCategory.move;
  bool get isRecycle => category.value == PostCategory.recycle;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    if (Get.arguments == null) return;
    final args = Get.arguments as Map<String, dynamic>;
    final String? id = args['id'];

    if (id != null && id.isNotEmpty) {
      jobId.value = id;
      fetchPostDetails(id); // শুধু GET — কোনো POST নেই
      return;
    }

    final cat = args['category'] ?? 'move';
    if (cat == 'recycle') {
      category.value = PostCategory.recycle;
      itemType.value = args['title'] ?? AppStrings.recycling.tr;
      itemSubtype.value = AppStrings.plasticAndPaper.tr;
      itemPrice.value = 260.0;
      preferredPickupTime.value = AppStrings.asap.tr;
      images.value = ['https://images.unsplash.com/photo-1532996122724-e3c354a0b15b?w=600'];
    } else {
      category.value = PostCategory.move;
      itemType.value = args['title'] ?? args['itemSubtype'] ?? 'Ducati Bike';
      itemSubtype.value = AppStrings.move.tr;
      itemPrice.value = (args['price'] ?? 85).toDouble();
    }
    size.value = args['size'] ?? AppStrings.medium.tr;
    preferredPickupTime.value = args['pickupTime'] ?? preferredPickupTime.value;
    pickupAddress.value = args['pickupAddress'] ?? '';
    deliveryAddress.value = args['deliveryAddress'] ?? '';
    if (args['images'] != null) images.value = List<String>.from(args['images']);
  }

  // একটাই API call: GET /post/:id
  // এর response এ driverRequest field দেখে hasActiveRequest set হয়।
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
      } else {
        errorMessage.value = response.statusText ?? 'Failed to load post details';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      debugPrint('fetchPostDetails error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _mapPostData(Map<String, dynamic> data) {
    // itemType is the big bold heading on screen — it must be the post's
    // actual title (matching post_details_controller's convention), not the
    // category label. itemSubtype carries the category-specific line below it.
    final typeStr = data['type'] ?? '';
    final String title = (data['title'] as String?) ?? '';

    if (typeStr == 'recycling') {
      category.value = PostCategory.recycle;
      itemType.value = title.isNotEmpty ? title : AppStrings.recycling.tr;
      itemSubtype.value = data['wasteType'] is List &&
              (data['wasteType'] as List).isNotEmpty
          ? (data['wasteType'] as List).join(', ')
          : AppStrings.recycling.tr;
    } else if (typeStr == 'buy_for_me') {
      category.value = PostCategory.buyForMe;
      itemType.value = title.isNotEmpty ? title : AppStrings.buyForMe.tr;
      itemSubtype.value = AppStrings.buyForMe.tr;
    } else if (typeStr == 'give_away') {
      category.value = PostCategory.giveAway;
      itemType.value = title.isNotEmpty ? title : AppStrings.giveAway.tr;
      itemSubtype.value = AppStrings.giveAway.tr;
    } else {
      category.value = PostCategory.move;
      itemType.value = title.isNotEmpty ? title : AppStrings.move.tr;
      itemSubtype.value = AppStrings.move.tr;
    }

    itemPrice.value = (data['price'] ?? 0).toDouble();
    size.value = data['size']?.toString().capitalizeFirst ?? AppStrings.medium.tr;

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
    pickupAddress.value = pickup?['address']?['text'] ?? '';
    pickupFeatures.value = _buildFeatures(pickup?['placement']);
    final pickupCoords = pickup?['address']?['coordinates'];
    pickupLat = (pickupCoords?['lat'] as num?)?.toDouble();
    pickupLng = (pickupCoords?['lng'] as num?)?.toDouble();

    final dropoff = data['dropoff'];
    deliveryAddress.value = dropoff?['address']?['text'] ?? '';
    deliveryFeatures.value = _buildFeatures(dropoff?['placement']);
    final dropoffCoords = dropoff?['address']?['coordinates'];
    dropoffLat = (dropoffCoords?['lat'] as num?)?.toDouble();
    dropoffLng = (dropoffCoords?['lng'] as num?)?.toDouble();

    final user = data['user'];
    advertiserName.value = user?['name'] ?? '';
    advertiserRating.value = (user?['ratingAsAdvertiser'] ?? 0).toDouble();
    advertiserImage.value = user?['avatar'] != null
        ? ApiUrl.buildImageUrl(user!['avatar'].toString())
        : 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200';

    publishedTime.value = data['createdAt'] != null
        ? data['createdAt'].toString().substring(0, 10)
        : AppStrings.publishedHoursAgo.tr;

    // ── Button state: GET response এর driverRequest দেখে ─────────────────
    // Backend field নাম যেটাই হোক, এখানে check করা হচ্ছে।
    // null   → Send Request
    // object with status 'pending' → Cancel Request
    final driverReq = data['driverRequest'] ??
        data['myRequest'] ??
        data['jobRequest'];

    if (driverReq != null) {
      hasActiveRequest.value =
          (driverReq['status'] ?? '').toString() == 'pending';
    } else {
      hasActiveRequest.value = false;
    }

    debugPrint('🔘 Button: ${hasActiveRequest.value ? "Cancel Request" : "Send Request"} | driverRequest=$driverReq');

    debugPrint('📌 Mapped → title=${data['title']} | type=$typeStr | '
        'pickup=($pickupLat, $pickupLng) | dropoff=($dropoffLat, $dropoffLng)');
  }

  List<String> _buildFeatures(Map<String, dynamic>? p) {
    if (p == null) return [];
    return [
      if (p['placement'] == 'inside') AppStrings.insideTheHouse.tr,
      if (p['needToMeet'] == true) AppStrings.needToMeet.tr,
      if (p['canHelpCarry'] == true) AppStrings.canHelpCarryAtDropOff.tr,
      if (p['fitsInElevator'] == true) AppStrings.fitsInTheElevator.tr,
    ];
  }

  // ── Send: user button press করলে ─────────────────────────────────────────
  void onSendRequest() => _sendJobRequest();

  Future<void> _sendJobRequest() async {
    if (jobId.value.isEmpty) return;
    try {
      isLoading.value = true;
      final response = await _apiClient.post(
        url: ApiUrl.postSendJobRequest(jobId.value),
        isToken: true,
      );
      if (response.statusCode == 201 || response.statusCode == 200) {
        hasActiveRequest.value = true; // → Cancel দেখাবে
        Get.snackbar('Success', response.body['message'] ?? 'Request sent');
        debugPrint('Send ok → Cancel button');
      } else {
        Get.snackbar('Error', response.body['message'] ?? 'Failed');
      }
    } catch (e) {
      debugPrint('sendJobRequest error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // ── Cancel: user button press করলে ───────────────────────────────────────
  void onCancelRequest() => _cancelJobRequest();

  Future<void> _cancelJobRequest() async {
    if (jobId.value.isEmpty) return;
    try {
      isLoading.value = true;
      final response = await _apiClient.delete(
        url: ApiUrl.deleteCancelJobRequest(jobId.value),
        isToken: true,
      );
      if (response.statusCode == 200) {
        hasActiveRequest.value = false; // → Send দেখাবে
        Get.snackbar('Success', response.body['message'] ?? 'Cancelled');
        debugPrint('Cancel ok → Send button');
      } else {
        Get.snackbar('Error', response.body['message'] ?? 'Failed');
      }
    } catch (e) {
      debugPrint('cancelJobRequest error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onOpenPickupMap() => _openRouteMap();
  void onOpenDeliveryMap() => _openRouteMap();

  // Read-only view of the job's location(s): driver's current position plus
  // the pickup/drop-off markers and route — not the address *picker* screen
  // (RoutePath.showMap), which has a search bar and "Confirm Location" and
  // is meant for setting an address, not viewing an existing one.
  void _openRouteMap() {
    if (pickupLat == null || pickupLng == null) {
      AppSnackBar.info("This job doesn't have a pickup location to show yet.");
      return;
    }
    // Recycling posts only have a pickup — no drop-off at all — so only
    // include it when it's actually there.
    Get.toNamed(RoutePath.routeMap, arguments: {
      'pickupLat': pickupLat,
      'pickupLng': pickupLng,
      'pickupAddress': pickupAddress.value,
      if (dropoffLat != null && dropoffLng != null) ...{
        'dropoffLat': dropoffLat,
        'dropoffLng': dropoffLng,
        'dropoffAddress': deliveryAddress.value,
      },
    });
  }

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