import 'package:flutter/foundation.dart';

@immutable
class RideDestination {
  final String id;
  final String name;
  final String address;
  final double lat;
  final double lng;

  const RideDestination({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });

  factory RideDestination.fromMap(Map<String, dynamic> map, String id) {
    return RideDestination(
      id: id,
      name: map['name'] as String? ?? '',
      address: map['address'] as String? ?? '',
      lat: (map['lat'] ?? 0).toDouble(),
      lng: (map['lng'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'address': address,
    'lat': lat,
    'lng': lng,
  };
}
