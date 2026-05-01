class UserEntity {
  final String id;
  final String email;
  final String name;
  final String accessToken;
  final String role;
  final String avatarUrl;
  final String createdAt;

  UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.accessToken,
    required this.avatarUrl,
    required this.role,
    required this.createdAt
  });
}