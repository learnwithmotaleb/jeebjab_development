import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'google_places_service.dart';

class DrivingRoute {
  final List<LatLng> points;
  final double seconds;
  final int meters;
  DrivingRoute(this.points, this.seconds, this.meters);

  String get distanceText =>
      meters < 1000 ? '$meters m' : '${(meters / 1000).toStringAsFixed(1)} km';
  String get durationText {
    final minutes = (seconds / 60).ceil();
    return minutes < 60
        ? '$minutes min'
        : '${minutes ~/ 60} hr ${minutes % 60} min';
  }
}

class GoogleRoutesService {
  final http.Client client;
  GoogleRoutesService(this.client);

  Future<DrivingRoute> drivingRoute(LatLng origin, LatLng destination) async {
    const routesKey = String.fromEnvironment('GOOGLE_ROUTES_API_KEY');
    Map<String, dynamic> waypoint(LatLng p) => {
      'location': {
        'latLng': {'latitude': p.latitude, 'longitude': p.longitude},
      },
    };
    final response = await client
        .post(
          Uri.parse(
            'https://routes.googleapis.com/directions/v2:computeRoutes',
          ),
          headers: {
            'Content-Type': 'application/json',
            'X-Goog-Api-Key': routesKey.isNotEmpty
                ? routesKey
                : GooglePlacesService.instance.apiKey,
            'X-Goog-FieldMask':
                'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
          },
          body: jsonEncode({
            'origin': waypoint(origin),
            'destination': waypoint(destination),
            'travelMode': 'DRIVE',
            'routingPreference': 'TRAFFIC_AWARE',
            'computeAlternativeRoutes': true,
            'polylineQuality': 'HIGH_QUALITY',
            'polylineEncoding': 'ENCODED_POLYLINE',
          }),
        )
        .timeout(const Duration(seconds: 20));
    if (response.statusCode != 200) {
      // Keep credentials and provider response details out of user-facing errors.
      throw StateError('Routes API HTTP ${response.statusCode}');
    }
    return fastestRoute(jsonDecode(response.body) as Map<String, dynamic>);
  }

  static DrivingRoute fastestRoute(Map<String, dynamic> data) {
    final routes = <DrivingRoute>[];
    for (final raw in (data['routes'] as List? ?? [])) {
      final duration = raw['duration'] as String? ?? '';
      final seconds = duration.endsWith('s')
          ? double.tryParse(duration.substring(0, duration.length - 1))
          : null;
      final encoded = raw['polyline']?['encodedPolyline'] as String?;
      final meters = raw['distanceMeters'] as num?;
      if (seconds == null || seconds < 0 || meters == null || encoded == null) {
        continue;
      }
      final points = decodePolyline(encoded);
      if (points.length > 1) {
        routes.add(DrivingRoute(points, seconds, meters.toInt()));
      }
    }
    if (routes.isEmpty) {
      throw const FormatException('No driving route available');
    }
    routes.sort((a, b) => a.seconds.compareTo(b.seconds));
    return routes.first;
  }

  static List<LatLng> decodePolyline(String encoded) {
    var index = 0;
    var lat = 0;
    var lng = 0;
    int component() {
      var value = 0;
      var shift = 0;
      while (true) {
        if (index >= encoded.length || shift > 30) {
          throw const FormatException('Invalid route polyline');
        }
        final byte = encoded.codeUnitAt(index++) - 63;
        if (byte < 0 || byte > 63) {
          throw const FormatException('Invalid route polyline');
        }
        value |= (byte & 31) << shift;
        if (byte < 32) return value.isOdd ? ~(value >> 1) : value >> 1;
        shift += 5;
      }
    }

    final points = <LatLng>[];
    while (index < encoded.length) {
      lat += component();
      lng += component();
      points.add(LatLng(lat / 1e5, lng / 1e5));
    }
    return points;
  }
}
