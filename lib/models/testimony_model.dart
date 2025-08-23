import 'package:cloud_firestore/cloud_firestore.dart';

class TestimonyModel {
  final String id;
  final String title;
  final String description;
  final String? name;
  final DateTime submitDate;

  TestimonyModel({
    required this.id,
    required this.title,
    required this.description,
    this.name,
    required this.submitDate,
  });

  factory TestimonyModel.fromMap(Map<String, dynamic> data, String documentId) {
    return TestimonyModel(
      id: documentId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      name: data['name'],
      submitDate: (data['submitDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'name': name,
      'submitDate': Timestamp.fromDate(submitDate),
    };
  }
}
