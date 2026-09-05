import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:jeebjab/service/google_routes_service.dart';

void main() {
  const encoded = '_p~iF~ps|U_ulLnnqC_mqNvxq`@';
  Map<String, dynamic> route(String duration, int meters) => {
    'duration': duration,
    'distanceMeters': meters,
    'polyline': {'encodedPolyline': encoded},
  };

  test(
    'selects quickest returned alternative using traffic duration',
    () async {
      final client = MockClient((request) async {
        final body = jsonDecode(request.body);
        expect(request.url.path, '/directions/v2:computeRoutes');
        expect(body['routingPreference'], 'TRAFFIC_AWARE');
        expect(body['polylineQuality'], 'HIGH_QUALITY');
        expect(body['computeAlternativeRoutes'], true);
        expect(body['origin']['location']['latLng']['latitude'], 38.5);
        return http.Response(
          jsonEncode({
            'routes': [route('600s', 2000), route('300s', 3000)],
          }),
          200,
        );
      });
      addTearDown(client.close);
      final result = await GoogleRoutesService(client).drivingRoute(
        const LatLng(38.5, -120.2),
        const LatLng(43.252, -126.453),
      );
      expect(result.durationText, '5 min');
      expect(result.distanceText, '3.0 km');
      expect(result.points, [
        const LatLng(38.5, -120.2),
        const LatLng(40.7, -120.95),
        const LatLng(43.252, -126.453),
      ]);
    },
  );

  test(
    'denied API access returns failure, never a straight-line route',
    () async {
      final client = MockClient((_) async => http.Response('{}', 403));
      addTearDown(client.close);
      await expectLater(
        GoogleRoutesService(
          client,
        ).drivingRoute(const LatLng(1, 2), const LatLng(3, 4)),
        throwsStateError,
      );
    },
  );

  test('empty routes and truncated polylines are rejected', () {
    expect(
      () => GoogleRoutesService.fastestRoute({'routes': []}),
      throwsFormatException,
    );
    expect(
      () => GoogleRoutesService.decodePolyline('_p~iF'),
      throwsFormatException,
    );
  });
}
