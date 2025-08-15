import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/onboarding_welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/citizenship_creed_screen.dart';
import 'screens/auth_entry_screen.dart';
import 'screens/onboarding_complete_screen.dart';

import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/help_offer_screen.dart';
import 'screens/help_request_screen.dart';
import 'screens/pray_request_screen.dart';
import 'screens/pray_offer_screen.dart';
import 'screens/ride_offer_coming_soon_popup_screen.dart';
import 'screens/ride_request_coming_soon_popup_screen.dart';
import 'screens/testimony_screen.dart';
import 'screens/about_samaria_screen.dart';
import 'screens/ride_request_screen.dart';
import 'screens/ride_offer_screen.dart';
// import protected screens like ride_offer_screen.dart when ready

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingWelcomeScreen(),
    ),

// add:
    GoRoute(
      path: '/ride/request',
      builder: (context, state) => const RideRequestScreen(),
    ),
    GoRoute(
      path: '/ride/offer',
      builder: (context, state) => const RideOfferScreen(),
    ),

    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/onboarding/creed',
      builder: (context, state) => const CitizenshipCreedScreen(),
    ),
    GoRoute(
      path: '/onboarding/auth',
      builder: (context, state) => const AuthEntryScreen(),
    ),
    GoRoute(
      path: '/onboarding/complete',
      builder: (context, state) => const OnboardingCompleteScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/give/help',
      builder: (context, state) => const LendAHandScreen(),
    ),
    GoRoute(
      path: '/ask/help',
      builder: (context, state) => const AskForHelpScreen(),
    ),
    GoRoute(
      path: '/pray/for',
      builder: (context, state) => const PrayForMeScreen(),
    ),
    GoRoute(
      path: '/lets/pray',
      builder: (context, state) => const LetsPrayScreen(),
    ),
    GoRoute(
      path: '/ride/offer',
      builder: (context, state) => const OfferRideComingSoonPopupScreen(),
    ),
    GoRoute(
      path: '/ride/request',
      builder: (context, state) => const AskForRideComingSoonPopupScreen(),
    ),
    GoRoute(
      path: '/testimony',
      name: 'testimony',
      builder: (context, state) => const TestimonyScreen(),
    ),
    GoRoute(
      path: '/about/samaria',
      builder: (context, state) => const AboutSamariaScreen(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthEntryScreen(),
    ),




  ],
);

// For dev/testing only
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('$title\nComing Soon!', textAlign: TextAlign.center)),
    );
  }
}
