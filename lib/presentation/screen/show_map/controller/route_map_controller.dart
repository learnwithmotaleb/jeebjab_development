import 'dart:async';

import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../../service/google_map_services.dart';
import '../../../../service/google_routes_service.dart';

/// Shows a job's location on the map. Most jobs have both a pickup and a
/// drop-off (e.g. "move" posts) — those get two markers, a polyline between
/// them, and traffic-aware driving distance/duration from Google Routes.
/// Recycling posts only have a pickup (no drop-off at all), so this falls
/// back to a single-marker view centered on that point — no polyline, no
/// distance/duration, and no "missing route" error, since there was never
/// a route to begin with.
///
/// It also shows the road distance/time from the device's *current* GPS
/// position to the pickup point — "how far am I from this job right now" —
/// as a third marker + a separate polyline, reusing the location already
/// tracked by [GoogleMapServices] instead of polling GPS a second time.
class RouteMapController extends GetxController {
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  final http.Client _routeClient = http.Client();
  final RxString routeError = ''.obs;
  final RxString locationError = ''.obs;

  late final LatLng pickupPosition;
  LatLng? dropoffPosition;
  bool get hasDropoff => dropoffPosition != null;

  final RxString pickupAddress = ''.obs;
  final RxString dropoffAddress = ''.obs;

  final RxList<LatLng> routePoints = <LatLng>[].obs;
  final RxString distanceText = ''.obs;
  final RxString durationText = ''.obs;
  final RxBool isApproximate = false.obs;

  // ── From the device's current location to the pickup point ─────────────
  final Rxn<LatLng> myLocation = Rxn<LatLng>();
  final RxList<LatLng> myLocationRoutePoints = <LatLng>[].obs;
  final RxString myLocationDistanceText = ''.obs;
  final RxString myLocationDurationText = ''.obs;
  final RxBool myLocationIsApproximate = false.obs;
  final RxBool isLoadingMyLocation = false.obs;

  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  bool _hasValidPickup = false;

  CameraPosition get initialCameraPosition => CameraPosition(
    target: _hasValidPickup
        ? (hasDropoff
              ? LatLng(
                  (pickupPosition.latitude + dropoffPosition!.latitude) / 2,
                  (pickupPosition.longitude + dropoffPosition!.longitude) / 2,
                )
              : pickupPosition)
        : const LatLng(23.746466, 90.376015),
    zoom: hasDropoff ? 12 : 15,
  );

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    final dynamic args = Get.arguments;
    if (args is! Map) {
      errorMessage.value = 'No location information was provided.';
      isLoading.value = false;
      return;
    }

    final pLat = (args['pickupLat'] as num?)?.toDouble();
    final pLng = (args['pickupLng'] as num?)?.toDouble();
    final dLat = (args['dropoffLat'] as num?)?.toDouble();
    final dLng = (args['dropoffLng'] as num?)?.toDouble();
    pickupAddress.value = (args['pickupAddress'] as String?) ?? '';
    dropoffAddress.value = (args['dropoffAddress'] as String?) ?? '';

    if (pLat == null || pLng == null) {
      errorMessage.value = "This job is missing its pickup coordinates.";
      isLoading.value = false;
      return;
    }

    pickupPosition = LatLng(pLat, pLng);
    _hasValidPickup = true;

    if (dLat != null && dLng != null) {
      dropoffPosition = LatLng(dLat, dLng);
      _fetchDirections();
    } else {
      // Recycling-style post: pickup only, nothing to route to.
      routePoints.clear();
      distanceText.value = '';
      durationText.value = '';
      isLoading.value = false;
      _fitBoundsToRoute();
    }

