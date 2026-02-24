import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';

class PickupFloorController extends GetxController {
  // ── Text Controllers ──────────────────────────────────────────────────────
  final TextEditingController floorController = TextEditingController();
  final TextEditingController doorCodeController = TextEditingController();
  final TextEditingController otherInfoController = TextEditingController();

  // ── Fits In Elevator toggle ───────────────────────────────────────────────
  final RxBool fitsInElevator = false.obs;

  void toggleElevator() => fitsInElevator.value = !fitsInElevator.value;

  bool get isValid =>
      floorController.text.trim().isNotEmpty &&
          doorCodeController.text.trim().isNotEmpty;

  void onContinue() {
    // if (!isValid) return;
    // // TODO: navigate to next step

    Get.toNamed(RoutePath.setDropOffAddress);
  }

  @override
  void onClose() {
    floorController.dispose();
    doorCodeController.dispose();
    otherInfoController.dispose();
    super.onClose();
  }
}