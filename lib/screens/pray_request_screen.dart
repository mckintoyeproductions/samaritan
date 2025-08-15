import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/prayer_request.dart';

class PrayForMeScreen extends StatefulWidget {
  const PrayForMeScreen({Key? key}) : super(key: key);

  @override
  State<PrayForMeScreen> createState() => _PrayForMeScreenState();
}

class _PrayForMeScreenState extends State<PrayForMeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  Future<void> _submitPrayerRequest() async {
    final id = FirebaseFirestore.instance.collection('prayer_requests').doc().id;

    final prayer = PrayerRequest(
      id: id,
      title: _messageController.text.trim(),
      description: _messageController.text.trim(),
      timestamp: Timestamp.now(),
      name: _nameController.text.trim().isEmpty ? null : _nameController.text.trim(),
    );

    await FirebaseFirestore.instance
        .collection('prayer_requests')
        .doc(id)
        .set(prayer.toMap());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Thank You!'),
        content: const Text('Your prayer request has been submitted.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              Navigator.of(context).pop(); // Navigate back
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );

    _messageController.clear();
    _nameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pray for Me')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Daily Declaration: 🙏🏾 “Cast all your anxiety on Him because He cares for you.” (1 Peter 5:7)',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name (Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _messageController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                    labelText: 'What’s on your heart? (Prayer request)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _submitPrayerRequest,
                  icon: const Icon(Icons.send),
                  label: const Text('Submit Request'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
