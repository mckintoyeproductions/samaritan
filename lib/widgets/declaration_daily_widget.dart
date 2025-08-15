import 'package:flutter/material.dart';

class DailyDeclarationWidget extends StatelessWidget {
  DailyDeclarationWidget({Key? key}) : super(key: key);

  final List<Map<String, String>> declarations = [
    {
      'title': 'Today, I will act with compassion.',
      'verse': 'Be kind and compassionate to one another. – Ephesians 4:32',
    },
    {
      'title': 'Today, I will check in on someone.',
      'verse': 'Carry each other’s burdens. – Galatians 6:2',
    },
    {
      'title': 'Today, I will pray for my neighbor.',
      'verse': 'Pray for one another, that you may be healed. – James 5:16',
    },
    {
      'title': 'Today, I will offer help before being asked.',
      'verse': 'Do not withhold good... when it is in your power to act. – Proverbs 3:27',
    },
    {
      'title': 'Today, I will speak life and hope.',
      'verse': 'The tongue has the power of life and death. – Proverbs 18:21',
    },
    {
      'title': 'Today, I will make room for strangers.',
      'verse': 'Do not forget to show hospitality to strangers. – Hebrews 13:2',
    },
    {
      'title': 'Today, I will walk in humility and grace.',
      'verse': 'Walk humbly with your God. – Micah 6:8',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int todayIndex = DateTime.now().weekday % 7; // 1=Mon ... 7=Sun → 0–6
    final declaration = declarations[todayIndex];

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            declaration['title']!,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
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
