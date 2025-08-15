import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/help_request.dart';

class HelpRequestDetailScreen extends StatelessWidget {
  final HelpRequest helpRequest;

  const HelpRequestDetailScreen({Key? key, required this.helpRequest}) : super(key: key);

  String get formattedDeadline {
    return DateFormat('EEEE, MMMM d, y').format(helpRequest.deadline);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Request Detail'),
        backgroundColor: Colors.deepPurple.shade600,
      ),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/images/lend_a_hand_1.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    helpRequest.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (helpRequest.name != null && helpRequest.name!.isNotEmpty)
                    Text(
                      "Submitted by: ${helpRequest.name}",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  const SizedBox(height: 16),
                  Text(
                    helpRequest.description,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
                  ),
                  const Divider(height: 32, thickness: 1.2),
                  Row(
                    children: [
                      const Icon(Icons.access_time_outlined, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      Text(
                        "Preferred Time: ${helpRequest.timePreference}",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today_outlined, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      Text(
                        "Needed by: $formattedDeadline",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
