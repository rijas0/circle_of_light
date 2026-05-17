import 'package:circle_of_light/features/circles/domain/entities/circle_members_entity.dart';

class CircleMemberModel extends CircleMemberEntity {
  CircleMemberModel({
    required super.memberName,
    required super.streakCount,
    required super.completionStatus,
    required super.memberId,
    required super.avatarUrl,
  });
  factory CircleMemberModel.fromJSON(Map<String, dynamic> json) {
    return CircleMemberModel(
      memberName: json['full_name'] ?? '',
      streakCount: json['streak'] ?? 0,
      completionStatus: json['status'] ?? '',
      memberId: json['id'] ?? '',
      avatarUrl: json['avatar_url'] ?? '',
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'circleMemberName': memberName,
      'circleMemberStreak': streakCount,
      'circleMemberCompletionStatus': completionStatus,
      'memberId':memberId,
      'avatarUrl':avatarUrl,
    };
  }
}
