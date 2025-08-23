class AvailabilitySlot {
  final String day;
  final bool morning;
  final bool afternoon;
  final bool evening;

  AvailabilitySlot({
    required this.day,
    this.morning = false,
    this.afternoon = false,
    this.evening = false,
  });

  Map<String, dynamic> toMap() => {
    'morning': morning,
    'afternoon': afternoon,
    'evening': evening,
  };
}
