class UserProfile {
  String email;
  int experience;
  String name;
  String id;

  UserProfile({this.email, this.experience, this.name});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      email: json['email'],
      experience: json['experience'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['experience'] = this.experience;
    data['name'] = this.name;
    return data;
  }
}
