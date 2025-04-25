class UserProfile {
  String name;
  String email;
  String phone;
  String? avatarPath;

  UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    this.avatarPath,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        name: json['name'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
        avatarPath: json['avatarPath'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'phone': phone,
        'avatarPath': avatarPath,
      };
}
