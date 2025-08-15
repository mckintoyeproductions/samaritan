import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum RideRequestStatus { open, matched, completed, cancelled }

@immutable
class RideRequest {
  final String id;
  final String? userId;
  final String destinationId;
  final String destinationName;
  final DateTime rideDate; // date-only
  final String rideTime;   // "h:mm a" for prototype
  final RideRequestStatus status;
  final String? matchedOfferId;
  final Timestamp createdAt;
  final String? note; // optional rider note

  const RideRequest({
    required this.id,
    required this.userId,
    required this.destinationId,
    required this.destinationName,
    required this.rideDate,
    required this.rideTime,
    required this.status,
    required this.createdAt,
    this.matchedOfferId,
    this.note,
  });

  factory RideRequest.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return RideRequest(
      id: doc.id,
      userId: data['userId'] as String?,
      destinationId: data['destinationId'] as String? ?? '',
      destinationName: data['destinationName'] as String? ?? '',
      rideDate: (data['rideDate'] as Timestamp).toDate(),
      rideTime: data['rideTime'] as String? ?? '',
      status: _statusFromString(data['status'] as String? ?? 'open'),
      matchedOfferId: data['matchedOfferId'] as String?,
      createdAt: data['createdAt'] as Timestamp? ?? Timestamp.now(),
      note: data['note'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'destinationId': destinationId,
    'destinationName': destinationName,
    'rideDate': Timestamp.fromDate(DateTime(rideDate.year, rideDate.month, rideDate.day)),
    'rideTime': rideTime,
    'status': describeEnum(status),
    'matchedOfferId': matchedOfferId,
    'createdAt': createdAt,
    'note': note,
  };

  static RideRequestStatus _statusFromString(String s) {
    switch (s) {
      case 'matched':
        return RideRequestStatus.matched;
      case 'completed':
        return RideRequestStatus.completed;
      case 'cancelled':
        return RideRequestStatus.cancelled;
      default:
        return RideRequestStatus.open;
    }
  }
}
