



import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/help_request_daily_declaration_widget.dart';

class AskForHelpScreen extends StatefulWidget {
  const AskForHelpScreen({super.key});

  @override
  State<AskForHelpScreen> createState() => _AskForHelpScreenState();
}

class _AskForHelpScreenState extends State<AskForHelpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  Map<String, bool> selectedTimes = {
    'Morning': false,
    'Afternoon': false,
    'Evening': false,
    'Anytime': false,
  };

  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  void _submitRequest() {
    // TODO: Submit to Firestore
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Help request submitted!")),
    );
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
                'assets/images/ask_for_help_2.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                   // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 8),
                      AfhDailyDeclarationWidget(),
                      const SizedBox(height: 45),
                      Text(
                        "🧡 Need a Helping hand?",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Please fill out the below, providing as much information as you can to better match you with a waiting hand.",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'In summary, I need ...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 6.0),
                            child: Text(
                              'Please describe (if you could) in detail the help you need.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          TextField(
                            controller: _descriptionController,
                            maxLines: 10,
                            decoration: const InputDecoration(
                              hintText: 'Type your request here...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ],
                      ),


                      const SizedBox(height: 16), TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name (Optional)',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            _selectedDate == null
                                ? "Needed by date?"
                                : "Needed by: ${DateFormat('EEE, MMM d').format(_selectedDate!)}",
                          ),
                          const SizedBox(width: 12),
                          ElevatedButton.icon(
                            onPressed: _selectDate,
                            icon: const Icon(Icons.calendar_today),
                            label: const Text("Pick Date"),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(height: 60),
                          Text(

                                 "Preferred time of day? "

                          ),
                          Wrap(
                            spacing: 10,
                            children: selectedTimes.keys.map((time) {
                              return FilterChip(
                                label: Text(time),
                                selected: selectedTimes[time]!,
                                onSelected: (bool value) {
                                  setState(() {
                                    selectedTimes[time] = value;
                                  });
                                },
                              );
                            }).toList(),
                          ),
                          const SizedBox(width: 12),

                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.send),
                          label: const Text("Submit"),
                          onPressed: _submitRequest,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// Make sure to define or import this widget
class AfhDailyDeclarationWidget extends StatelessWidget {
  const AfhDailyDeclarationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Today, I place my trust in God’s hand.",
            style: TextStyle(fontSize: 16, color: Colors.amber, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4),
          Text(
            "Lord, You are my help and refuge. – Psalm 46:1",
            style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
