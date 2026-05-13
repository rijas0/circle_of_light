import 'package:circle_of_light/features/circles/domain/entities/circle_members_entity.dart';

class CircleMemberModel extends CircleMemberEntity {
  CircleMemberModel({
    required super.memberName,
    required super.streakCount,
    required super.completionStatus,
  });
  factory CircleMemberModel.fromJSON(Map<String, dynamic> json) {
    return CircleMemberModel(
      memberName: json['circleMemberName'],
      streakCount: json['circleMemberStreak'],
      completionStatus: json['circleMemberCompletionStatus'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'circleMemberName': memberName,
      'circleMemberStreak': streakCount,
      'circleMemberCompletionStatus': completionStatus,
    };
  }
}
