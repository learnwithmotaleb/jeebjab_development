/// Represents a GeoJSON Point used for pickup and drop‑off locations.
class Geo {
  final String? type;               // e.g. "Point"
  final List<double>? coordinates;  // [lng, lat]

  Geo({this.type, this.coordinates});

  /// Build a Geo object from a JSON map.
  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
        type: json['type'] as String?,
        // The API supplies a list of numbers; we cast each to double.
        coordinates: (json['coordinates'] as List?)
            ?.map((e) => (e as num).toDouble())
            .toList(),
      );

  /// Convert this instance back to JSON.
  Map<String, dynamic> toJson() => {
        'type': type,
        'coordinates': coordinates,
      };
}
