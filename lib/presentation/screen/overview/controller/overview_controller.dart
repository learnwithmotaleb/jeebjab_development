import 'package:get/get.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class OverviewController extends GetxController {

  // ── Service Info ──────────────────────────────────────────────────────────
  RxString serviceType = AppStrings.move.obs;
  RxString serviceTitle = "Move Bike To Another City".obs;
  RxString description = AppStrings.empty.obs;
  RxString sizeOfProduct = AppStrings.medium.obs;

  // ── Pickup Info ───────────────────────────────────────────────────────────
  RxString pickupAddress = "Dubai Downtown".obs;
  RxString pickupPlacement = AppStrings.insideMeetCanHelp.obs;
  RxString pickupFloor = "6 / A 95".obs;

  // ── Drop Info ─────────────────────────────────────────────────────────────
  RxString dropAddress = "Dubai Downtown".obs;
  RxString dropPlacement = AppStrings.outsideNoMeet.obs;
  RxString dropFloor = "6 / A 95".obs;

  // ── Date & Price ──────────────────────────────────────────────────────────
  RxString dateTime = AppStrings.anytime.obs;
  RxString price = "120 SAR".obs;

  // ── Acknowledgement (Main Checkbox) ───────────────────────────────────────
  RxBool acknowledgePickup = false.obs;

  // ── Optional Sub Conditions (for future use) ──────────────────────────────
  RxBool correspondsWithPictures = false.obs;
  RxBool notToxicOrHarmful = false.obs;
  RxBool willBeAvailableForPickup = false.obs;

  // ── Publish حالة ──────────────────────────────────────────────────────────
  /// ✅ Current logic (based on your UI)
  bool get canPublish => acknowledgePickup.value;

  /*
  /// 🔥 Future Advanced Logic (if needed)
  bool get canPublish =>
      acknowledgePickup.value &&
      correspondsWithPictures.value &&
      notToxicOrHarmful.value &&
      willBeAvailableForPickup.value;
  */

  // ── Toggle Method (Clean Code) ────────────────────────────────────────────
  void toggleAcknowledge(bool value) {
    acknowledgePickup.value = value;
  }
}