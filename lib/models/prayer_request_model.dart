import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerRequest {
  final String? id;
  final String title;
  final String description;
  final DateTime timestamp;
  final String name;

  PrayerRequest({
    this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.name,
  });

  /// Standard Firestore format
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timestamp': Timestamp.fromDate(timestamp),
      'name': name,
    };
  }

  /// Alias for Firestore compatibility
  Map<String, dynamic> toJson() => toMap();

  /// Constructor from Firestore snapshot
  factory PrayerRequest.fromMap(Map<String, dynamic> map, String docId) {
    return PrayerRequest(
      id: docId, // override ID from document ID
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      name: map['name'] ?? '',
    );
  }


  /// Alias for Firestore stream decoding
  factory PrayerRequest.fromJson(Map<String, dynamic> json) =>
      PrayerRequest.fromMap(json, json['id']);

}
