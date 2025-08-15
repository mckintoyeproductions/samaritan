import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AfhDailyDeclarationWidget extends StatelessWidget {
  AfhDailyDeclarationWidget({super.key});

  final List<Map<String, String>> declarations = [
    {
      'text': 'Day 1: God, I lift my eyes to You — my help comes from You.',
      'verse': 'Psalm 121:1-2',
    },
    {
      'text': 'Day 2: Lord, send me help in places I don’t expect.',
      'verse': 'Isaiah 41:10',
    },
    {
      'text': 'Day 3: Even when I feel weak, Your strength is my rescue.',
      'verse': '2 Corinthians 12:9',
    },
    {
      'text': 'Day 4: I receive the help of the Holy Spirit today.',
      'verse': 'John 14:26',
    },
    {
      'text': 'Day 5: God, raise people to carry me through this season.',
      'verse': 'Ecclesiastes 4:9-10',
    },
    {
      'text': 'Day 6: I reject shame — I am not alone in my need.',
      'verse': 'Romans 8:26',
    },
    {
      'text': 'Day 7: God, You are my present help in time of trouble.',
      'verse': 'Psalm 46:1',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int dayIndex = DateTime.now().weekday % 7;
    final declaration = declarations[dayIndex];

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
            "Today’s Prayer Declaration",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 3,
                  offset: const Offset(1, 1),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            declaration['text']!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withOpacity(0.95),
              height: 1.5,
              fontWeight: FontWeight.w500,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 3,
                ),
              ],
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
