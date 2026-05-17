
class CircleProgressEntity {
  final int overallPercentage;
  final int completedTaskCount;
  final int totalTaskCount;
  final int completedMembersCount;
  final int totalMembersCount;


  CircleProgressEntity({
    required this.completedMembersCount,
    required this.completedTaskCount,
    required this.overallPercentage,
    required this.totalTaskCount,
    required this.totalMembersCount,
  });
}
