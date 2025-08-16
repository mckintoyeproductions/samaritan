import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/ride_destination.dart';
import '../services/ride_service.dart';
import '../widgets/destination_picker.dart';
import '../widgets/ride_top_switcher.dart';
import '../widgets/google_map_campus_picker.dart';


class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key});
  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  final _timeController = TextEditingController();
  final _noteController = TextEditingController();
  final _pickupController = TextEditingController(text: 'Home (from profile)');

  DateTime _date = DateTime.now().add(const Duration(days: 1));
  RideDestination? _selectedDest;
  bool _submitting = false;
  String? _statusText;

  // Hold an initial TimeOfDay WITHOUT formatting in initState
  late TimeOfDay _initialTime;
  bool _didInitTime = false;

  final List<RideDestination> _destinations = const [
    RideDestination(
      id: 'compass-colleyville',
      name: 'Compass Church — Colleyville',
      address: '4201 Pool Rd, Colleyville, TX 76034',
      lat: 32.8859, lng: -97.1540,
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
  void initState() {
    super.initState();
    _selectedDest = _destinations.first;

    // Compute a rounded time but DO NOT call format(context) here.
    final now = TimeOfDay.now();
    _initialTime = TimeOfDay(
      hour: (now.minute < 30) ? now.hour : (now.hour + 1) % 24,
      minute: (now.minute < 30) ? 30 : 0,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safe place to use MaterialLocalizations/Theme.of(context)
    if (!_didInitTime) {
      final label = MaterialLocalizations.of(context).formatTimeOfDay(_initialTime);
      _timeController.text = label;
      _didInitTime = true;
    }
  }

  @override
  void dispose() {
    _timeController.dispose();
    _noteController.dispose();
    _pickupController.dispose();
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
    if (picked != null) _timeController.text = MaterialLocalizations.of(context).formatTimeOfDay(picked);
  }

  Future<void> _submit() async {
    if (_selectedDest == null || _timeController.text.trim().isEmpty) {
      setState(() => _statusText = 'Error: Please choose a destination and time.');
      return;
    }
    setState(() {
      _submitting = true;
      _statusText = null;
    });
    try {
      await RideService.createRideRequest(
        destinationId: _selectedDest!.id,
        destinationName: _selectedDest!.name,
        rideDate: _date,
        rideTime: _timeController.text.trim(),
        note: _noteController.text.trim().isEmpty ? null : _noteController.text.trim(),
        pickupAddress: _pickupController.text.trim().isEmpty ? null : _pickupController.text.trim(),
        // pickupLat/pickupLng can be wired later from profile/geocode
      );
      setState(() {
        _statusText = 'Request submitted ✓';
      });
    } catch (e) {
      setState(() => _statusText = 'Error: $e');
    } finally {
      setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFmt = DateFormat('EEE, MMM d, yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request a Ride'),
        leading: const Icon(Icons.directions_car_outlined),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const RideTopSwitcher(isOffer: false),

            // Quote banner
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('“Welcome! Every mile is a ministry.”', textAlign: TextAlign.center),
            ),

            // Date chips + date picker button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Pickup date',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 8),
            _DateChips(
              initial: _date,
              onChanged: (d) => setState(() => _date = d),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today_outlined),
                  label: Text('Calendar • ${dateFmt.format(_date)}'),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Time chips + time picker button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Pickup time',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 8),
            _TimeChips(
              initialLabel: _timeController.text,
              onChangedLabel: (s) => _timeController.text = s,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextButton.icon(
                  onPressed: _pickTime,
                  icon: const Icon(Icons.access_time_outlined),
                  label: Text('Time Picker • ${_timeController.text}'),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Pickup address
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextFormField(
                controller: _pickupController,
                decoration: const InputDecoration(
                  labelText: 'Pickup address',
                  hintText: 'Auto-filled from profile',
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Destination dropdown + map preview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DestinationPicker(
                destinations: _destinations,
                selected: _selectedDest,
                onChanged: (d) => setState(() => _selectedDest = d),
              ),
            ),
            _MapPreview(selected: _selectedDest),

            // Notes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _noteController,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Notes (optional)'),
              ),
            ),

            const SizedBox(height: 12),

            // Submit
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: FilledButton.icon(
                onPressed: _submitting ? null : _submit,
                icon: const Icon(Icons.send_rounded),
                label: Text(_submitting ? 'Submitting...' : 'Submit Request'),
              ),
            ),

            if (_statusText != null) ...[
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
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
                        _statusText!.startsWith('Error')
                            ? Icons.error_outline
                            : Icons.check_circle_outline,
                        color: _statusText!.startsWith('Error')
                            ? theme.colorScheme.onErrorContainer
                            : theme.colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _statusText!,
                          style: TextStyle(
                            color: _statusText!.startsWith('Error')
                                ? theme.colorScheme.onErrorContainer
                                : theme.colorScheme.onPrimaryContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ==== helpers (same file) ====

class _DateChips extends StatefulWidget {
  final DateTime initial;
  final ValueChanged<DateTime> onChanged;
  const _DateChips({required this.initial, required this.onChanged});

  @override
  State<_DateChips> createState() => _DateChipsState();
}

class _DateChipsState extends State<_DateChips> {
  late DateTime _d;
  @override
  void initState() {
    super.initState();
    _d = DateTime(widget.initial.year, widget.initial.month, widget.initial.day);
  }

  @override
  Widget build(BuildContext context) {
    final days = List.generate(14, (i) => DateTime.now().add(Duration(days: i)));
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: days.length,
        itemBuilder: (_, i) {
          final d = days[i];
          final sel = d.year == _d.year && d.month == _d.month && d.day == _d.day;
          return ChoiceChip(
            label: Text('${d.month}/${d.day}'),
            selected: sel,
            onSelected: (_) {
              setState(() => _d = d);
              widget.onChanged(d);
            },
          );
        },
      ),
    );
  }
}

class _TimeChips extends StatefulWidget {
  final String initialLabel;
  final ValueChanged<String> onChangedLabel;
  const _TimeChips({required this.initialLabel, required this.onChangedLabel});

  @override
  State<_TimeChips> createState() => _TimeChipsState();
}

class _TimeChipsState extends State<_TimeChips> {
  late String _label;
  final List<TimeOfDay> _slots = const [
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 9, minute: 30),
    TimeOfDay(hour: 11, minute: 0),
    TimeOfDay(hour: 13, minute: 0),
    TimeOfDay(hour: 15, minute: 30),
    TimeOfDay(hour: 18, minute: 0),
  ];

  @override
  void initState() {
    super.initState();
    _label = widget.initialLabel;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: _slots.length,
        itemBuilder: (_, i) {
          final t = _slots[i];
          final label = MaterialLocalizations.of(context).formatTimeOfDay(t);
          return ChoiceChip(
            label: Text(label),
            selected: label == _label,
            onSelected: (_) {
              setState(() => _label = label);
              widget.onChangedLabel(label);
            },
          );
        },
      ),
    );
  }
}

class _MapPreview extends StatelessWidget {
  final RideDestination? selected;
  const _MapPreview({required this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 0.6, color: Theme.of(context).dividerColor),
      ),
      child: Center(
        child: Text(
          selected == null
              ? 'Map preview (select a campus)'
              : 'Map preview → ${selected!.name}\n${selected!.address}',
          textAlign: TextAlign.center,
        ),
      ),

    );
  }
}
