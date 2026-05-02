import '../../domain/entities/user_entitie.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.accessToken,
    required super.avatarUrl,
    required super.role,
    required super.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      accessToken: 'access_token',
      avatarUrl: 'avatarUrl',
      role: '',
      createdAt: 'role',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": id,
      "email": email,
      "full_name": name,
      "access_token": accessToken,
      "avatarUrl": avatarUrl,
      "role": role,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      accessToken: accessToken,
      avatarUrl: avatarUrl,
      role: role,
      createdAt: createdAt,
    );
  }
}
