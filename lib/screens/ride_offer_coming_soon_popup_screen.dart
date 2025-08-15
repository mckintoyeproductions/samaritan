// ride_offer_coming_soon_popup_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class OfferRideComingSoonPopupScreen extends StatefulWidget {
  const OfferRideComingSoonPopupScreen({super.key});

  @override
  State<OfferRideComingSoonPopupScreen> createState() => _OfferRideComingSoonPopupScreenState();
}

class _OfferRideComingSoonPopupScreenState extends State<OfferRideComingSoonPopupScreen> {
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
            'assets/images/ride_offer.jpg',
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
                  const Icon(Icons.directions_car, color: Colors.white, size: 36),
                  const SizedBox(height: 16),
                  const Text(
                    '🚗 Offer a Ride',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const Text(
                    'One Ride. Infinite Impact.',
                    style: TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Turn your commute into a calling:',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  _buildFeatureChip('✅ Auto-matched riders in your area'),
                  _buildFeatureChip('✅ Chat & pray before pickup'),
                  _buildFeatureChip('✅ Devotional overlays on the map'),
                  _buildFeatureChip('✅ Verified driver identity (Citizen of Samaria badge)'),
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