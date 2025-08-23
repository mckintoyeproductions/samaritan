import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/about_samaria_screen.dart';
import 'screens/auth_entry_screen.dart';
import 'screens/availability_slot_screen.dart';
import 'screens/citizenship_creed_screen.dart';
import 'screens/help_offer_screen.dart';
import 'screens/help_request_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_complete_screen.dart';
import 'screens/onboarding_welcome_screen.dart';
import 'screens/pray_offer_screen.dart';
import 'screens/pray_request_screen.dart';
import 'screens/read_testimonies_screen.dart';
import 'screens/ride_offer_screen.dart';
import 'screens/ride_request_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/testimony_screen.dart';
import 'screens/settings_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/onboarding-welcome',
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/about',
      name: 'aboutSamaria',
      builder: (context, state) => const AboutSamariaScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/auth-entry',
      name: 'authEntry',
      builder: (context, state) => const AuthEntryScreen(),
    ),
    GoRoute(
      path: '/onboarding-complete',
      name: 'onboardingComplete',
      builder: (context, state) => const OnboardingCompleteScreen(),
    ),
    GoRoute(
      path: '/onboarding-welcome',
      name: 'onboardingWelcome',
      builder: (context, state) => const OnboardingWelcomeScreen(),
    ),
    GoRoute(
      path: '/creed',
      name: 'citizenshipCreed',
      builder: (context, state) => const CitizenshipCreedScreen(),
    ),
    GoRoute(
      path: '/pray/request',
      name: 'prayRequest',
      builder: (context, state) => const PrayRequestScreen(),
    ),
    GoRoute(
      path: '/pray/offer',
      name: 'prayOffer',
      builder: (context, state) => const PrayOfferScreen(),
    ),
    GoRoute(
      path: '/testimony',
      name: 'testimony',
      builder: (context, state) => const TestimonyScreen(),
    ),
    GoRoute(
      path: '/testimonies',
      name: 'readTestimonies',
      builder: (context, state) => const ReadTestimoniesScreen(),
    ),
    GoRoute(
      path: '/help/request',
      name: 'helpRequest',
      builder: (context, state) => const HelpRequestScreen(),
    ),
    GoRoute(
      path: '/help/offer',
      name: 'helpOffer',
      builder: (context, state) => const HelpOfferScreen(),
    ),
    GoRoute(
      path: '/ride/request',
      name: 'rideRequest',
      builder: (context, state) => const RideRequestScreen(),
    ),
    GoRoute(
      path: '/ride/offer',
      name: 'rideOffer',
      builder: (context, state) => const RideOfferScreen(),
    ),
    GoRoute(
      path: '/availability',
      name: 'availability',
      builder: (context, state) => const AvailabilitySlotScreen(),
    ),
  ],
);
