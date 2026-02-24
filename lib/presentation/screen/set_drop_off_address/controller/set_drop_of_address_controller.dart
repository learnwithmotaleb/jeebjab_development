import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

class SetDropOfAddressController extends GetxController {
  final TextEditingController addressController = TextEditingController();
  final RxString selectedAddress = ''.obs;

  final RxList<String> recentAddresses = <String>[
    'Abu Dhabi - 23052',
    'Abu Dhabi - 23052',
  ].obs;

  @override
  void onInit() {
    super.onInit();
    addressController.addListener(() {
      selectedAddress.value = '';
    });
  }

  void selectRecentAddress(String address) {
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
    // if (!isValid) return;
    // // TODO: Navigate to next step
    Get.toNamed(RoutePath.placementDropOff);
  }

  @override
  void onClose() {
    addressController.dispose();
    super.onClose();
  }
}