import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerRequest {
  final String id;
  final String title;
  final String description;
  final Timestamp timestamp;
  final String? name;

  PrayerRequest({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    this.name,
  });

  factory PrayerRequest.fromMap(Map<String, dynamic> map, String id) {
    return PrayerRequest(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'timestamp': timestamp,
      if (name != null) 'name': name,
    };
  }
}
