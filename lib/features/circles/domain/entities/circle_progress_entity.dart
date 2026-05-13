
class CircleProgressEntity {
  final String overallPercentage;
  final String completedTaskCount;
  final String totalTaskCount;
  final String completedMembersCount;

  CircleProgressEntity({
    required this.completedMembersCount,
    required this.completedTaskCount,
    required this.overallPercentage,
    required this.totalTaskCount,
  });
}
