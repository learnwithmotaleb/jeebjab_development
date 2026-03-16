import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

// ── Category types ─────────────────────────────────────────────────────────
enum PostCategory { move, recycle, buyForMe, giveAway }

// ── Request status flow ────────────────────────────────────────────────────
// Move:    none → sent → pickedUp → delivered
// Recycle: none → sent → pickedUp
enum RequestStatus { none, sent, pickedUp, delivered }

class CategoryStatusController extends GetxController {
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

  // ── Button Actions ────────────────────────────────────────────────────────
  void onSendRequest() => requestStatus.value = RequestStatus.delivered;

  void onCancelRequest() => requestStatus.value = RequestStatus.delivered;

  void onPickedUp() {
    if (isMove) {
      requestStatus.value = RequestStatus.delivered;
    } else {
      // Recycle — done after pickup
      requestStatus.value = RequestStatus.delivered;
    }
  }

  void onDelivery() {
    // Move only
    requestStatus.value = RequestStatus.delivered;
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