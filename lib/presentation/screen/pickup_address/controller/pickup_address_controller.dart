import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jeebjab/core/routes/route_path.dart';
import 'package:jeebjab/helper/local_db/local_db.dart';
import 'package:jeebjab/service/google_places_service.dart';
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

  // ── Recent addresses (loaded from local DB on init) ─────────────────────
  final RxList<String> recentAddresses = <String>[].obs;

  // ── Live Places Autocomplete suggestions as the user types ───────────────
  final RxList<AutocompletePrediction> predictions =
      <AutocompletePrediction>[].obs;
  final RxBool isSearching = false.obs;
  Timer? _debounce;
  // Set right before we programmatically overwrite addressController.text
  // (after picking a suggestion) so that write doesn't re-trigger a search.
  bool _suppressNextSearch = false;

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

      if (_suppressNextSearch) {
        _suppressNextSearch = false;
        return;
      }
      _onQueryChanged(addressController.text);
    });

    _loadRecentAddresses();
  }

  void _onQueryChanged(String text) {
    if (text.trim().isEmpty) {
      predictions.clear();
      isSearching.value = false;
      return;
    }
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      isSearching.value = true;
      final results = await GooglePlacesService.instance.autocomplete(text);
      predictions.assignAll(results);
      isSearching.value = false;
    });
  }

  /// User tapped a suggestion from the dropdown — resolve its coordinates
  /// via Place Details so the real lat/lng (not a placeholder) gets saved.
  Future<void> selectPrediction(AutocompletePrediction prediction) async {
    _suppressNextSearch = true;
    addressController.text = prediction.fullText;
    selectedAddress.value = prediction.fullText;
    selectedAddressIndex.value = -1;
    predictions.clear();

    final details =
        await GooglePlacesService.instance.placeDetails(prediction.placeId);
    if (details != null) {
      selectedLat.value = details.lat;
      selectedLng.value = details.lng;
    }
  }

  void clearPredictions() => predictions.clear();

  void _loadRecentAddresses() {
    final stored = SharePrefsHelper.getRecentPickupAddresses();
    recentAddresses.assignAll(stored);
  }

  /// Saves the confirmed address to the pickup recent list (max 5, deduplicated).
  void _saveToRecent(String address) {
    final trimmed = address.trim();
    if (trimmed.isEmpty) return;
    final List<String> list = List<String>.from(recentAddresses);
    list.remove(trimmed);
    list.insert(0, trimmed);
    if (list.length > 5) list.removeRange(5, list.length);
    recentAddresses.assignAll(list);
    SharePrefsHelper.saveRecentPickupAddresses(list);
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

    // Save whichever address is confirmed (map pick or manual text)
    final String toSave = selectedAddress.value.isNotEmpty
        ? selectedAddress.value
        : addressController.text.trim();
    _saveToRecent(toSave);

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
    final String toSave = selectedAddress.value.isNotEmpty
        ? selectedAddress.value
        : addressController.text.trim();
    _saveToRecent(toSave);
    Get.back(result: true); // returns true to trigger publish
  }

  @override
  void onClose() {
    _debounce?.cancel();
    addressController.dispose();
    super.onClose();
  }
}