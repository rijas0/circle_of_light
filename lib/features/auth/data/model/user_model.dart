import '../../domain/entities/user_entitie.dart';

class UserModel extends UserEntity {
  final String accessToken;

  UserModel({
    required super.id,
    required super.email,
    required super.name,
    required this.accessToken,
    required super.avatarUrl,
    required super.role,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user_id'] ?? '',
      email: json['email'] ?? '',
      name: json['full_name'] ?? '',
      accessToken: json['access_token'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
      role: json['role'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": id,
      "email": email,
      "full_name": name,
      "access_token": accessToken,
      "avatar_url": avatarUrl,
      "role": role,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      avatarUrl: avatarUrl,
      role: role,
      createdAt: createdAt,
    );
  }
}
