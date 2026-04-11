import 'package:get/get.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';

class DeliveryProof {
  final String imageUrl;
  final String category;
  final String title;
  final String price;
  final String currency;
  final String description;
  final String size;
  final String deliveryLocation;
  final String deliveryTime;
  final String publishedTime;

  DeliveryProof({
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.price,
    required this.currency,
    required this.description,
    required this.size,
    required this.deliveryLocation,
    required this.deliveryTime,
    required this.publishedTime,
  });
}

class DeliveryController extends GetxController {
  // ── Delivery Proof Data ────────────────────────────────────────────────
  final RxBool isDeliveryMarked = false.obs;

  late DeliveryProof deliveryProof;

  @override
  void onInit() {
    super.onInit();
    _initializeDeliveryData();
  }

  void _initializeDeliveryData() {
    deliveryProof = DeliveryProof(
      imageUrl:
      'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=500',
      category: 'Move',
      title: 'Ducati Bike',
      price: '85',
      currency: 'SAR',
      description:
      'To Manage Your Google Play Payment Screen, Open The Play Store App. Tap Your Profile Icon, And Select Payments & Subscriptions. From Here, You Can Manage Payment Methods (Credit Cards, PayPal, Balance), Update Billing And Subscription Info, And View Order History. You Can Also Add Backup Payment Methods For Smoother Transactions.',
      size: 'Medium',
      deliveryLocation: 'Level Shoes District, Dubai Mall',
      deliveryTime: '04:30 Pm',
      publishedTime: 'Published 3 Hours Ago',
    );
  }

  // ── Mark as Delivered ──────────────────────────────────────────────────
  void markAsDelivered() {
    isDeliveryMarked.value = true;
    AppAlerts.success(message: "Success Delivery");
  }
}