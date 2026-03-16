import 'package:get/get.dart';
import 'package:jeebjab/utils/static_strings/static_strings.dart';

class OverviewController extends GetxController {

  // ── Service Info ──────────────────────────────────────────────────────────
  RxString serviceType = AppStrings.move.obs;
  RxString serviceTitle = "Move Bike To Another City".obs; // dynamic/API data
  RxString description = AppStrings.empty.obs;
  RxString sizeOfProduct = AppStrings.medium.obs;

  // ── Pickup Info ───────────────────────────────────────────────────────────
  RxString pickupAddress = "Dubai Downtown".obs;   // dynamic/API data
  RxString pickupPlacement = AppStrings.insideMeetCanHelp.obs;
  RxString pickupFloor = "6 / A 95".obs;           // dynamic/API data

  // ── Drop Info ─────────────────────────────────────────────────────────────
  RxString dropAddress = "Dubai Downtown".obs;     // dynamic/API data
  RxString dropPlacement = AppStrings.outsideNoMeet.obs;
  RxString dropFloor = "6 / A 95".obs;             // dynamic/API data

  // ── Date & Price ──────────────────────────────────────────────────────────
  RxString dateTime = AppStrings.anytime.obs;
  RxString price = "120 SAR".obs;                  // dynamic/API data

  // ── Toggles ───────────────────────────────────────────────────────────────
  RxBool termsAccepted = false.obs;

  // ── Acknowledgements ──────────────────────────────────────────────────────
  RxBool acknowledgePickup = false.obs;
  RxBool correspondsWithPictures = false.obs;
  RxBool notToxicOrHarmful = false.obs;
  RxBool willBeAvailableForPickup = false.obs;
}