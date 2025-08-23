class AvailabilitySlot {
  final String userId;
  final DateTime date;
  final String timeOfDay; // 'morning', 'afternoon', 'evening'
  final bool available;

  AvailabilitySlot({required this.userId, required this.date, required this.timeOfDay, required this.available});

  Map<String, dynamic> toMap() => {
    'userId': userId,
    'date': date.toIso8601String(),
    'timeOfDay': timeOfDay,
    'available': available,
  };

  factory AvailabilitySlot.fromMap(Map<String, dynamic> map) => AvailabilitySlot(
    userId: map['userId'],
    date: DateTime.parse(map['date']),
    timeOfDay: map['timeOfDay'],
    available: map['available'],
  );
}
