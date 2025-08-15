import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/ride_destination.dart';
import '../services/ride_service.dart';
import '../widgets/destination_picker.dart';

/// Ask for Ride: vertical form (date, time, destination → submit → status line).
class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key});

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  final _timeController = TextEditingController();
  final _noteController = TextEditingController();
  DateTime _date = DateTime.now();
  RideDestination? _selectedDest;
  bool _submitting = false;
  String? _statusText;

  // Prototype destinations (hardcoded). Replace with Firestore later.
  final List<RideDestination> _destinations = const [
    RideDestination(
      id: 'compass-colleyville',
      name: 'Compass Church — Colleyville',
      address: '2600 Hall Johnson Rd, Colleyville, TX 76034',
      lat: 32.8931, lng: -97.1297,
    ),
    RideDestination(
      id: 'compass-roanoke',
      name: 'Compass Church — Roanoke',
      address: '118 N Oak St, Roanoke, TX 76262',
      lat: 33.0045, lng: -97.2256,
    ),
    RideDestination(
      id: 'compass-north-fort-worth',
      name: 'Compass Church — North Fort Worth (NOFO)',
      address: 'North Fort Worth, TX',
      lat: 32.9124, lng: -97.3211,
    ),
    RideDestination(
      id: 'compass-mid-cities',
      name: 'Compass Church — Mid-Cities',
      address: 'Hurst / Euless / Bedford, TX',
      lat: 32.8466, lng: -97.1860,
    ),
  ];

  @override
  void dispose() {
    _timeController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDate: _date,
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final now = TimeOfDay.now();
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: (now.minute ~/ 5) * 5),
    );
    if (picked != null) {
      _timeController.text = picked.format(context);
    }
  }

  Future<void> _submit() async {
    if (_selectedDest == null || _timeController.text.trim().isEmpty) {
      setState(() => _statusText = 'Please select a destination and time.');
      return;
    }
    setState(() {
      _submitting = true;
      _statusText = null;
    });
    try {
      final id = await RideService.createRideRequest(
        destinationId: _selectedDest!.id,
        destinationName: _selectedDest!.name,
        rideDate: _date,
        rideTime: _timeController.text.trim(),
        note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
      );
      setState(() {
        _statusText = 'Request submitted ✓ (ID: $id)';
      });
    } catch (e) {
      setState(() => _statusText = 'Error: $e');
    } finally {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('EEE, MMM d, yyyy');
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a Ride'),
        leading: const Icon(Icons.directions_car_outlined),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date
            Text('Select Date', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(12),
              child: InputDecorator(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(dateFmt.format(_date)),
                    const Icon(Icons.calendar_month_outlined),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Time
            Text('Select Time', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            TextField(
              controller: _timeController,
              readOnly: true,
              onTap: _pickTime,
              decoration: InputDecoration(
                hintText: 'Tap to pick a time',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                suffixIcon: const Icon(Icons.schedule_outlined),
              ),
            ),
            const SizedBox(height: 16),

            // Optional note
            Text('Note (optional)', style: textTheme.titleMedium),
            const SizedBox(height: 8),
            TextField(
              controller: _noteController,
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'E.g., pickup near Main & 3rd',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                prefixIcon: const Icon(Icons.edit_note_outlined),
              ),
            ),
            const SizedBox(height: 16),

            // Destination
            Row(
              children: [
                const Icon(Icons.place_outlined),
                const SizedBox(width: 6),
                Text('Destination', style: textTheme.titleMedium),
              ],
            ),
            DestinationPicker(
              destinations: _destinations,
              selected: _selectedDest,
              onChanged: (d) => setState(() => _selectedDest = d),
            ),
            const SizedBox(height: 20),

            // Submit
            FilledButton.icon(
              onPressed: _submitting ? null : _submit,
              icon: const Icon(Icons.send_rounded),
              label: Text(_submitting ? 'Submitting...' : 'Submit Request'),
            ),
            const SizedBox(height: 12),

            // Status line (green if success, red if error)
            if (_statusText != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _statusText!.startsWith('Error')
                      ? theme.colorScheme.errorContainer
                      : theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      _statusText!.startsWith('Error') ? Icons.error_outline : Icons.check_circle_outline,
                      color: _statusText!.startsWith('Error')
                          ? theme.colorScheme.onErrorContainer
                          : theme.colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _statusText!,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: _statusText!.startsWith('Error')
                              ? theme.colorScheme.onErrorContainer
                              : theme.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
