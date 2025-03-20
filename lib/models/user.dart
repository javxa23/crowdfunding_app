import 'package:json_annotation/json_annotation.dart';

// part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String username;
  final String phoneNumber;
  final String role;
  final String email;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.role,
    required this.email,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  /// JSON-оос объект руу хөрвүүлэх
  // factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  // /// Объектоос JSON руу хөрвүүлэх
  // Map<String, dynamic> toJson() => _$UserToJson(this);
}
