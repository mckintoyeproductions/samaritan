import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/prayer_request_model.dart';
import '../services/prayer_service.dart';

class PrayOfferScreen extends StatelessWidget {
  const PrayOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Let\'s Pray'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: StreamBuilder<List<PrayerRequest>>(
        stream: PrayerService.getPrayerRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No prayer requests yet 🙏🏾',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            );
          }

          final requests = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                elevation: 2,
                child: ListTile(
                  title: Text(request.title ?? 'Prayer Request'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (request.description != null) Text(request.description!),
                      if (request.name != null)
                        Text('From: ${request.name!}', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.volunteer_activism_outlined),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('🙏🏾 You prayed for this request.')),
                      );
                    },
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
