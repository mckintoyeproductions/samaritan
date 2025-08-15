

// ride_request_coming_soon_popup_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

class AskForRideComingSoonPopupScreen extends StatefulWidget {
  const AskForRideComingSoonPopupScreen({super.key});

  @override
  State<AskForRideComingSoonPopupScreen> createState() => _AskForRideComingSoonPopupScreenState();
}

class _AskForRideComingSoonPopupScreenState extends State<AskForRideComingSoonPopupScreen> {
  late Timer _timer;
  Duration _timeRemaining = DateTime(2025, 11, 2).difference(DateTime.now());

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _timeRemaining = DateTime(2025, 11, 2).difference(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    return '${duration.inDays}d ${duration.inHours % 24}h ${duration.inMinutes % 60}m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/ride_request.jpg',
            fit: BoxFit.cover,
            color: Colors.black.withOpacity(0.7),
            colorBlendMode: BlendMode.darken,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.chat_bubble_outline, color: Colors.white, size: 36),
                  const SizedBox(height: 16),
                  const Text(
                    '🙏 Ask for a Ride',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Text(
                    'Ask in Faith. Ride in Grace.',
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Faith meets logistics:',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureChip('✨ Request a ride with prayer notes'),
                  _buildFeatureChip('✨ Anonymity options for safety'),
                  _buildFeatureChip('✨ Route matched with spiritual encouragement'),
                  _buildFeatureChip('✨ Receive confirmation from a Samaritan, not just a driver'),
                  const Spacer(),
                  Text('Launches in: ${_formatDuration(_timeRemaining)}', style: const TextStyle(color: Colors.amber)),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => launchPitchDoc(),
                    child: const Text('📄 Catch the vision? Partner with us', style: TextStyle(color: Colors.amber)),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('← Back to Dashboard'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  void launchPitchDoc() {
    // Implement launch URL to Google Doc pitch
  }
}