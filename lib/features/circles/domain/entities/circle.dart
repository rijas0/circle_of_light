class CircleEntity {
  const CircleEntity({
    required this.id,
    required this.name,
    required this.memberCount,
    required this.streakDays,
    required this.isPublic,
    required this.inviteId,
    required this.creatorId, 
    required this.focus,
    this.avatarUrl,
    this.description, 
  });
  final String id;
  final String name;
  final String? description;
  final String? avatarUrl;
  final int memberCount;
  final int creatorId;
  final int inviteId;
  final String focus;
  final int streakDays;
  final bool isPublic;
}
