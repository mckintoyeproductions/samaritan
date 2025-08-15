import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CitizenshipCreedScreen extends StatefulWidget {
  const CitizenshipCreedScreen({super.key});

  @override
  State<CitizenshipCreedScreen> createState() => _CitizenshipCreedScreenState();
}

class _CitizenshipCreedScreenState extends State<CitizenshipCreedScreen> {
  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Become a Citizen of Samaria'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'I commit to…',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildCreedLine('☑️ Act with compassion, not comparison'),
            _buildCreedLine('☑️ See need, not status'),
            _buildCreedLine('☑️ Offer what I can — even a seat or a story'),
            _buildCreedLine('☑️ Serve in love, not for likes'),
            _buildCreedLine('☑️ Trust that one kind act can change a life'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                setState(() => accepted = true);
                context.go('/onboarding/auth');
              },
              child: const Text('I Accept'),
            ),
            TextButton(
              onPressed: () => context.go('/onboarding/auth'),
              child: const Text('Skip for Now'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreedLine(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
