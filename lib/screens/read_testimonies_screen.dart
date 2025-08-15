import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/testimony_model.dart';

class ReadTestimoniesScreen extends StatelessWidget {
  const ReadTestimoniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Testimonies')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('testimonies')
            .orderBy('submitDate', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final testimonies = snapshot.data!.docs.map((doc) {
            return Testimony.fromMap(doc.data()! as Map<String, dynamic>, doc.id);
          }).toList();

          return ListView.builder(
            itemCount: testimonies.length,
            itemBuilder: (context, index) {
              final t = testimonies[index];
              return ListTile(
                title: Text(t.title),
                subtitle: Text(
                  t.description.length > 80 ? '${t.description.substring(0, 80)}...' : t.description,
                ),
                trailing: Text(
                  '${t.submitDate.month}/${t.submitDate.day}/${t.submitDate.year}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text(t.title),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (t.name != null) Text('By: ${t.name!}', style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text(t.description),
                      ],
                    ),
                    actions: [
                      TextButton(
                        child: const Text('Close'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
