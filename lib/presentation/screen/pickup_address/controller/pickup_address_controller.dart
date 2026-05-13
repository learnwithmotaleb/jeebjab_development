import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import '../../../../helper/tost_message/show_snackbar.dart';

class PickupAddressController extends GetxController {
  // ── Text field ────────────────────────────────────────────────────────────
  final TextEditingController addressController = TextEditingController();
  final RxString typedAddress = ''.obs;

  // ── Selected address (index-based to avoid duplicate-value bug) ───────────
  final RxInt selectedAddressIndex = (-1).obs;
  final RxString selectedAddress = ''.obs;

  // ── Recent addresses ──────────────────────────────────────────────────────
  final RxList<String> recentAddresses = <String>[
    'Abu Dhabi - 23052',
    'Dubai Downtown - 10001',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    
    addressController.addListener(() {
      typedAddress.value = addressController.text;
      // Clear list selection when user types manually
      if (selectedAddressIndex.value != -1 &&
          addressController.text != selectedAddress.value) {
        selectedAddressIndex.value = -1;
        selectedAddress.value = '';
      }
    });
  }

  void selectRecentAddress(int index, String address) {
    selectedAddressIndex.value = index;
    selectedAddress.value = address;
    addressController.text = address;
  }

  void onChooseOnMap() {
    Get.toNamed(RoutePath.showMap);
  }

  bool get isValid =>
      addressController.text.trim().isNotEmpty ||
      selectedAddress.value.isNotEmpty;

  void onContinue() {
    if (!isValid) {
      AppSnackBar.fail("Please enter or select a pickup address.",
          title: "Required");
      return;
    }
    
    final bool isEditMode = Get.arguments?['isEdit'] ?? false;

    if (isEditMode) {
      Get.back(); // returns null, so just updates
    } else {
      Get.toNamed(RoutePath.placementPickup);
    }
  }

  void onSaveAndPublish() {
    if (!isValid) {
      AppSnackBar.fail("Please enter or select a pickup address.",
          title: "Required");
      return;
    }
    Get.back(result: true); // returns true to trigger publish
  }

  @override
  void onClose() {
    addressController.dispose();
    super.onClose();
  }
}