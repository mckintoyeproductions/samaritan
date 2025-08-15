import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/ride_request.dart';
import '../services/ride_service.dart';

/// Offer a Ride: shows list of current OPEN requests. Tap → confirm → status becomes matched.
class RideOfferScreen extends StatelessWidget {
  const RideOfferScreen({super.key});

  Future<void> _confirmMatch(BuildContext context, RideRequest req) async {
    final theme = Theme.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Ride Offer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                Chip(
                  label: Text('Date: ${req.rideDate.toLocal().toString().split(" ").first}'),
                  avatar: const Icon(Icons.calendar_today_outlined, size: 18),
                  visualDensity: VisualDensity.compact,
                ),
                Chip(
                  label: Text('Time: ${req.rideTime}'),
                  avatar: const Icon(Icons.schedule_outlined, size: 18),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.place_outlined),
                const SizedBox(width: 6),
                Expanded(child: Text(req.destinationName, style: theme.textTheme.titleMedium)),
              ],
            ),
            if ((req.note ?? '').isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.notes_outlined),
                  const SizedBox(width: 6),
                  Expanded(child: Text(req.note!)),
                ],
              ),
            ],
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton.icon(
            onPressed: () => Navigator.pop(ctx, true),
            icon: const Icon(Icons.check_circle_outline),
            label: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (ok == true) {
      try {
        final driverId = FirebaseAuth.instance.currentUser?.uid;
        await RideService.matchRequest(requestId: req.id, driverId: driverId);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ride matched ✓')),
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Widget _statusChip(BuildContext context, RideRequestStatus status) {
    final theme = Theme.of(context);
    Color bg;
    Color fg;

    switch (status) {
      case RideRequestStatus.matched:
        bg = Colors.green.withOpacity(0.15);
        fg = Colors.green.shade800;
        break;
      case RideRequestStatus.open:
        bg = Colors.amber.withOpacity(0.2);
        fg = Colors.amber.shade900;
        break;
      case RideRequestStatus.completed:
        bg = theme.colorScheme.secondaryContainer;
        fg = theme.colorScheme.onSecondaryContainer;
        break;
      case RideRequestStatus.cancelled:
        bg = theme.colorScheme.errorContainer;
        fg = theme.colorScheme.onErrorContainer;
        break;
    }

    return Chip(
      backgroundColor: bg,
      label: Text(status.name),
      labelStyle: TextStyle(
        fontWeight: FontWeight.w700,
        color: fg,
      ),
      avatar: Icon(
        status == RideRequestStatus.matched
            ? Icons.verified_outlined
            : status == RideRequestStatus.open
            ? Icons.new_releases_outlined
            : status == RideRequestStatus.completed
            ? Icons.check_circle_outline
            : Icons.cancel_outlined,
        color: fg,
        size: 18,
      ),
      visualDensity: VisualDensity.compact,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offer a Ride'),
        leading: const Icon(Icons.volunteer_activism_outlined),
      ),
      body: StreamBuilder<List<RideRequest>>(
        stream: RideService.streamOpenRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            final err = snapshot.error.toString();
            final isPerm = err.contains('permission-denied');
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  isPerm
                      ? 'Thank you for your interest to offer a ride for others. The core trait of a Good Samaritan!'
                      ' \nPlease signup/login to get authenticated and get you on your way.'
                      : 'Error: $err',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text('No open ride requests yet.'),
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final req = items[i];
              return Card(
                elevation: 1.5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  leading: CircleAvatar(
                    child: const Icon(Icons.directions_car_outlined),
                  ),
                  title: Text(
                    req.destinationName,
                    style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: [
                            Chip(
                              label: Text(req.rideDate.toLocal().toString().split(' ').first),
                              avatar: const Icon(Icons.calendar_today_outlined, size: 18),
                              visualDensity: VisualDensity.compact,
                            ),
                            Chip(
                              label: Text(req.rideTime),
                              avatar: const Icon(Icons.schedule_outlined, size: 18),
                              visualDensity: VisualDensity.compact,
                            ),
                            _statusChip(context, req.status),
                          ],
                        ),
                        if ((req.note ?? '').isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.notes_outlined, size: 18),
                                const SizedBox(width: 6),
                                Expanded(child: Text(req.note!)),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  trailing: FilledButton(
                    onPressed: () => _confirmMatch(context, req),
                    child: const Text('Give Ride'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
