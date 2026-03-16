import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

class PickupAddressController extends GetxController {
  // ── Text field ────────────────────────────────────────────────────────────
  final TextEditingController addressController = TextEditingController();
  final RxString typedAddress = ''.obs;

  // ── Selected address ──────────────────────────────────────────────────────
  final RxString selectedAddress = ''.obs;

  // ── Recent addresses ──────────────────────────────────────────────────────
  final RxList<String> recentAddresses = <String>[
    'Abu Dhabi - 23052',
    'Abu Dhabi - 23052',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    addressController.addListener(() {
      typedAddress.value = addressController.text;
    });
  }

  void selectRecentAddress(String address) {
    selectedAddress.value = address;
    addressController.text = address;
  }

  void onChooseOnMap() {
    // TODO: Navigate to map screen
    Get.toNamed(RoutePath.showMap);
  }

  bool get isValid =>
      addressController.text.trim().isNotEmpty ||
          selectedAddress.value.isNotEmpty;

  void onContinue() {
    // if (!isValid) return;
    // // TODO: Navigate to next step

    Get.toNamed(RoutePath.placementPickup);
  }

  @override
  void onClose() {
    addressController.dispose();
    super.onClose();
  }
}