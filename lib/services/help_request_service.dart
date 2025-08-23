import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/help_request_model.dart';

class HelpRequestService {
  final _collection = FirebaseFirestore.instance.collection('help_requests');

  Future<void> submitHelpRequest(HelpRequest request) async {
    await _collection.add(request.toMap());
  }

  Stream<List<HelpRequest>> getHelpRequestsStream() {
    return _collection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => HelpRequest.fromMap(doc.data(), doc.id))
        .toList());
  }
}
