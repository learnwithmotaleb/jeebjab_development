import 'package:get/get.dart';

import '../../../../../../../core/routes/route_path.dart';
import '../../../../../../../service/api_service.dart';
import '../../../../../../../service/api_url.dart';
import '../../../../../../../utils/static_strings/static_strings.dart';
import '../../../../../../../widget/app_share.dart';

class TaskDetailsController extends GetxController{

  final ApiClient _apiClient = ApiClient();

  // ── State ─────────────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // ── Item Info ─────────────────────────────────────────────────────────────
  RxString itemType = "".obs;
  RxString itemSubtype = "".obs;
  RxString publishedTime = "".obs;
  RxDouble itemPrice = 0.0.obs;

  // ── Meta ──────────────────────────────────────────────────────────────────
  RxString size = "".obs;
  RxString preferredPickupTime = "".obs;

  // ── Carousel Images ───────────────────────────────────────────────────────
  RxList<String> images = <String>[].obs;

  // ── Pick-Up Info ──────────────────────────────────────────────────────────
  RxString pickupAddress = "".obs;
  RxList<String> pickupFeatures = <String>[].obs;

  // ── Delivery Info ─────────────────────────────────────────────────────────
  RxString deliveryAddress = "".obs;
  RxList<String> deliveryFeatures = <String>[].obs;

  // ── Advertiser Info ───────────────────────────────────────────────────────
  RxString advertiserName = "".obs;
  RxDouble advertiserRating = 0.0.obs;
  RxString advertiserImage = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      final String? id = args['id'];

      // If we have some data passed from the previous screen, show it while loading
      itemType.value = args['itemType'] ?? "";
      itemSubtype.value = args['itemSubtype'] ?? "";
      itemPrice.value = (args['price'] ?? 0).toDouble();

      if (id != null) {
        fetchPostDetails(id);
      }
    }
  }

  Future<void> fetchPostDetails(String id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await _apiClient.get(url: ApiUrl.getTaskDetails(id), isToken: true);

      if (response.statusCode == 200) {
        final data = response.body['data'];
        _mapPostData(data);
      } else {
        errorMessage.value = response.statusText ?? "Failed to load post details";
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }

  void _mapPostData(Map<String, dynamic> data) {
    itemType.value = data['title'] ?? "";

    // For subtype/category, use wasteType if recycling, else use type
    if (data['type'] == 'recycling' && data['wasteType'] != null && (data['wasteType'] as List).isNotEmpty) {
      itemSubtype.value = (data['wasteType'] as List).join(', ');
    } else {
      itemSubtype.value = data['type']?.toString().capitalizeFirst ?? "";
    }

    itemPrice.value = (data['price'] ?? 0).toDouble();
    size.value = data['size']?.toString().capitalizeFirst ?? "";

    // Date/Time
    final dt = data['dateTimeSlot'];
    if (dt != null) {
      final scheduledDate = dt['scheduledDate'] ?? "";
      final scheduledTime = dt['scheduledTime'] ?? "";
      preferredPickupTime.value = scheduledDate != "" ? "$scheduledDate, $scheduledTime" : dt['slotType'] ?? "";
    }

    // Images
    if (data['photos'] != null) {
      images.value = (data['photos'] as List).map((path) => ApiUrl.buildImageUrl(path.toString())).toList();
    }

    // Pickup
    final pickup = data['pickup'];
    if (pickup != null) {
      pickupAddress.value = pickup['address']?['text'] ?? "";
      pickupFeatures.value = _buildFeatures(pickup['placement']);
    }

    // Delivery
    final dropoff = data['dropoff'];
    if (dropoff != null) {
      deliveryAddress.value = dropoff['address']?['text'] ?? "";
      deliveryFeatures.value = _buildFeatures(dropoff['placement']);
    } else {
      deliveryAddress.value = "";
      deliveryFeatures.value = [];
    }

    // Advertiser
    final user = data['user'];
    if (user != null) {
      advertiserName.value = user['name'] ?? "";
      advertiserRating.value = (user['ratingAsAdvertiser'] ?? 0).toDouble();
      if (user['avatar'] != null) {
        advertiserImage.value = ApiUrl.buildImageUrl(user['avatar'].toString());
      }
    }

    // Published time (relative) - for now just show formatted createdAt
    if (data['createdAt'] != null) {
      publishedTime.value = data['createdAt'].toString().substring(0, 10);
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

  void onOpenPickupMap() {
    Get.toNamed(RoutePath.showMap);
  }

  void onOpenDeliveryMap() {
    Get.toNamed(RoutePath.showMap);
  }

  void onShare() {
    AppShare.shareApp();
  }

  void onReportAd() {
    // TODO: Report ad
  }



}