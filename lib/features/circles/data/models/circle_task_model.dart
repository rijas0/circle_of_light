import 'package:circle_of_light/features/circles/domain/entities/circle_task_entity.dart';

class CircleTaskModel extends CircleTaskEntity {
  CircleTaskModel({
    required super.title,
    super.dateTime,
    super.completed,
    super.completedTask,
    super.totalTaskCount,
  });

  factory CircleTaskModel.fromJSON(Map<String, dynamic> json) {
    return CircleTaskModel(
      title: json['name'] ?? '',
      completedTask: json['completed_count'] ?? 0,
      totalTaskCount: json['total_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'circleTaskTitle': title,
      'circleTaskStatus': completed,
      'circleTaskDate': dateTime,
    };
  }
}
