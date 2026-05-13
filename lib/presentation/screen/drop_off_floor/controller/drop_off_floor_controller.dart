import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:jeebjab/helper/tost_message/show_snackbar.dart';

import '../../../../core/routes/route_path.dart';

class DropOffFloorController extends GetxController{

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
    if (!isValid) {
      if (floorController.text.trim().isEmpty) {
        AppSnackBar.fail("Please enter the drop-off floor number.", title: "Required");
      } else if (doorCodeController.text.trim().isEmpty) {
        AppSnackBar.fail("Please enter the drop-off door code.", title: "Required");
      }
      return;
    }

    final bool isEditMode = Get.arguments?['isEdit'] ?? false;

    if (isEditMode) {
      Get.back();
    } else {
      Get.toNamed(RoutePath.iWillPay);
    }
  }

  void onSaveAndPublish() {
    if (!isValid) {
      if (floorController.text.trim().isEmpty) {
        AppSnackBar.fail("Please enter the drop-off floor number.", title: "Required");
      } else if (doorCodeController.text.trim().isEmpty) {
        AppSnackBar.fail("Please enter the drop-off door code.", title: "Required");
      }
      return;
    }
    Get.back(result: true);
  }

  @override
  void onClose() {
    floorController.dispose();
    doorCodeController.dispose();
    otherInfoController.dispose();
    super.onClose();
  }


}