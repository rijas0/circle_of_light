import '../../domain/entities/circle.dart';

class CircleModel extends CircleEntity {
  const CircleModel({
    required super.id,
    required super.name,
    required super.memberCount,
    required super.streakDays,
    required super.isPublic,
    required super.inviteId, 
    required super.creatorId,
    required super.focus,
    super.description,
    super.avatarUrl
  });

  factory CircleModel.fromJson(Map<String, dynamic> json) {
    return CircleModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      memberCount: json['member_count'] ?? 0,
      streakDays: json['streak_days'] ?? 0,
      isPublic: json['is_public'] ?? false,
      inviteId: json['invite_id'] ?? 0,
      creatorId: json['creator_id'] ?? 0,
      focus: json['focus'] ?? '',
      description: json['description'],
      avatarUrl: json['avatar_url'],
    );
  }
}
