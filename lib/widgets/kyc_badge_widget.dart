import 'package:flutter/material.dart';

class KycBadgeWidget extends StatelessWidget {
  final String? status; // 'verified', 'pending', 'rejected', null

  const KycBadgeWidget({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    String label = 'Unverified';
    Color color = Colors.grey;

    switch (status) {
      case 'verified':
        label = 'KYC Verified';
        color = Colors.green;
        break;
      case 'pending':
        label = 'KYC Pending';
        color = Colors.orange;
        break;
      case 'rejected':
        label = 'KYC Rejected';
        color = Colors.red;
        break;
    }

    return Chip(
      label: Text(label),
      backgroundColor: color.withOpacity(0.2),
      labelStyle: TextStyle(color: color),
      shape: StadiumBorder(side: BorderSide(color: color)),
    );
  }
}
