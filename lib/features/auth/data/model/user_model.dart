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
    final user = json['user'] as Map<String, dynamic>? ?? json;
    final metadata = user['user_metadata'] as Map<String, dynamic>? ?? {};
    return UserModel(
      id: user['id'] ?? '',
      email: user['email'] ?? '',
      name: metadata['full_name'] ?? user['full_name'] ?? '',
      accessToken: json['supabase_access_token'] ?? json['access_token'] ?? '',
      avatarUrl: user['avatar_url'] ?? '',
      role: user['role'] ?? '',
      createdAt: user['created_at'] ?? '',
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
