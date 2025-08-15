import 'package:flutter/material.dart';

class WeeklyDeclarationWidget extends StatelessWidget {
  WeeklyDeclarationWidget({super.key});

  final List<String> declarations = const [
    '🌾✨ This week, may the God of new beginnings refresh your spirit and restore your strength. (Galatians 6:9)\n🌱 May you rise in joy, walk in grace, and testify in fullness — as you step into answered prayers, ripened blessings, and unstoppable grace! 🌻✨🕊️💪🏾',
    '☀️ This week, light breaks through. Every shadow over your joy is scattered. You will rejoice again!',
    '🌈 May divine wisdom lead your decisions, and may every delay turn into divine alignment.',
    '🌿 This week, you will not strive — you will *flow*. Everything you need is already within and around you.',
    '🕊️ Walk boldly in love and truth. This week, heaven is backing you up in unseen ways.',
    '🌸 May peace guard your mind, and mercy kiss your mornings. You’re being carried in grace.',
    '🔥 This week, no fear shall bind you. You are rising. You are ready. You are anointed.',
    '💧 Every dry place shall overflow. This week, restoration flows like rivers.',
    '🍇 This is your harvest week. What you’ve prayed for in secret will blossom in public.',
    '🛡️ You are protected. You are provided for. You are prepared. Walk into this week with holy confidence.',
  ];

  int getWeekNumber(DateTime date) {
    final firstDayOfYear = DateTime(date.year, 1, 1);
    final daysPassed = date.difference(firstDayOfYear).inDays;
    return ((daysPassed + firstDayOfYear.weekday) / 7).ceil();
  }

  String getDeclarationForWeek() {
    final now = DateTime.now();
    final weekKey = getWeekNumber(now);
    final index = weekKey % declarations.length;
    return declarations[index];
  }

  @override
  Widget build(BuildContext context) {
    final declaration = getDeclarationForWeek();

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.purple.shade100),
      ),
      child: Column(
       // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🗓️ Weekly Citizen Declaration',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            declaration,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
