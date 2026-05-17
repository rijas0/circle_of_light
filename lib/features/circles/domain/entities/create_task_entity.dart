class CreateCircleEntity {
  final String action;
  final String circleId;
  final String taskName;
  final String? taskDescription;
  final String? taskType;
  final DateTime taskDueDate;

  CreateCircleEntity({
    required this.circleId,
    required this.action,
    required this.taskName,
    this.taskDescription,
    this.taskType,
    required this.taskDueDate,
  });
}
