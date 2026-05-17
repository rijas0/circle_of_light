import 'package:circle_of_light/features/circles/domain/entities/circle_progress_entity.dart';

/*
"overall_progress_percentage": 72,
    "tasks_completed_count": 18,
    "total_tasks_possible": 25,
    "completed_members_count": 6,
    "total_members_count": 8
* */
class CircleProgressModel extends CircleProgressEntity {
  CircleProgressModel({
    required super.completedMembersCount,
    required super.completedTaskCount,
    required super.overallPercentage,
    required super.totalTaskCount,
    required super.totalMembersCount,
  });

  factory CircleProgressModel.fromJSON(Map<String, dynamic> json) {
    return CircleProgressModel(
      completedMembersCount: json['completed_members_count'] ?? 0,
      completedTaskCount: json['tasks_completed_count'] ?? 0,
      overallPercentage: json['overall_progress_percentage'] ?? 0,
      totalTaskCount: json['total_tasks_possible'] ?? 0,
      totalMembersCount: json['total_members_count'] ?? 0,
    );
  }
  Map<String, dynamic> toJSON() {
    return {
      'completedMembersCount': completedMembersCount,
      'completedTaskCount': completedTaskCount,
      'overallPercentage': overallPercentage,
      'totalTaskCount': totalTaskCount,
      'totalMembersCount':totalMembersCount,
    };
  }
}
