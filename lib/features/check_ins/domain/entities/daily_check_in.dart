enum CheckInType { read, reflected }

class DailyCheckIn {
  const DailyCheckIn({
    required this.id,
    required this.circleId,
    required this.userId,
    required this.type,
    required this.createdAt,
    this.reflectionNote,
  });

  final String id;
  final String circleId;
  final String userId;
  final CheckInType type;
  final DateTime createdAt;
  final String? reflectionNote;
}
