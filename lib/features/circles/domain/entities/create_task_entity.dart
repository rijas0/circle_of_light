class CreateTaskEntity {
  final String circleId;
  final String taskName;
  final String? taskDescription;
  final String? taskType;
  final DateTime taskDueDate;

  CreateTaskEntity({
    required this.circleId,
    required this.taskName,
    this.taskDescription,
    this.taskType,
    required this.taskDueDate,
  });
}
