import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  static Future<void> addDocument(String path, Map<String, dynamic> data) async {
    await _db.collection(path).add(data);
  }

  static Stream<QuerySnapshot> streamCollection(String path,
      {String? orderByField, bool descending = true}) {
    final query = orderByField != null
        ? _db.collection(path).orderBy(orderByField, descending: descending)
        : _db.collection(path);
    return query.snapshots();
  }

  static Future<void> updateDocument(String path, String docId, Map<String, dynamic> data) async {
    await _db.collection(path).doc(docId).update(data);
  }

  static Future<void> deleteDocument(String path, String docId) async {
    await _db.collection(path).doc(docId).delete();
  }
}
