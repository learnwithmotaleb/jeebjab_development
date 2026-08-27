import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../../service/google_map_services.dart';

/// Shows a job's location on the map. Most jobs have both a pickup and a
/// drop-off (e.g. "move" posts) — those get two markers, a polyline between
/// them, and the real driving distance/duration from Google Directions.
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

  String get _googleMapsApiKey {
    const key = String.fromEnvironment('GOOGLE_MAPS_API_KEY');
    return key.isNotEmpty ? key : 'AIzaSyBCYhLFH245ocR2fJj6GnSzSMfC9X90mv0';
  }

  late final LatLng pickupPosition;
  LatLng? dropoffPosition;
  bool get hasDropoff => dropoffPosition != null;

  final RxString pickupAddress = ''.obs;
  final RxString dropoffAddress = ''.obs;

  final RxList<LatLng> routePoints = <LatLng>[].obs;
  final RxString distanceText = ''.obs;
  final RxString durationText = ''.obs;
  final RxBool isApproximate = false.obs; // true when using the fallback straight line

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
                    (pickupPosition.longitude + dropoffPosition!.longitude) /
                        2,
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
    final result = await _requestDirections(pickupPosition, dropoffPosition!);
    if (result != null) {
      distanceText.value = result.distanceText;
      durationText.value = result.durationText;
      routePoints.assignAll(result.points);
      isApproximate.value = false;
    } else {
      _useFallbackLine(pickupPosition, dropoffPosition!,
          points: routePoints,
          distance: distanceText,
          duration: durationText,
          approximate: isApproximate);
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
    try {
      if (!mapService.isLocationReady.value) {
        await mapService.fetchCurrentLocation();
      }
      if (!mapService.isLocationReady.value) return;

      final current =
          LatLng(mapService.currentLat.value, mapService.currentLng.value);
      myLocation.value = current;

      final result = await _requestDirections(current, pickupPosition);
      if (result != null) {
        myLocationDistanceText.value = result.distanceText;
        myLocationDurationText.value = result.durationText;
        myLocationRoutePoints.assignAll(result.points);
        myLocationIsApproximate.value = false;
      } else {
        _useFallbackLine(current, pickupPosition,
            points: myLocationRoutePoints,
            distance: myLocationDistanceText,
            duration: myLocationDurationText,
            approximate: myLocationIsApproximate);
      }
    } catch (e) {
      debugPrint('Error loading my-location route: $e');
    } finally {
      isLoadingMyLocation.value = false;
      _fitBoundsToRoute();
    }
  }

  /// Calls Google Directions for [origin] → [destination]. Returns null on
  /// any failure (network, no route found, bad response) so callers can
  /// fall back to a straight line instead of leaving the UI blank.
  Future<_DirectionsResult?> _requestDirections(
      LatLng origin, LatLng destination) async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${origin.latitude},${origin.longitude}'
        '&destination=${destination.latitude},${destination.longitude}'
        '&key=$_googleMapsApiKey',
      );
      final response = await http.get(url);
      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body);
      final routes = data['routes'] as List?;
      if (data['status'] != 'OK' || routes == null || routes.isEmpty) {
        debugPrint('Directions API returned: ${data['status']}');
        return null;
      }

      final legs = routes[0]['legs'] as List?;
      final leg = (legs != null && legs.isNotEmpty) ? legs[0] : null;
      final poly = routes[0]['overview_polyline']?['points'] as String?;
      if (poly == null || poly.isEmpty) return null;

      return _DirectionsResult(
        distanceText: leg?['distance']?['text'] ?? '',
        durationText: leg?['duration']?['text'] ?? '',
        points: _decodePolyline(poly),
      );
    } catch (e) {
      debugPrint('Error fetching directions: $e');
      return null;
    }
  }

  /// Straight line between two points, with a haversine-based distance and
  /// a rough time estimate — used only when Directions is unavailable.
  void _useFallbackLine(
    LatLng from,
    LatLng to, {
    required RxList<LatLng> points,
    required RxString distance,
    required RxString duration,
    required RxBool approximate,
  }) {
    points.assignAll([from, to]);
    final km = _haversineKm(from, to);
    distance.value = '${km.toStringAsFixed(1)} km';
    // Rough average city driving speed — clearly marked as approximate in the UI.
    final minutes = (km / 30 * 60).round().clamp(1, 999);
    duration.value = '~$minutes min';
    approximate.value = true;
  }

  double _haversineKm(LatLng a, LatLng b) {
    const earthRadiusKm = 6371.0;
    final dLat = _degToRad(b.latitude - a.latitude);
    final dLng = _degToRad(b.longitude - a.longitude);
    final la1 = _degToRad(a.latitude);
    final la2 = _degToRad(b.latitude);
    final h = sin(dLat / 2) * sin(dLat / 2) +
        cos(la1) * cos(la2) * sin(dLng / 2) * sin(dLng / 2);
    final c = 2 * atan2(sqrt(h), sqrt(1 - h));
    return earthRadiusKm * c;
  }

  double _degToRad(double deg) => deg * (pi / 180);

  /// Standard Google encoded-polyline decoder.
  List<LatLng> _decodePolyline(String encoded) {
    final List<LatLng> points = [];
    int index = 0;
    final int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int shift = 0;
      int result = 0;
      int b;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lat += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      lng += (result & 1) != 0 ? ~(result >> 1) : (result >> 1);

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }
    return points;
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

/// Plain result holder for a single Directions API call.
class _DirectionsResult {
  final String distanceText;
  final String durationText;
  final List<LatLng> points;

  _DirectionsResult({
    required this.distanceText,
    required this.durationText,
    required this.points,
  });
}
