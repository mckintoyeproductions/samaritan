class UserProfileModel {
  final String? uid;
  final String? name;
  final String? email;
  final String? phone;
  final String? profileImageUrl;
  final String? location;
  final String? kycStatus; // e.g., 'pending', 'verified'

  UserProfileModel({
    this.uid,
    this.name,
    this.email,
    this.phone,
    this.profileImageUrl,
    this.location,
    this.kycStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'location': location,
      'kycStatus': kycStatus,
    };
  }

  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      profileImageUrl: map['profileImageUrl'],
      location: map['location'],
      kycStatus: map['kycStatus'],
    );
  }
}
