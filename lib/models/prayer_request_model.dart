import 'package:cloud_firestore/cloud_firestore.dart';

class PrayerRequest {
  final String? id;
  final String? title;
  final String? description;
  final DateTime? timestamp;
  final String? name;

  PrayerRequest({
    this.id,
    this.title,
    this.description,
    this.timestamp,
    this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
      'name': name,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  factory PrayerRequest.fromMap(Map<String, dynamic> map, String docId) {
    return PrayerRequest(
      id: docId,
      title: map['title'],
      description: map['description'],
      timestamp: map['timestamp'] != null
          ? (map['timestamp'] as Timestamp).toDate()
          : null,
      name: map['name'],
    );
  }

  factory PrayerRequest.fromJson(Map<String, dynamic> json) =>
      PrayerRequest.fromMap(json, json['id'] ?? '');
}
