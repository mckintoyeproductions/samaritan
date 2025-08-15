import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/prayer_request.dart';
import '../widgets/pray_offer_daily_declaration_widget.dart';


class LetsPrayScreen extends StatelessWidget {
  const LetsPrayScreen({super.key});

  Stream<List<PrayerRequest>> getPrayerRequests() async* {
    try {
      yield* FirebaseFirestore.instance
          .collection('prayer_requests')
          .orderBy('timestamp', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          final data = doc.data();
          return PrayerRequest.fromMap(data, doc.id);
        }).toList();
      });
    } catch (e) {
      debugPrint('Firestore error: $e');
      yield [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Let’s Pray'),
        leading: const Icon(Icons.auto_awesome),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            PrayWithDailyDeclarationWidget(),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '🙏 Latest Prayer Requests',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<PrayerRequest>>(
              stream: getPrayerRequests(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error loading prayer requests.',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final requests = snapshot.data ?? [];

                if (requests.isEmpty) {
                  return const Center(child: Text('No prayer requests yet.'));
                }

                return ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        leading: const Icon(Icons.favorite_border),
                        title: Text(request.title),
                        subtitle: Text(request.description),
                        trailing: Text(
                          request.name?.isNotEmpty == true ? request.name! : 'Anonymous',
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}