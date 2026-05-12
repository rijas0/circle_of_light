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

  
}
