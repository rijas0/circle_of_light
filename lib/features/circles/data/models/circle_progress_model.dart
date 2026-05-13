import 'package:circle_of_light/features/circles/domain/entities/circle_progress_entity.dart';

class CircleProgressModel extends CircleProgressEntity {
  CircleProgressModel({
    required super.completedMembersCount,
    required super.completedTaskCount,
    required super.overallPercentage,
    required super.totalTaskCount,
  });

  factory CircleProgressModel.fromJSON(Map<String, dynamic> json) {
    return CircleProgressModel(
      completedMembersCount: json['completedMembersCount'],
      completedTaskCount: json['completedTaskCount'],
      overallPercentage: json['overallPercentage'],
      totalTaskCount: json['totalTaskCount'],
    );
  }
  Map<String, dynamic> toJSON() {
    return {
      'completedMembersCount': completedMembersCount,
      'completedTaskCount': completedTaskCount,
      'overallPercentage': overallPercentage,
      'totalTaskCount': totalTaskCount,
    };
  }
}
