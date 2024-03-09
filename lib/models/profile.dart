class UserProfile {
  String? id;
  String fullName;
  String education;
  String location;
  int experience;

  UserProfile({
    this.id,
    required this.fullName,
    required this.education,
    required this.location,
    required this.experience,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'education': education,
      'location': location,
      'experience': experience,
    };
  }

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      fullName: json['fullName'],
      education: json['education'],
      location: json['location'],
      experience: json['experience'],
    );
  }
}