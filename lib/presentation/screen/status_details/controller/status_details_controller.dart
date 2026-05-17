import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/service/api_service.dart';
import 'package:jeebjab/service/api_url.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/widget/app_confirmation_alert.dart';
import 'package:jeebjab/widget/confirmataion_alert.dart';

import '../../../../helper/tost_message/show_snackbar.dart';
import '../../../../utils/static_strings/static_strings.dart';
import '../../../../widget/custom_alert.dart';

class StatusDetailsController extends GetxController {
  final ApiClient _apiClient = ApiClient();

  // ── State ─────────────────────────────────────────────────────────────────
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  // ── Item Info ─────────────────────────────────────────────────────────────
  RxString postId = "".obs;
  RxString itemType = "".obs;
  RxString itemSubtype = "".obs;
  RxString itemDate = "".obs;
  RxString trackingNumber = "".obs;
  RxString imagePath = "".obs;
  RxString status = "pending".obs; // "pending", "active", "completed"

  // ── Driver Info ───────────────────────────────────────────────────────────
  RxString driverName = "".obs;
  RxString driverPhone = "".obs;
  RxString driverImage = "".obs;
  RxDouble driverRating = 0.0.obs;
  RxBool showAcceptButton = false.obs;

  // Optional: List of offers/bids for pending status
  RxList<Map<String, dynamic>> offers = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    if (Get.arguments != null) {
      final args = Get.arguments as Map<String, dynamic>;
      final String? id = args['id'];
      
      // Temporary mapping from arguments to show something while loading
      postId.value = id ?? "";
      itemType.value = args['itemType'] ?? "";
      itemSubtype.value = args['itemSubtype'] ?? "";
      status.value = args['status'] ?? "pending";

      if (id != null) {
        fetchStatusDetails(id);
      }
    }
  }

  Future<void> fetchStatusDetails(String id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      
      final response = await _apiClient.get(url: ApiUrl.getPostDetails(id), isToken: true);
      
      if (response.statusCode == 200) {
        final data = response.body['data'];
        _mapPostData(data);
      } else {
        errorMessage.value = response.statusText ?? "Failed to load status details";
      }
    } catch (e) {
      errorMessage.value = "An error occurred: $e";
    } finally {
      isLoading.value = false;
    }
  }

  void _mapPostData(Map<String, dynamic> data) {
    postId.value = data['_id'] ?? "";
    itemType.value = data['title'] ?? "";
    
    if (data['type'] == 'recycling' && data['wasteType'] != null && (data['wasteType'] as List).isNotEmpty) {
      itemSubtype.value = (data['wasteType'] as List).join(', ');
    } else {
      itemSubtype.value = data['type']?.toString().capitalizeFirst ?? "";
    }
    
    trackingNumber.value = data['_id']?.toString().substring(0, 10).toUpperCase() ?? "";
    status.value = data['status'] ?? "pending";
    
    // Date
    final dt = data['dateTimeSlot'];
    if (dt != null) {
      itemDate.value = dt['scheduledDate'] ?? data['createdAt']?.toString().substring(0, 10) ?? "";
    } else {
      itemDate.value = data['createdAt']?.toString().substring(0, 10) ?? "";
    }

    // Image
    if (data['photos'] != null && (data['photos'] as List).isNotEmpty) {
      imagePath.value = ApiUrl.buildImageUrl(data['photos'][0].toString());
    }

    // Driver
    final assignedDriver = data['assignedDriver'];
    if (assignedDriver != null) {
      driverName.value = assignedDriver['name'] ?? "";
      driverPhone.value = assignedDriver['phoneNumber'] ?? "";
      if (assignedDriver['avatar'] != null) {
        driverImage.value = ApiUrl.buildImageUrl(assignedDriver['avatar'].toString());
      }
      driverRating.value = (assignedDriver['rating'] ?? 0.0).toDouble();
      showAcceptButton.value = false;
    } else {
      // If pending, we might have offers (bids)
      // This depends on whether the API returns offers in the post details
      // For now, let's assume we might get them or leave them empty
      showAcceptButton.value = status.value == 'pending';
    }
  }

  void onLiveTrackingPressed() {
    Get.toNamed(RoutePath.showMap);
  }

  void onRateServicePressed() {
    AppAlerts.deliveryReview(
      onSubmit: (rating, feedback) {
        print('Rating: $rating, Feedback: $feedback');
        // Handle rating logic here
        AppSnackBar.success("Thank you for your feedback!");
      },
    );
  }

  void onDeletePressed() {
    AppAlerts.deleteAd(
      onYes: () {
        print('Delete confirmed');
        // Add actual delete logic here
      },
    );
  }

  void onReschedulePressed() {
    Get.toNamed(RoutePath.pickupDateTime);
  }

  void onMessagePressed() {
    if (status.value == 'completed') {
      AppSnackBar.info("Chat is disabled for completed orders.");
      return;
    }
    Get.toNamed(RoutePath.chat);
  }

  void onAcceptPressed(BuildContext context) {
    AppSuccessAlert.show(
      context: context,
      message: "Request Successfully Accepted",
    );
    // After acceptance, status might change to active
    status.value = "active"; 
    showAcceptButton.value = false;
  }
}