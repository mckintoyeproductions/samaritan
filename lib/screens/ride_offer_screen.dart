import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/ride_request_model.dart';
import '../services/ride_service.dart';
import '../widgets/ride_top_switcher.dart';

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


// Inside build() before StreamBuilder:
    Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text('“Thanks for offering to help. Compassion drives community.”', textAlign: TextAlign.center),
    );
    const SizedBox(height: 8);

    return Scaffold(

      appBar: AppBar(

        title: const Text('Offer a Ride'),
        leading: const Icon(Icons.volunteer_activism_outlined),
      ),


      body: Column(
        children: [
          Container(
            // In RideOfferScreen build(): body: Column(children:[ ... ])

            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              '“Thanks for offering to help. Compassion drives community.”',
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 8),

          const RideTopSwitcher(isOffer: true),

          // Expand to fill remaining space with the list/loader
          Expanded(
            child: StreamBuilder<List<RideRequest>>(
              stream: RideService.streamOpenRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No open ride requests yet.'));
                }

                final requests = snapshot.data!;
                return ListView.builder(
                  itemCount: requests.length,
                  itemBuilder: (context, i) {
                    final r = requests[i];
                    return ListTile(
                      leading: const Icon(Icons.directions_car),
                      title: Text(r.destinationName),
                      subtitle: Text('${r.rideDate.toLocal()} • ${r.rideTime}'),
                      trailing: ElevatedButton(
                        onPressed: () async {
                          await RideService.matchRequest(requestId: r.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Matched ride request ${r.id}')),
                          );
                        },
                        child: const Text('Give Ride'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),

    );
  }
}
