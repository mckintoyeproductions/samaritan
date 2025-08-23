import 'package:cloud_firestore/cloud_firestore.dart';

class HelpRequest {
  final String? id;
  final String name;
  final String helpType;
  final String details;
  final DateTime deadline;
  final DateTime timestamp;

  HelpRequest({
    this.id,
    required this.name,
    required this.helpType,
    required this.details,
    required this.deadline,
    required this.timestamp,
  });

  /// Converts to Firestore document map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'helpType': helpType,
      'details': details,
      'deadline': Timestamp.fromDate(timestamp),
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  /// Alias for Firestore compatibility
  Map<String, dynamic> toJson() => toMap();

  /// Factory from Firestore document snapshot
  factory HelpRequest.fromMap(Map<String, dynamic> map, String docId) {
    return HelpRequest(
      id: docId,
      name: map['name'] ?? '',
      helpType: map['helpType'] ?? '',
      details: map['details'] ?? '',
      deadline: (map['timestamp'] as Timestamp).toDate(),
      timestamp: (map['timestamp'] as Timestamp).toDate(),
    );
  }

  /// Optional: for general serialization
  factory HelpRequest.fromJson(Map<String, dynamic> json) =>
      HelpRequest.fromMap(json, json['id'] ?? '');
}
