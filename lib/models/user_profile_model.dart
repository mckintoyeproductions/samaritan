class UserProfile {
  final String uid;
  final String name;
  final String role; // e.g., "volunteer", "rider", "prayer-warrior"
  final String location;

  UserProfile({required this.uid, required this.name, required this.role, required this.location});

  Map<String, dynamic> toMap() => {
    'uid': uid,
    'name': name,
    'role': role,
    'location': location,
  };

  factory UserProfile.fromMap(Map<String, dynamic> map) => UserProfile(
    uid: map['uid'],
    name: map['name'],
    role: map['role'],
    location: map['location'],
  );
}