    _loadMyLocationRoute();
  }

  Future<void> _fetchDirections() async {
    isLoading.value = true;
    routeError.value = '';
    final result = await _requestDirections(pickupPosition, dropoffPosition!);
    if (isClosed) return;
    if (result != null) {
      distanceText.value = result.distanceText;
      durationText.value = result.durationText;
      routePoints.assignAll(result.points);
      isApproximate.value = false;
    } else {
      routePoints.clear();
      distanceText.value = '';
      durationText.value = '';
      routeError.value = 'Driving route unavailable. Please retry.';
    }
    isLoading.value = false;
    _fitBoundsToRoute();
  }

  /// The device's current GPS position → the pickup point, so a driver can
  /// see how far the job actually is right now. Reuses [GoogleMapServices]'s
  /// already-tracked position instead of polling GPS again.
  Future<void> _loadMyLocationRoute() async {
    if (!Get.isRegistered<GoogleMapServices>()) return;
    final mapService = Get.find<GoogleMapServices>();

    isLoadingMyLocation.value = true;
    locationError.value = '';
    try {
      if (!mapService.isLocationReady.value) {
        await mapService.fetchCurrentLocation();
      }
      if (!mapService.isLocationReady.value) {
        myLocation.value = null;
        myLocationRoutePoints.clear();
        myLocationDistanceText.value = '';
        myLocationDurationText.value = '';
        locationError.value =
            'Current location unavailable. Enable GPS and location permission.';
        return;
      }

      final current = LatLng(
        mapService.currentLat.value,
        mapService.currentLng.value,
      );
      myLocation.value = current;

      final result = await _requestDirections(current, pickupPosition);
      if (isClosed) return;
      if (result != null) {
        myLocationDistanceText.value = result.distanceText;
        myLocationDurationText.value = result.durationText;
        myLocationRoutePoints.assignAll(result.points);
        myLocationIsApproximate.value = false;
      } else {
        myLocationRoutePoints.clear();
        myLocationDistanceText.value = '';
        myLocationDurationText.value = '';
        locationError.value = 'Route to pickup unavailable. Please retry.';
      }
    } catch (e) {
      debugPrint('Error loading my-location route: $e');
    } finally {
      isLoadingMyLocation.value = false;
      _fitBoundsToRoute();
    }
  }

  Future<DrivingRoute?> _requestDirections(
    LatLng origin,
    LatLng destination,
  ) async {
    try {
      return await GoogleRoutesService(
        _routeClient,
      ).drivingRoute(origin, destination);
    } catch (e) {
      locationError.value = 'Current location route unavailable. Please retry.';
      debugPrint('Driving route failed: $e');
      return null;
    }
  }

  Future<void> retryRoutes() async {
    if (!_hasValidPickup || isLoading.value || isLoadingMyLocation.value) {
      return;
    }
    await Future.wait([
      if (hasDropoff) _fetchDirections(),
      _loadMyLocationRoute(),
    ]);
  }

  Future<void> refreshCurrentRoute() async {
    if (!_hasValidPickup || isLoadingMyLocation.value) return;
    if (Get.isRegistered<GoogleMapServices>()) {
      await Get.find<GoogleMapServices>().fetchCurrentLocation();
    }
    if (!isClosed) await _loadMyLocationRoute();
  }

  @override
  void onClose() {
    _routeClient.close();
    super.onClose();
  }

  void onMapCreated(GoogleMapController controller) {
    if (!mapController.isCompleted) {
      mapController.complete(controller);
      _fitBoundsToRoute();
    }
  }

  /// Re-fits the camera to whatever points are currently known: pickup,
  /// drop-off (if any), and the device's own location (if found). Called
  /// again each time my-location arrives, so the view widens once it's in.
  Future<void> _fitBoundsToRoute() async {
    if (!_hasValidPickup || !mapController.isCompleted) return;
    final controller = await mapController.future;

    final points = [
      pickupPosition,
      ...routePoints,
      ...myLocationRoutePoints,
      if (hasDropoff) dropoffPosition!,
      if (myLocation.value != null) myLocation.value!,
    ];

    try {
      if (points.length == 1) {
        // Single point — just center on it, no bounds to fit.
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: points.first, zoom: 15),
          ),
        );
        return;
      }

      final southwest = LatLng(
        points.map((p) => p.latitude).reduce(min),
        points.map((p) => p.longitude).reduce(min),
      );
      final northeast = LatLng(
        points.map((p) => p.latitude).reduce(max),
        points.map((p) => p.longitude).reduce(max),
      );

      await controller.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(southwest: southwest, northeast: northeast),
          72,
        ),
      );
    } catch (e) {
      // Bounds/camera moves can fail on the very first frame on some
      // devices — the initialCameraPosition is still a reasonable fallback.
      debugPrint('Error moving map camera: $e');
    }
  }
}
