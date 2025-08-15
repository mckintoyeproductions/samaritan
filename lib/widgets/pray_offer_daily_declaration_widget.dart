import 'package:flutter/material.dart';

class PrayWithDailyDeclarationWidget extends StatelessWidget {
  PrayWithDailyDeclarationWidget({super.key});

  final List<Map<String, String>> declarations = [
    {
      'text': 'Day 1: I will stand in the gap for my neighbor in prayer.',
      'verse': 'Ezekiel 22:30',
    },
    {
      'text': 'Day 2: Two or more gathered in His name—God is with us.',
      'verse': 'Matthew 18:20',
    },
    {
      'text': 'Day 3: I commit to lift others up when they are down.',
      'verse': 'Galatians 6:2',
    },
    {
      'text': 'Day 4: When we agree in prayer, miracles can happen.',
      'verse': 'Matthew 21:22',
    },
    {
      'text': 'Day 5: I will be a light by praying with love and faith.',
      'verse': '1 Timothy 2:1',
    },
    {
      'text': 'Day 6: I join hearts and voices to intercede for others.',
      'verse': 'James 5:14-15',
    },
    {
      'text': 'Day 7: My prayers will ripple blessings beyond what I see.',
      'verse': 'Job 42:10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int index = DateTime.now().weekday % 7;
    final declaration = declarations[index];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Let’s Pray Declaration",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            declaration['text']!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.95),
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            declaration['verse']!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

