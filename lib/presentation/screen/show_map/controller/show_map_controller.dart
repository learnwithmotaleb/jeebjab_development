import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:jeebjab/service/google_places_service.dart';

export 'package:jeebjab/service/google_places_service.dart'
    show AutocompletePrediction;

class ShowMapController extends GetxController {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  // Inject at build time: flutter run --dart-define=GOOGLE_MAPS_API_KEY=xxxx
  String get _googleMapsApiKey {
    const key = String.fromEnvironment('GOOGLE_MAPS_API_KEY');
    return key.isNotEmpty ? key : 'AIzaSyBCYhLFH245ocR2fJj6GnSzSMfC9X90mv0';
  }

  // State variables — always google_maps_flutter's LatLng, never the SDK's.
  var selectedPosition = const LatLng(23.746466, 90.376015).obs;
  var selectedAddress = "House 10, Road 5, Dhanmondi, Dhaka, Bangladesh".obs;
  var isLoadingLocation = false.obs;
  var searchText = "".obs;
  var predictions = <AutocompletePrediction>[].obs;
  var isSearching = false.obs;

  // Whether the caller pre-seeded a valid position via arguments.
  bool _hasIncomingPosition = false;

  // Default initial position (e.g., San Francisco / Googleplex or Dhaka)
  CameraPosition get initialCameraPosition => CameraPosition(
        target: selectedPosition.value,
        zoom: 15,
      );

  @override
  void onInit() {
    super.onInit();
    assert(
      _googleMapsApiKey.isNotEmpty,
      'GOOGLE_MAPS_API_KEY was not provided. '
          'Run with --dart-define=GOOGLE_MAPS_API_KEY=your_key',
    );

    // Apply any position/address passed by the calling screen BEFORE
    // deciding whether to fetch the live GPS location.
    _applyIncomingArguments();

    // Only auto-jump to device location when the caller did NOT pre-seed a pin.
    if (!_hasIncomingPosition) {
      _getCurrentLocation();
    }
  }

  /// Reads Get.arguments and pre-populates the pin + address / search bar
  /// when the PickupAddressScreen already has a selection.
  void _applyIncomingArguments() {
    final dynamic args = Get.arguments;
    if (args is! Map) return;

    final double lat = (args['latitude'] as num?)?.toDouble() ?? 0.0;
    final double lng = (args['longitude'] as num?)?.toDouble() ?? 0.0;
    final String addr = (args['address'] as String?) ?? '';

    if (lat != 0.0 && lng != 0.0) {
      selectedPosition.value = LatLng(lat, lng);
      _hasIncomingPosition = true;
    }

    if (addr.isNotEmpty) {
      selectedAddress.value = addr;
      searchText.value = addr;
    }
  }

  @override
  void onClose() {
    _debounce?.cancel();
    super.onClose();
  }

  void onMapCreated(GoogleMapController controller) {
    if (!mapController.isCompleted) {
      mapController.complete(controller);

      // If we opened the map with a pre-seeded position, animate the camera
      // there once the map is ready (initialCameraPosition already points
      // there, but animateCamera makes the transition explicit).
      if (_hasIncomingPosition) {
        moveToLocation(selectedPosition.value);
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    isLoadingLocation.value = true;
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Location Error", "Location services are disabled.");
        isLoadingLocation.value = false;
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Location Error", "Location permissions are denied.");
          isLoadingLocation.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
            "Location Error", "Location permissions are permanently denied.");
        isLoadingLocation.value = false;
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high),
      );

      final latLng = LatLng(position.latitude, position.longitude);
      await updateMarkerPosition(latLng);
      await moveToLocation(latLng);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoadingLocation.value = false;
    }
  }

  Future<void> moveToLocation(LatLng latLng) async {
    final controller = await mapController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: latLng, zoom: 16),
    ));
  }

  Future<void> updateMarkerPosition(LatLng position) async {
    selectedPosition.value = position;
    await _getAddressFromLatLng(position);
  }

  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        // Format address like: House 10, Road 5, Dhanmondi, Dhaka, Bangladesh
        List<String> addressParts = [];
        if (place.street != null && place.street!.isNotEmpty) {
          addressParts.add(place.street!);
        }
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          addressParts.add(place.subLocality!);
        }
        if (place.locality != null && place.locality!.isNotEmpty) {
          addressParts.add(place.locality!);
        }
        if (place.country != null && place.country!.isNotEmpty) {
          addressParts.add(place.country!);
        }

        selectedAddress.value = addressParts.join(', ');
      } else {
        selectedAddress.value = "Unknown Location";
      }
    } catch (e) {
      selectedAddress.value = "Unknown Location";
    }
  }

  void onSearchTextChanged(String text) {
    searchText.value = text;
    if (text.isEmpty) {
      predictions.clear();
      isSearching.value = false;
      return;
    }
    _fetchPredictions(text);
  }

  Timer? _debounce;

  void _fetchPredictions(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      isSearching.value = true;
      final results = await GooglePlacesService.instance.autocomplete(text);
      predictions.assignAll(results);
      isSearching.value = false;
    });
  }

  Future<void> onPredictionSelected(AutocompletePrediction prediction) async {
    searchText.value = prediction.fullText;
    predictions.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    final details =
        await GooglePlacesService.instance.placeDetails(prediction.placeId);
    if (details != null) {
      final latLng = LatLng(details.lat, details.lng);
      await updateMarkerPosition(latLng);
      await moveToLocation(latLng);
    } else {
      Get.snackbar("Error", "Could not fetch place details.");
    }
  }

  void clearSearch() {
    searchText.value = '';
    predictions.clear();
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void moveToCurrentLocation() {
    _getCurrentLocation();
  }
}