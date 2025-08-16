import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

enum RideRequestStatus { open, matched, completed, cancelled }

@immutable
class RideRequest {
  final String id;
  final String? userId;
  final String destinationId;
  final String destinationName;

  /// Date-only (no time component), stored as Firestore Timestamp (00:00).
  final DateTime rideDate;

  /// Human-friendly time label (e.g., "9:30 AM"). Kept stringy for simplicity.
  final String rideTime;

  final RideRequestStatus status;
  final String? matchedOfferId;
  final Timestamp createdAt;

  /// NEW (optional): pickup info (safe defaults if missing in old docs)
  final String? pickupAddress;
  final double? pickupLat;
  final double? pickupLng;

  final String? note;

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
    this.pickupAddress,
    this.pickupLat,
    this.pickupLng,
    this.note,
  });

  factory RideRequest.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return RideRequest(
      id: doc.id,
      userId: data['userId'] as String?,
      destinationId: (data['destinationId'] as String?) ?? '',
      destinationName: (data['destinationName'] as String?) ?? '',
      rideDate: (data['rideDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      rideTime: (data['rideTime'] as String?) ?? '',
      status: _statusFromString((data['status'] as String?) ?? 'open'),
      matchedOfferId: data['matchedOfferId'] as String?,
      createdAt: (data['createdAt'] as Timestamp?) ?? Timestamp.now(),
      pickupAddress: data['pickupAddress'] as String?,
      pickupLat: (data['pickupLat'] is num) ? (data['pickupLat'] as num).toDouble() : null,
      pickupLng: (data['pickupLng'] is num) ? (data['pickupLng'] as num).toDouble() : null,
      note: data['note'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'destinationId': destinationId,
    'destinationName': destinationName,
    'rideDate': Timestamp.fromDate(DateTime(rideDate.year, rideDate.month, rideDate.day)),
    'rideTime': rideTime,
    'status': _statusToString(status),
    'matchedOfferId': matchedOfferId,
    'createdAt': createdAt,
    if (pickupAddress != null) 'pickupAddress': pickupAddress,
    if (pickupLat != null) 'pickupLat': pickupLat,
    if (pickupLng != null) 'pickupLng': pickupLng,
    if (note != null) 'note': note,
  };

  static RideRequestStatus _statusFromString(String s) {
    switch (s) {
      case 'matched': return RideRequestStatus.matched;
      case 'completed': return RideRequestStatus.completed;
      case 'cancelled': return RideRequestStatus.cancelled;
      default: return RideRequestStatus.open;
    }
  }

  static String _statusToString(RideRequestStatus st) {
    switch (st) {
      case RideRequestStatus.matched: return 'matched';
      case RideRequestStatus.completed: return 'completed';
      case RideRequestStatus.cancelled: return 'cancelled';
      case RideRequestStatus.open: default: return 'open';
    }
  }
}
