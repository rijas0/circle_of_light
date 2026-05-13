import 'package:circle_of_light/features/dashboard/domain/entity/circle_task_entity.dart';

class CircleTaskModel extends CircleTaskEntity {
  CircleTaskModel({required super.title, super.dateTime, super.completed});

  factory CircleTaskModel.fromJSON(Map<String, dynamic> json) {
    return CircleTaskModel(
      title: json['circleTaskTitle'],
      completed: json['circleTaskStatus'] ?? false,
      dateTime: json['circleTaskDate'] != null 
        ? DateTime.parse(json['circleTaskDate']) 
        : DateTime.now(),
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
