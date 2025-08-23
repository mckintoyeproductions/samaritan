import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/testimony_model.dart';

class TestimonyService {
  final _collection = FirebaseFirestore.instance.collection('testimonies');

  Future<void> submitTestimony(TestimonyModel testimony) async {
    await _collection.add(testimony.toMap());
  }

  Stream<List<TestimonyModel>> getTestimoniesStream() {
    return _collection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => TestimonyModel.fromMap(doc.data(), doc.id))
        .toList());
  }
}
