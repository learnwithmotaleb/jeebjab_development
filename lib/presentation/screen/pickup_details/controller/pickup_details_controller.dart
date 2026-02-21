import 'package:get/get.dart';

class PickupDetailsController extends GetxController {
  // ── Item Info ─────────────────────────────────────────────────────────────
  RxString itemType = 'Move'.obs;
  RxString itemSubtype = 'Bike'.obs;
  RxString publishedTime = 'Published 3 Hours Ago'.obs;
  RxDouble itemPrice = 156.0.obs;

  // ── Meta ──────────────────────────────────────────────────────────────────
  RxString size = 'Medium'.obs;
  RxString preferredPickupTime = '10:30 - 12:30'.obs;

  // ── Carousel Images ───────────────────────────────────────────────────────
  RxList<String> images = <String>[
    'https://images.unsplash.com/photo-1485965120184-e220f721d03e?w=600',
    'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=600',
    'https://images.unsplash.com/photo-1571068316344-75bc76f77890?w=600',
  ].obs;

  // ── Pick-Up Info ──────────────────────────────────────────────────────────
  RxString pickupAddress = 'Abu Dhabi - 23052, Level 2, Door 6'.obs;
  RxList<String> pickupFeatures = <String>[
    'Inside The House',
    'Need To Meet',
    'Can Help Carry At Drop-Off',
    'Fits In The Elevator',
  ].obs;

  // ── Delivery Info ─────────────────────────────────────────────────────────
  RxString deliveryAddress = 'Abu Dhabi - 23052'.obs;
  RxList<String> deliveryFeatures = <String>[
    'Inside The House',
    'Need To Meet',
    'Can Help Carry At Drop-Off',
    'Fits In The Elevator',
  ].obs;

  // ── Advertiser Info ───────────────────────────────────────────────────────
  RxString advertiserName = 'Faris Shafi'.obs;
  RxDouble advertiserRating = 4.7.obs;
  RxString advertiserImage =
      'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      itemType.value = args['itemType'] ?? 'Move';
      itemSubtype.value = args['itemSubtype'] ?? 'Bike';
      itemPrice.value = (args['price'] ?? 156).toDouble();
      size.value = args['size'] ?? 'Medium';
      preferredPickupTime.value = args['pickupTime'] ?? '10:30 - 12:30';
      pickupAddress.value = args['pickupAddress'] ?? 'Abu Dhabi - 23052';
      deliveryAddress.value = args['deliveryAddress'] ?? 'Abu Dhabi - 23052';
      if (args['images'] != null) {
        images.value = List<String>.from(args['images']);
      }
    }
  }

  void onOpenPickupMap() {
    // TODO: Navigate to map with pickup location
  }

  void onOpenDeliveryMap() {
    // TODO: Navigate to map with delivery location
  }

  void onShare() {
    // TODO: Share post
  }

  void onReportAd() {
    // TODO: Report ad
  }
}