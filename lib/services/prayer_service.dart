import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/prayer_request_model.dart';

class PrayerService {
  static final _firestore = FirebaseFirestore.instance;

  static final _requestCollection = _firestore.collection('prayer_requests');
  static final _offerCollection = _firestore.collection('prayer_offers');

  // 🔁 PRAYER REQUESTS
  static Stream<List<PrayerRequest>> getPrayerRequests() {
    return _requestCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => PrayerRequest.fromMap(doc.data(), doc.id)).toList());
  }

  static Future<void> submitPrayerRequest(PrayerRequest request) async {
    await _requestCollection.add(request.toMap());
  }

  // 🙏🏾 PRAYER OFFERS
  static Stream<List<PrayerRequest>> getPrayerOffers() {
    return _offerCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => PrayerRequest.fromMap(doc.data(), doc.id)).toList());
  }

  static Future<void> submitPrayerOffer(PrayerRequest request) async {
    await _offerCollection.add(request.toMap());
  }
}
