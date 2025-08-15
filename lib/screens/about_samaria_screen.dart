import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';


class AboutSamariaScreen extends StatefulWidget {
  const AboutSamariaScreen({super.key});

  @override
  State<AboutSamariaScreen> createState() => _AboutSamariaScreenState();
}

class _AboutSamariaScreenState extends State<AboutSamariaScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  bool _learnMoreSelected = false;



  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeInAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  int getWeekNumber(DateTime date) {
    final firstDay = DateTime(date.year, 1, 1);
    final daysPassed = date.difference(firstDay).inDays;
    return ((daysPassed + firstDay.weekday) / 7).ceil();
  }

  String getDeclarationForWeek() {
    final weekNumber = getWeekNumber(DateTime.now());
    final declarations = [
      '🌾✨ This week, may the God of new beginnings refresh your spirit and restore your strength. (Galatians 6:9)\n🌱 May you rise in joy, walk in grace, and testify in fullness — as you step into answered prayers, ripened blessings, and unstoppable grace! 🌻✨🕊️💪🏾',
      '🔥 This week, no fear shall bind you. You are rising. You are ready. You are anointed.',
      '💧 Every dry place shall overflow. This week, restoration flows like rivers.',
      '☀️ This week, light breaks through. Every shadow over your joy is scattered. You will rejoice again!',
      '🕊️ Walk boldly in love and truth. This week, heaven is backing you up in unseen ways.',
    ];
    return declarations[weekNumber % declarations.length];
  }

  Widget _buildCreedLine(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final declaration = getDeclarationForWeek();
    final weekNumber = getWeekNumber(DateTime.now());
    final year = DateTime.now().year;



    return Scaffold(
      body: Stack(
          children: [
      // Background image with fade
      Positioned.fill(
      child: ShaderMask(
      shaderCallback: (Rect bounds) {
    return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.white, Colors.transparent],
    ).createShader(bounds);
    },
      blendMode: BlendMode.dstIn,
      child: Opacity(
        opacity: 1,
        child: Image.asset(
          'assets/images/city_of_samaria_2.jpg',
          fit: BoxFit.cover,
        ),
      ),
    ),
    ),


      SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [

            const Text(
              'Welcome to',
              style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                fontFamily: 'DancingScript', // Make sure font is declared in pubspec.yaml
              ),
            ),
            const Text(
              'SAMARIA!',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
           // const SizedBox(height: 8),
            const Text(
              'The City built on Healing & Compassion!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            FadeTransition(
              opacity: _fadeInAnimation,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.purple.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.purple.shade100),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '🗓️ Week $weekNumber of $year',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      '''Citizen's Declaration''',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(declaration, style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse("https://docs.google.com/spreadsheets/d/yourSheetID"));
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  border: Border.all(color: Colors.blue.shade100),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.link, color: Colors.blue),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "🔗 Tap to learn more about City of Samaria (The Samaritan App)",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade200),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🌿 Become a Citizen of Samaria - The Good Samaritan',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildCreedLine('☑️ Act with compassion, not comparison'),
                  _buildCreedLine('☑️ See need, not status'),
                  _buildCreedLine('☑️ Offer what I can — even a seat or a story'),
                  _buildCreedLine('☑️ Serve in love, not for likes'),
                  _buildCreedLine('☑️ Trust that one kind act can change a life'),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          // For Accept & Join

                          onPressed: () => context.go('/auth'),

                          icon: const Icon(Icons.verified_user),
                          label: const Text("I Accept & Join"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      TextButton(
                        // For Skip for now
                        onPressed: () => context.go('/home'),

                        child: const Text("Skip for now"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      )],));



  }
}
