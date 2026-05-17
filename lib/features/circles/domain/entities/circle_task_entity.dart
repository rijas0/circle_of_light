class CircleTaskEntity {
  final String title;
  final bool? completed;
  final DateTime? dateTime;
  final int? totalTaskCount;
  final int? completedTask;

  CircleTaskEntity({required this.title, this.completed,this.dateTime,this.totalTaskCount,this.completedTask});
}