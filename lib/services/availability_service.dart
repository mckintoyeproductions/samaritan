import 'package:cloud_firestore/cloud_firestore.dart';

class AvailabilityService {
  final _db = FirebaseFirestore.instance;

  Future<void> updateAvailability({
    required String userId,
    required Map<String, List<String>> availability,
  }) async {
    await _db.collection('availability').doc(userId).set({
      'availability': availability,
      'updatedAt': Timestamp.now(),
    });
  }

  Future<Map<String, List<String>>> getAvailability(String userId) async {
    final doc = await _db.collection('availability').doc(userId).get();
    if (!doc.exists) return {};

    final data = doc.data();
    return Map<String, List<String>>.from(
      (data?['availability'] ?? {}).map(
            (key, value) => MapEntry(key, List<String>.from(value)),
      ),
    );
  }
}
