import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/ride_request_model.dart';

class RideService {
  static final _db = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static CollectionReference<Map<String, dynamic>> get _requests =>
      _db.collection('ride_requests');

  /// Create a ride request (Ask for Ride).
  static Future<String> createRideRequest({
    required String destinationId,
    required String destinationName,
    required DateTime rideDate,
    required String rideTime,
    String? note,

    // NEW (optional, for profile autofill)
    String? pickupAddress,
    double? pickupLat,
    double? pickupLng,
  }) async {
    final user = _auth.currentUser;
    final doc = await _requests.add({
      'userId': user?.uid,
      'destinationId': destinationId,
      'destinationName': destinationName,
      'rideDate': Timestamp.fromDate(DateTime(rideDate.year, rideDate.month, rideDate.day)),
      'rideTime': rideTime,
      'status': 'open',
      'matchedOfferId': null,
      'createdAt': Timestamp.now(),
      if (pickupAddress != null) 'pickupAddress': pickupAddress,
      if (pickupLat != null) 'pickupLat': pickupLat,
      if (pickupLng != null) 'pickupLng': pickupLng,
      if (note != null && note.isNotEmpty) 'note': note,
    });
    return doc.id;
  }

  /// Stream open ride requests (for Offer Ride list).
  static Stream<List<RideRequest>> streamOpenRequests() {
    return _requests
        .where('status', isEqualTo: 'open')
        .snapshots()
        .map((snap) {
      final list = snap.docs.map((d) => RideRequest.fromDoc(d)).toList();
      list.sort((a, b) {
        final d = a.rideDate.compareTo(b.rideDate);
        if (d != 0) return d;
        return a.rideTime.compareTo(b.rideTime);
      });
      return list;
    });
  }

  /// Claim (match) an open ride request by offer/driver.
  static Future<void> matchRequest({ required String requestId, String? driverId }) async {
    await _requests.doc(requestId).update({
      'status': 'matched',
      if (driverId != null) 'matchedOfferId': driverId,
    });
  }
}
