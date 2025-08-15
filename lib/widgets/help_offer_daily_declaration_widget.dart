import 'package:flutter/material.dart';

class LendAHandDailyDeclaration extends StatelessWidget {
  LendAHandDailyDeclaration({super.key});

  final List<Map<String, String>> dailyMessages = [
    {
      'title': 'Today, I will be a blessing to someone.',
      'verse': 'Do not withhold good when it is within your power to act. – Proverbs 3:27'
    },
    {
      'title': 'Today, I choose kindness.',
      'verse': 'Be kind to one another, tenderhearted, forgiving one another. – Ephesians 4:32'
    },
    {
      'title': 'Today, I will serve with joy.',
      'verse': 'Serve the Lord with gladness! – Psalm 100:2'
    },
    {
      'title': 'Today, I will lift others up.',
      'verse': 'Encourage one another and build each other up. – 1 Thessalonians 5:11'
    },
    {
      'title': 'Today, I will go the extra mile.',
      'verse': 'If anyone forces you to go one mile, go with them two. – Matthew 5:41'
    },
    {
      'title': 'Today, I will be present for someone.',
      'verse': 'Carry each other’s burdens. – Galatians 6:2'
    },
    {
      'title': 'Today, I will walk humbly and serve freely.',
      'verse': 'Whoever wants to be great must be your servant. – Mark 10:43'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final int index = DateTime.now().weekday % dailyMessages.length;
    final daily = dailyMessages[index];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              daily['title'] ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.amberAccent,
                shadows: [
                  Shadow(
                      color: Colors.black.withOpacity(0.8), blurRadius: 4),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              daily['verse'] ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
