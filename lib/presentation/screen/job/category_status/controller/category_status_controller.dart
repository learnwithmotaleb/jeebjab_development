import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';

// ── Category types ─────────────────────────────────────────────────────────
enum PostCategory { move, recycle, buyForMe, giveAway }

// ── Request status flow ────────────────────────────────────────────────────
// Move:    none → sent → pickedUp → delivered
// Recycle: none → sent → pickedUp
enum RequestStatus { none, pending, sent, pickedUp, delivered }

class CategoryStatusController extends GetxController {
  final ApiClient _apiClient = ApiClient();
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // ── Category & Status ─────────────────────────────────────────────────────
  final Rx<PostCategory> category = PostCategory.move.obs;
  final Rx<RequestStatus> requestStatus = RequestStatus.none.obs;

  // ── Item Info ─────────────────────────────────────────────────────────────
  RxString itemType = AppStrings.move.obs;
  RxString itemSubtype = 'Ducati Bike'.obs;           // dynamic/user data
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
  RxString pickupAddress = 'Abu Dhabi - 23052, Level 2, Door 6'.obs; // dynamic
  RxList<String> pickupFeatures = <String>[].obs;

  // ── Delivery Info (Move only) ─────────────────────────────────────────────
  RxString deliveryAddress = 'Abu Dhabi - 23052'.obs;                // dynamic
  RxList<String> deliveryFeatures = <String>[].obs;

