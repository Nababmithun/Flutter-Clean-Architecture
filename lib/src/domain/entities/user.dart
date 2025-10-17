import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String email;
  final String? mobile;
  final String? gender;
  final bool isAdmin;
  final String? avatarUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.mobile,
    this.gender,
    this.isAdmin = false,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [id, email];

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int,
        name: (json['name'] ?? '') as String,
        email: (json['email'] ?? '') as String,
        mobile: json['mobile'] as String?,
        gender: json['gender'] as String?,
        isAdmin: (json['is_admin'] ?? false) as bool,
        avatarUrl: json['avatar_url'] as String?,
      );
}
