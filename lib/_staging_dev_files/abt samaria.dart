import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/declaration_daily_widget.dart';
import '../widgets/onboarding_options_grid.dart';
import '../widgets/declaration_weekly_widgets.dart';
import '../../utilities/utils.dart';

class AboutSamariaScreen extends StatelessWidget {
  const AboutSamariaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/road_2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.4), Colors.black.withOpacity(0.6)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: ListView(
            shrinkWrap: false,
            children: [


              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    'Welcome to SAMARIA!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white.withOpacity(0.95),
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(0, 0), blurRadius: 4),
                      ],
                    ),
                  ),
                  Text(
                    'The City built on Healing & Compassion!',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white.withOpacity(0.95),
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(color: Colors.black, offset: Offset(0, 0), blurRadius: 4),
                      ],
                    ),
                  ),
                ],
              ),



              const SizedBox(height: 20),

              WeeklyDeclarationWidget(),

              const SizedBox(height: 20),





              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
