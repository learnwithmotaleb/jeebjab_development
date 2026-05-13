import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/helper/local_db/local_db.dart';
import 'package:jeebjab/helper/tost_message/show_snackbar.dart';
import 'package:jeebjab/presentation/screen/job/category_status/controller/category_status_controller.dart';

import '../../../../core/enums/post_category_type.dart';

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
    if (!isValid) {
      if (floorController.text.trim().isEmpty) {
        AppSnackBar.fail("Please enter the floor number.", title: "Required");
      } else if (doorCodeController.text.trim().isEmpty) {
        AppSnackBar.fail("Please enter the door code.", title: "Required");
      }
      return;
    }

    final bool isEditMode = Get.arguments?['isEdit'] ?? false;

    if (isEditMode) {
      Get.back();
      return;
    }

    // Get the saved enum directly
    final postCategory = SharePrefsHelper.getPostCategory();

    if (postCategory == null) return;

    // Map each enum to a route (or null if not implemented)
    final categoryRouteMap = {
      PostCategoryType.move: RoutePath.setDropOffAddress,
      PostCategoryType.recycling: RoutePath.westType,
      PostCategoryType.buyForMe: null, // TODO: add route
      PostCategoryType.giveAway: null, // TODO: add route
    };

    final route = categoryRouteMap[postCategory];

    if (route != null) {
      Get.toNamed(route);
    } else {
      // Handle unimplemented cases
      print("Route for $postCategory is not implemented yet");
    }
  }

  void onSaveAndPublish() {
    if (!isValid) {
      if (floorController.text.trim().isEmpty) {
        AppSnackBar.fail("Please enter the floor number.", title: "Required");
      } else if (doorCodeController.text.trim().isEmpty) {
        AppSnackBar.fail("Please enter the door code.", title: "Required");
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