  // ── Advertiser Info ───────────────────────────────────────────────────────
  RxString advertiserName = 'Faris Shafi'.obs;                       // dynamic
  RxDouble advertiserRating = 4.7.obs;
  RxString advertiserImage =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200'.obs;

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
      fetchPostDetails(id);
      return;
    }

    // Category
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
    preferredPickupTime.value =
        args['pickupTime'] ?? preferredPickupTime.value;
    pickupAddress.value =
        args['pickupAddress'] ?? 'Abu Dhabi - 23052, Level 2, Door 6';
    deliveryAddress.value = args['deliveryAddress'] ?? 'Abu Dhabi - 23052';
    if (args['images'] != null) {
      images.value = List<String>.from(args['images']);
    }
  }

  Future<void> fetchPostDetails(String id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final response = await _apiClient.get(url: ApiUrl.getPostDetails(id), isToken: true);
      
      if (response.statusCode == 200) {
          final data = response.body['data'];
          // Map status
          final statusStr = data['status'] ?? '';
          switch (statusStr) {
            case 'pending':
              requestStatus.value = RequestStatus.pending;
              break;
            case 'sent':
              requestStatus.value = RequestStatus.sent;
              break;
            case 'pickedUp':
              requestStatus.value = RequestStatus.pickedUp;
              break;
            case 'delivered':
              requestStatus.value = RequestStatus.delivered;
              break;
            default:
              requestStatus.value = RequestStatus.none;
          }
          _mapPostData(data);
        } else {
          errorMessage.value = response.statusText ?? "Failed to load post details";
        }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
      debugPrint('❌ fetchPostDetails exception: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _mapPostData(Map<String, dynamic> data) {
    // Category mapping
    final typeStr = data['type'] ?? '';
    if (typeStr == 'recycling') {
      category.value = PostCategory.recycle;
      itemType.value = AppStrings.recycling.tr;
      
      // For recycle, subtype is wasteType
      if (data['wasteType'] != null) {
        if (data['wasteType'] is List) {
          itemSubtype.value = (data['wasteType'] as List).join(', ');
        } else if (data['wasteType'] is String) {
          itemSubtype.value = data['wasteType'];
        } else {
          itemSubtype.value = AppStrings.plasticAndPaper.tr;
        }
      } else {
        itemSubtype.value = AppStrings.plasticAndPaper.tr;
      }
    } else if (typeStr == 'buy_for_me') {
      category.value = PostCategory.buyForMe;
      itemType.value = AppStrings.buyForMe.tr;
      itemSubtype.value = data['title'] ?? "";
    } else if (typeStr == 'give_away') {
      category.value = PostCategory.giveAway;
      itemType.value = AppStrings.giveAway.tr;
      itemSubtype.value = data['title'] ?? "";
    } else {
      category.value = PostCategory.move;
      itemType.value = AppStrings.move.tr;
      itemSubtype.value = data['title'] ?? "";
    }

    itemPrice.value = (data['price'] ?? 0).toDouble();
    size.value = data['size']?.toString().capitalizeFirst ?? AppStrings.medium.tr;

    // Date/Time
    final dt = data['dateTimeSlot'];
    if (dt != null) {
      final scheduledDate = dt['scheduledDate'] ?? "";
      final scheduledTime = dt['scheduledTime'] ?? "";
      preferredPickupTime.value = scheduledDate != "" ? "$scheduledDate, $scheduledTime" : dt['slotType'] ?? AppStrings.anytime.tr;
    } else {
      preferredPickupTime.value = AppStrings.anytime.tr;
    }

    // Carousel Images
    if (data['photos'] != null && (data['photos'] is List) && (data['photos'] as List).isNotEmpty) {
      images.value = (data['photos'] as List).map((path) => ApiUrl.buildImageUrl(path.toString())).toList();
    } else if (data['photo'] != null && data['photo'].toString().isNotEmpty) {
      images.value = [ApiUrl.buildImageUrl(data['photo'].toString())];
    } else {
      images.value = [];
    }

    // Pick-Up Info
    final pickup = data['pickup'];
    if (pickup != null) {
      pickupAddress.value = pickup['address']?['text'] ?? "";
      pickupFeatures.value = _buildFeatures(pickup['placement']);
    } else {
      pickupAddress.value = "";
      pickupFeatures.value = [];
    }

    // Delivery Info (Move only)
    final dropoff = data['dropoff'];
    if (dropoff != null) {
      deliveryAddress.value = dropoff['address']?['text'] ?? "";
      deliveryFeatures.value = _buildFeatures(dropoff['placement']);
    } else {
      deliveryAddress.value = "";
      deliveryFeatures.value = [];
    }

    // Advertiser Info
    final user = data['user'];
    if (user != null) {
      advertiserName.value = user['name'] ?? "";
      advertiserRating.value = (user['ratingAsAdvertiser'] ?? 0).toDouble();
      if (user['avatar'] != null) {
        advertiserImage.value = ApiUrl.buildImageUrl(user['avatar'].toString());
      } else {
        advertiserImage.value = 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200';
      }
    } else {
      advertiserName.value = "";
      advertiserRating.value = 0.0;
      advertiserImage.value = 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200';
    }

    // Published time (relative)
    if (data['createdAt'] != null) {
      publishedTime.value = data['createdAt'].toString().substring(0, 10);
    } else {
      publishedTime.value = AppStrings.publishedHoursAgo.tr;
    }
  }

  List<String> _buildFeatures(Map<String, dynamic>? placement) {
    if (placement == null) return [];
    List<String> list = [];
    if (placement['placement'] == 'inside') list.add(AppStrings.insideTheHouse.tr);
    if (placement['needToMeet'] == true) list.add(AppStrings.needToMeet.tr);
    if (placement['canHelpCarry'] == true) list.add(AppStrings.canHelpCarryAtDropOff.tr);
    if (placement['fitsInElevator'] == true) list.add(AppStrings.fitsInTheElevator.tr);
    return list;
  }

  // ── Button Actions ────────────────────────────────────────────────────────
  void acceptPending() {
    AppAlerts.confirm(
      title: 'Accept Request',
      message: 'Do you want to accept this pending request?',
      onConfirm: () {
        requestStatus.value = RequestStatus.sent;
      },
      onCancel: () {
        AppAlerts.info(
          title: 'Still Pending',
          message: 'The request remains pending.',
        );
      },
    );
  }
  void onSendRequest() => requestStatus.value = RequestStatus.sent;

  void onCancelRequest() => requestStatus.value = RequestStatus.pickedUp;

  void onPickedUp() {
    if (isMove) {
      requestStatus.value = RequestStatus.delivered;
    } else {
      // Recycle — done after pickup
      requestStatus.value = RequestStatus.sent;
    }
  }

  void onDelivery() {
    // Move only
    requestStatus.value = RequestStatus.delivered;
    // Get.toNamed(RoutePath.deliveryScreen);
   AppAlerts.confirm(title: "Are you sure", message: "Are you sure, you are picked-up?", onConfirm: (){

     AppAlerts.proof(
       title: 'Proof',              // Default: 'Proof'
       message: 'Upload picture as a proof!',          // Default: 'Upload Picture As A Proof!'
       buttonLabel: 'Continue',          // Default: 'Continue'

     );


   });

  }

  void onOpenPickupMap() {
    Get.toNamed(RoutePath.showMap);


  }
  void onOpenDeliveryMap() {
    Get.toNamed(RoutePath.showMap);
  }
  void onShare() {}
  void onReportAd() {}
}