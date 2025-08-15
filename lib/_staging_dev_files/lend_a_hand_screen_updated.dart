
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LendAHandScreen extends StatefulWidget {
  const LendAHandScreen({super.key});

  @override
  State<LendAHandScreen> createState() => _LendAHandScreenState();
}

class _LendAHandScreenState extends State<LendAHandScreen> {
  final today = DateTime.now();
  final Map<String, Map<String, bool>> availability = {};

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 14; i++) {
      final date = today.add(Duration(days: i));
      final key = DateFormat('yyyy-MM-dd').format(date);
      availability[key] = {'Morning': false, 'Afternoon': false, 'Evening': false};
    }
  }

  void toggleAvailability(String date, String time) {
    setState(() {
      availability[date]![time] = !availability[date]![time]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final next14Days = List.generate(14, (i) => today.add(Duration(days: i)));

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/lend_a_hand_1.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.3)),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Thank You, Good Samaritan!",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                        shadows: [Shadow(blurRadius: 4, color: Colors.black54, offset: Offset(1, 1))],
                      )),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: const [
                        Text("Today, I will walk humbly and serve freely.",
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                        SizedBox(height: 4),
                        Text("Whoever wants to be great must be your servant. – Mark 10:43",
                            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white70, fontSize: 14)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text("Please select your availability below in the next 2 weeks.",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  _buildAvailabilityTable(next14Days),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: () {
                      // Handle submission
                    },
                    icon: const Icon(Icons.volunteer_activism_outlined),
                    label: const Text("Submit Availability"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityTable(List<DateTime> days) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
        },
        border: TableBorder.symmetric(inside: BorderSide(color: Colors.grey)),
        children: [
          const TableRow(
            decoration: BoxDecoration(color: Colors.white54),
            children: [
              Padding(padding: EdgeInsets.all(8), child: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
              Padding(padding: EdgeInsets.all(8), child: Text('Morning', textAlign: TextAlign.center)),
              Padding(padding: EdgeInsets.all(8), child: Text('Afternoon', textAlign: TextAlign.center)),
              Padding(padding: EdgeInsets.all(8), child: Text('Evening', textAlign: TextAlign.center)),
            ],
          ),
          ...days.map((day) {
            final dateKey = DateFormat('yyyy-MM-dd').format(day);
            final label = DateFormat('EEEE, MMM dd').format(day);
            return TableRow(
              children: [
                Padding(padding: const EdgeInsets.all(8), child: Text(label)),
                ...['Morning', 'Afternoon', 'Evening'].map((time) => GestureDetector(
                      onTap: () => toggleAvailability(dateKey, time),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          availability[dateKey]![time]!
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: availability[dateKey]![time]!
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    )),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}
