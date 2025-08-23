import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/availability_service.dart';

class AvailabilitySlotScreen extends StatefulWidget {
  const AvailabilitySlotScreen({super.key});

  @override
  State<AvailabilitySlotScreen> createState() => _AvailabilitySlotScreenState();
}

class _AvailabilitySlotScreenState extends State<AvailabilitySlotScreen> {
  final String _userId = 'demo-user'; // Replace with auth ID
  final Map<String, List<String>> _availability = {};

  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final List<String> slots = ['Morning', 'Afternoon', 'Evening'];

  void _toggle(String day, String slot) {
    final list = _availability[day] ?? [];
    setState(() {
      if (list.contains(slot)) {
        list.remove(slot);
      } else {
        list.add(slot);
      }
      _availability[day] = list;
    });
  }

  Future<void> _submit() async {
    await AvailabilityService().updateAvailability(
      userId: _userId,
      availability: _availability,
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Availability updated")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Availability'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...days.map((day) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(day, style: Theme.of(context).textTheme.titleMedium),
                Wrap(
                  spacing: 12,
                  children: slots.map((slot) {
                    final selected = _availability[day]?.contains(slot) ?? false;
                    return FilterChip(
                      label: Text(slot),
                      selected: selected,
                      onSelected: (_) => _toggle(day, slot),
                    );
                  }).toList(),
                ),
                const Divider(),
              ],
            );
          }),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Save'),
          ),
        ],


      ) ,

      )
    ;
  }
}
