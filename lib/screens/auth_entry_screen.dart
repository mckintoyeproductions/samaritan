import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthEntryScreen extends StatelessWidget {
  const AuthEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'You can sign up now, or continue with limited access.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              icon: const Icon(Icons.mail_outline),
              label: const Text('Sign up with Email'),
              onPressed: () {
                context.go('/signup'); // Placeholder route
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.login),
              label: const Text('Continue with Google'),
              onPressed: () {
                // Trigger Google sign-in logic
              },
            ),
            const SizedBox(height: 32),
            OutlinedButton(
              onPressed: () {
                context.go('/home');
              },
              child: const Text('Skip for Now → Limited Access'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Note: For full access to Citizen rights in samaria, like offering or requesting rides, you’ll need to signup/verify your account later.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
