class PrayerRequest {
  final String id;
  final String userId;
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isAnonymous;
  final bool isAnswered;

  PrayerRequest({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.timestamp,
    this.isAnonymous = false,
    this.isAnswered = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'userId': userId,
    'title': title,
    'description': description,
    'timestamp': timestamp.toIso8601String(),
    'isAnonymous': isAnonymous,
    'isAnswered': isAnswered,
  };

  factory PrayerRequest.fromMap(Map<String, dynamic> map) => PrayerRequest(
    id: map['id'],
    userId: map['userId'],
    title: map['title'],
    description: map['description'],
    timestamp: DateTime.parse(map['timestamp']),
    isAnonymous: map['isAnonymous'] ?? false,
    isAnswered: map['isAnswered'] ?? false,
  );
}
