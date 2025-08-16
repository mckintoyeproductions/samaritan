import 'package:flutter/material.dart';
// If you use go_router, uncomment this:
// import 'package:go_router/go_router.dart';

class RideTopSwitcher extends StatelessWidget {
  final bool isOffer; // true on Offer screen, false on Request screen
  const RideTopSwitcher({super.key, required this.isOffer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: SegmentedButton<int>(
        segments: const [
          ButtonSegment(value: 0, label: Text('Request Ride'), icon: Icon(Icons.directions_car_outlined)),
          ButtonSegment(value: 1, label: Text('Offer Ride'), icon: Icon(Icons.volunteer_activism_outlined)),
        ],
        selected: {isOffer ? 1 : 0},
        onSelectionChanged: (sel) {
          final v = sel.first;
          if (v == 0 && isOffer) {
            // go to Request
            // If you use go_router:
            // context.go('/ride/request');
            Navigator.of(context).pushReplacementNamed('/ride/request');
          } else if (v == 1 && !isOffer) {
            // go to Offer
            // context.go('/ride/offer');
            Navigator.of(context).pushReplacementNamed('/ride/offer');
          }
        },
      ),
    );
  }
}
