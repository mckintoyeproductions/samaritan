import 'package:flutter/material.dart';
import 'dart:ui';
import '../widgets/help_offer_daily_declaration_widget.dart';

class LendAHandScreen extends StatefulWidget {
  const LendAHandScreen({super.key});

  @override
  State<LendAHandScreen> createState() => _LendAHandScreenState();
}

class _LendAHandScreenState extends State<LendAHandScreen> {
  final List<String> dates = List.generate(14, (index) {
    final now = DateTime.now().add(Duration(days: index));
    return '${weekdays[now.weekday % 7]}, ${months[now.month - 1]} ${now.day.toString().padLeft(2, '0')}';
  });

  final Map<String, Map<String, bool>> availability = {};

  static const weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
  static const months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
  final slots = ['Morning', 'Afternoon', 'Evening', 'Anytime'];

  @override
  void initState() {
    super.initState();
    for (var date in dates) {
      availability[date] = {
        for (var slot in slots) slot: false,
      };
    }
  }

  void toggleSlot(String date, String slot) {
    setState(() {
      availability[date]![slot] = !(availability[date]![slot] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Theme.of(context).colorScheme.background;
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'assets/images/lend_a_hand_1.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    const Text(
                      "Thank You, Good Samaritan!",
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                    ),
                    LendAHandDailyDeclaration(),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 6.0),
                      child: Text(
                        "Please select your availability below in the next 2 weeks.",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Table(
                          columnWidths: const {
                            0: FlexColumnWidth(2.5),
                            1: FlexColumnWidth(),
                            2: FlexColumnWidth(),
                            3: FlexColumnWidth(),
                            4: FlexColumnWidth(),
                          },
                          border: TableBorder.symmetric(inside: BorderSide(width: 0.25, color: Colors.grey.shade300)),
                          children: [
                            TableRow(
                              decoration: BoxDecoration(color: Colors.grey.shade100),
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Date", style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                for (var slot in slots)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(slot, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  )
                              ],
                            ),
                            for (var date in dates)
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(date),
                                  ),
                                  for (var slot in slots)
                                    InkWell(
                                      onTap: () => toggleSlot(date, slot),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          availability[date]![slot]!
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color: availability[date]![slot]!
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton.icon(
                        onPressed: () => print(availability),
                        icon: const Icon(Icons.volunteer_activism),
                        label: const Text("Submit Availability"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
