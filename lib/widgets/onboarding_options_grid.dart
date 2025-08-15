import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'onboarding_option_card.dart'; // Ensure this import points correctly

class OnboardingOptionsGrid extends StatelessWidget {
  const OnboardingOptionsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      {
        'icon': Icons.handshake_outlined,
        'label': 'Lend a Hand',
        'route': '/give/help',

      },
      {
        'icon': Icons.volunteer_activism_outlined,
        'label': 'Ask for Help',
        'route': '/ask/help',
      },
      {
        'icon': Icons.self_improvement_outlined,
        'label': 'Pray For Me',
        'route': '/pray/for',
      },
      {
        'icon': Icons.psychology_alt_outlined,
        'label': 'Let’s Pray',
        'route': '/lets/pray',
      },
      {
        'icon': Icons.local_taxi_outlined,
        'label': 'Offer Ride',
        'route': '/ride/offer',
        'onTap': () => context.push('/ride/offer'),
      },
      {
        'icon': Icons.directions_car_filled_outlined,
        'label': 'Request Ride',
        'route': '/ride/request',
        'onTap': () => context.push('/ride/request'),
      },
      {
        'icon': Icons.menu_book_outlined,
        'label': 'Testimony Feed',
        'route': '/testimony',
      },
      {
        'icon': Icons.explore_outlined,
        'label': 'Just Browsing',
        'route': '/about/samaria',
      },
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 40),
      childAspectRatio: 1.0, // Adjusted for more compact box
      children: options
          .map((option) => OnboardingOptionCard(
        icon: option['icon'] as IconData,
        label: option['label'] as String,
        onTap: () => context.go(option['route'] as String),
      ))
          .toList(),
    );

  }
}
