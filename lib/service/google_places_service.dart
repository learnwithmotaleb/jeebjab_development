import 'dart:convert';
import 'package:http/http.dart' as http;

/// A single Google Places Autocomplete suggestion.
class AutocompletePrediction {
  final String placeId;
  final String fullText;
  final String primaryText;
  final String secondaryText;

  AutocompletePrediction({
    required this.placeId,
    required this.fullText,
    required this.primaryText,
    required this.secondaryText,
  });

  factory AutocompletePrediction.fromJson(Map<String, dynamic> json) {
    return AutocompletePrediction(
      placeId: json['place_id'] as String? ?? '',
      fullText: json['description'] as String? ?? '',
      primaryText:
          json['structured_formatting']?['main_text'] as String? ??
          json['description'] as String? ??
          '',
      secondaryText:
          json['structured_formatting']?['secondary_text'] as String? ?? '',
    );
  }
}

/// Lat/lng for a place resolved via Place Details.
class PlaceLatLng {
  final double lat;
  final double lng;
  const PlaceLatLng(this.lat, this.lng);
}

/// Shared Google Places REST helper — Autocomplete predictions as the user
/// types, plus Place Details to resolve a selected prediction's coordinates.
/// Used by any screen that needs address suggestions (pickup/drop-off address
/// entry, the map picker's search bar) so this API-calling logic lives in one
/// place instead of being copy-pasted per screen.
class GooglePlacesService {
  GooglePlacesService._();
  static final GooglePlacesService instance = GooglePlacesService._();

  // Inject at build time: flutter run --dart-define=GOOGLE_MAPS_API_KEY=xxxx
  String get apiKey {
    const key = String.fromEnvironment('GOOGLE_MAPS_API_KEY');
    return key.isNotEmpty ? key : 'AIzaSyBCYhLFH245ocR2fJj6GnSzSMfC9X90mv0';
  }

  Future<List<AutocompletePrediction>> autocomplete(String input) async {
    if (input.trim().isEmpty) return [];
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${Uri.encodeComponent(input)}&key=$apiKey',
      );
      final response = await http.get(url).timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) return [];

      final data = jsonDecode(response.body);
      if (data['status'] != 'OK' || data['predictions'] == null) return [];

      return (data['predictions'] as List)
          .map((p) => AutocompletePrediction.fromJson(p))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<PlaceLatLng?> placeDetails(String placeId) async {
    try {
      final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey',
      );
      final response = await http.get(url).timeout(const Duration(seconds: 15));
      if (response.statusCode != 200) return null;

      final data = jsonDecode(response.body);
      if (data['status'] != 'OK' || data['result'] == null) return null;

      final location = data['result']['geometry']?['location'];
      if (location == null) return null;

      return PlaceLatLng(
        (location['lat'] as num).toDouble(),
        (location['lng'] as num).toDouble(),
      );
    } catch (_) {
      return null;
    }
  }
}
