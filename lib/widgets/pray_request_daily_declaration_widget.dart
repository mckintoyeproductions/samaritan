import 'package:flutter/material.dart';

class PrayForDailyDeclarationWidget extends StatelessWidget {
  PrayForDailyDeclarationWidget({super.key});

  final List<Map<String, String>> declarations = [
    {
      'text': 'Day 1: I believe that God hears me when I cry out.',
      'verse': 'Psalm 34:17',
    },
    {
      'text': 'Day 2: I will not suffer in silence — I choose to ask for prayer.',
      'verse': 'James 5:16',
    },
    {
      'text': 'Day 3: Even in my weakness, God is strong.',
      'verse': '2 Corinthians 12:9',
    },
    {
      'text': 'Day 4: When I cannot pray, the Spirit intercedes for me.',
      'verse': 'Romans 8:26',
    },
    {
      'text': 'Day 5: I release fear and welcome healing through prayer.',
      'verse': 'Philippians 4:6-7',
    },
    {
      'text': 'Day 6: I trust that God sees my pain and is near.',
      'verse': 'Psalm 34:18',
    },
    {
      'text': 'Day 7: I am not alone — help is one prayer away.',
      'verse': 'Matthew 18:20',
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
            "Prayer Request Declaration",
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
