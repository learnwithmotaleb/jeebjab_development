import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/utils/assets_image/app_images.dart';
import 'package:jeebjab/widget/app_confirmation_alert.dart';

class NotificationDetailsController extends GetxController {
  // Observable variables
  RxString itemType = 'Move'.obs;
  RxString itemSubtype = 'Bike'.obs;
  RxString itemDate = '22 November 2025'.obs;
  RxString trackingNumber = 'EXD33264841'.obs;
  RxString imagePath = AppImages.trackingImage.obs;
  RxString status = 'pending'.obs; // "pending", "in_transit", "delivered"

  RxString driverName = 'Fawaz Georges'.obs;
  RxString driverPhone = '+92120 003221'.obs;
  RxString driverImage = AppImages.profileImage.obs;
  RxDouble driverRating = 4.5.obs;
  RxBool showAcceptButton = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Load notification data here
    loadNotificationDetails();
  }

  void loadNotificationDetails() {
    // TODO: Load data from API or passed arguments
    // Get arguments if passed from previous screen
    if (Get.arguments != null) {
      itemType.value = Get.arguments['itemType'] ?? 'Move';
      itemSubtype.value = Get.arguments['itemSubtype'] ?? 'Bike';
      itemDate.value = Get.arguments['itemDate'] ?? '22 November 2025';
      trackingNumber.value = Get.arguments['trackingNumber'] ?? 'EXD33264841';
      imagePath.value = Get.arguments['imagePath'] ?? 'assets/bicycle.png';
      status.value = Get.arguments['status'] ?? 'pending';
      driverName.value = Get.arguments['driverName'] ?? 'Fawaz Georges';
      driverPhone.value = Get.arguments['driverPhone'] ?? '+92120 003221';
      driverImage.value = Get.arguments['driverImage'] ?? 'assets/driver.png';
      driverRating.value = Get.arguments['driverRating'] ?? 4.5;
      showAcceptButton.value = Get.arguments['showAcceptButton'] ?? true;
    }
  }

  // Action handlers
  void onLiveTrackingPressed() {
    // TODO: Navigate to live tracking screen
    print('Live tracking pressed');
  }

  void onRateServicePressed() {
    // TODO: Show rating dialog
    print('Rate service pressed');
  }

  void onDeletePressed() {
    // TODO: Show delete confirmation dialog
    print('Delete pressed');
  }

  void onReschedulePressed() {
    // TODO: Show reschedule dialog
    print('Reschedule pressed');
  }

  void onMessagePressed() {
   Get.toNamed(RoutePath.chat);
    print('Message pressed');
  }

  void onAcceptPressed(BuildContext context) {
    AppSuccessAlert.show(
      context: context,
      message: "Request Successfully Accepted",
    );
    print('Accept pressed');
  }

}