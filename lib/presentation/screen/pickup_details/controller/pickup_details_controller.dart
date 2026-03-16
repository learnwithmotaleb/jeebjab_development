import 'package:get/get.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

import '../../../../core/routes/route_path.dart';
import '../../../../widget/app_share.dart';

class PickupDetailsController extends GetxController {
  // ── Item Info ─────────────────────────────────────────────────────────────
  RxString itemType = AppStrings.moveDummy.obs;
  RxString itemSubtype = AppStrings.bikeDummy.obs;
  RxString publishedTime = AppStrings.publishedHoursAgo.obs;
  RxDouble itemPrice = 156.0.obs;

  // ── Meta ──────────────────────────────────────────────────────────────────
  RxString size = AppStrings.medium.obs;
  RxString preferredPickupTime = '10:30 - 12:30'.obs;

  // ── Carousel Images ───────────────────────────────────────────────────────
  RxList<String> images = <String>[
    'https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=600',
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600',
    'https://images.unsplash.com/photo-1571068316344-75bc76f77890?w=600',
  ].obs;

  // ── Pick-Up Info ──────────────────────────────────────────────────────────
  RxString pickupAddress = 'Abu Dhabi - 23052, Level 2, Door 6'.obs;
  RxList<String> pickupFeatures = <String>[].obs;

  // ── Delivery Info ─────────────────────────────────────────────────────────
  RxString deliveryAddress = 'Abu Dhabi - 23052'.obs;
  RxList<String> deliveryFeatures = <String>[].obs;

  // ── Advertiser Info ───────────────────────────────────────────────────────
  RxString advertiserName = 'Faris Shafi'.obs;
  RxDouble advertiserRating = 4.7.obs;
  RxString advertiserImage =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200'.obs;

  @override
  void onInit() {
    super.onInit();
    _initFeatures();
    _loadArguments();
  }

  // ── Build translated feature lists ───────────────────────────────────────
  void _initFeatures() {
    pickupFeatures.value = [
      AppStrings.insideTheHouse.tr,
      AppStrings.needToMeet.tr,
      AppStrings.canHelpCarryAtDropOff.tr,
      AppStrings.fitsInTheElevator.tr,
    ];
    deliveryFeatures.value = [
      AppStrings.insideTheHouse.tr,
      AppStrings.needToMeet.tr,
      AppStrings.canHelpCarryAtDropOff.tr,
      AppStrings.fitsInTheElevator.tr,
    ];
  }

  void _loadArguments() {
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      itemType.value = args['itemType'] ?? AppStrings.moveDummy.tr;
      itemSubtype.value = args['itemSubtype'] ?? AppStrings.bikeDummy.tr;
      itemPrice.value = (args['price'] ?? 156).toDouble();
      size.value = args['size'] ?? AppStrings.medium.tr;
      preferredPickupTime.value = args['pickupTime'] ?? '10:30 - 12:30';
      pickupAddress.value = args['pickupAddress'] ?? 'Abu Dhabi - 23052';
      deliveryAddress.value = args['deliveryAddress'] ?? 'Abu Dhabi - 23052';
      if (args['images'] != null) {
        images.value = List<String>.from(args['images']);
      }
    }
  }

  void onOpenPickupMap() {
    Get.toNamed(RoutePath.showMap);
  }

  void onOpenDeliveryMap() {
    Get.toNamed(RoutePath.showMap);
  }

  void onShare() {
    print("Sharing Your App.");
    AppShare.shareApp();

  }

  void onReportAd() {
    // TODO: Report ad
  }
}