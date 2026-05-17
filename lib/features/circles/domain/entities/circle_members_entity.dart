class CircleMemberEntity {
  final String memberId;
  final String memberName;
  final String completionStatus;
  final int streakCount;
  final String avatarUrl;
  CircleMemberEntity({
    required this.memberId,
    required this.avatarUrl,
    required this.memberName,
    required this.streakCount,
    required this.completionStatus,
  });
}
