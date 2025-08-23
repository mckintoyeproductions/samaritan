import 'package:flutter/material.dart';
import '../models/ride_destination_model.dart';

class DestinationPicker extends StatelessWidget {
  final List<RideDestination> destinations;
  final RideDestination? selected;
  final ValueChanged<RideDestination> onChanged;

  const DestinationPicker({
    super.key,
    required this.destinations,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 8),
        ...destinations.map(
              (d) => Card(
            elevation: 1.25,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: RadioListTile<String>(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              value: d.id,
              groupValue: selected?.id,
              onChanged: (_) => onChanged(d),
              title: Text(d.name, style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
              subtitle: Text(d.address, style: textTheme.bodySmall),
              secondary: const Icon(Icons.church_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
