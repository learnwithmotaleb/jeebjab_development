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

  // ── Selected coordinates (populated when user picks from map) ─────────────
  final RxDouble selectedLat = 0.0.obs;
  final RxDouble selectedLng = 0.0.obs;

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
    // Clear any previously-stored map coordinates when a recent address is tapped
    selectedLat.value = 0.0;
    selectedLng.value = 0.0;
  }

  /// Opens the map screen and awaits the confirmed location result.
  /// If the user picks a location and taps "Confirm Location", the returned
  /// map   { address, latitude, longitude }   is applied to this controller.
  Future<void> onChooseOnMap() async {
    // Pass any already-selected pin so the map opens at the right spot.
    final dynamic result = await Get.toNamed(
      RoutePath.showMap,
      arguments: {
        'address': selectedAddress.value,
        'latitude': selectedLat.value,
        'longitude': selectedLng.value,
      },
    );

    if (result != null && result is Map) {
      final String address = (result['address'] as String?) ?? '';
      final double lat =
          (result['latitude'] as num?)?.toDouble() ?? 0.0;
      final double lng =
          (result['longitude'] as num?)?.toDouble() ?? 0.0;

      if (address.isNotEmpty) {
        selectedAddress.value = address;
        selectedLat.value = lat;
        selectedLng.value = lng;
        // Populate text field so the user can see the chosen address
        addressController.text = address;
        // Deselect any recent-address card — map pick takes precedence
        selectedAddressIndex.value = -1;
      }
    }
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