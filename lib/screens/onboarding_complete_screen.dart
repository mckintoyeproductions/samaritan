import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingCompleteScreen extends StatelessWidget {
  const OnboardingCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.volunteer_activism, size: 64, color: Colors.deepPurple),
            const SizedBox(height: 24),
            Text(
              'You’re now a Citizen of Samaria!',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Welcome to the road of compassion.\nLet’s go serve and uplift together.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Start Using the App'),
            ),
          ],
        ),
      ),
    );
  }
}
