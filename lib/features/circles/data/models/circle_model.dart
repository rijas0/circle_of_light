import 'package:circle_of_light/features/circles/data/models/circle_member_model.dart';
import 'package:circle_of_light/features/circles/data/models/circle_progress_model.dart';
import 'package:circle_of_light/features/circles/data/models/circle_task_model.dart';

import '../../domain/entities/circle_entity.dart';

class CircleModel extends CircleEntity {
  const CircleModel({
    required super.circleId,
    required super.circleName,
    required super.memberCount,
    required super.isPublic,
    required super.creatorId,
    required super.focus,
    required super.circleProgress,
    required super.membersList,
    required super.taskList,
    required super.completedMembers,
    super.circleDescription,
    super.avatarUrl,
    super.inviteCode,
  });

  factory CircleModel.fromJSON(Map<String, dynamic> json) {
    return CircleModel(
      circleId: json['circle_id'] ?? json['id'] ?? '',
      circleName: json['name'] ?? json['circleName'] ?? '',
      memberCount: json['member_count'] ?? 0,
      isPublic: json['is_public'] ?? false,
      creatorId: json['creator_id']?.toString() ?? '',
      inviteCode: json['invite_code']?.toString(),
      focus: json['focus'] ?? '',
      circleDescription: json['description'],
      avatarUrl: json['avatar_url'],
      completedMembers: json['completed_members']?.toString() ?? '0',
      membersList:
          (json['circleMemberList'] as List<dynamic>?)
              ?.map((members) => CircleMemberModel.fromJSON(members))
              .toList() ??
          [],
      circleProgress: json['circleProgress'] != null
          ? CircleProgressModel.fromJSON(json['circleProgress'] as Map<String, dynamic>)
          : CircleProgressModel(
              completedMembersCount: '',
              completedTaskCount: '',
              overallPercentage: '',
              totalTaskCount: '',
            ),
      taskList: (json['circleTaskList'] as List<dynamic>?)
              ?.map((task) => CircleTaskModel.fromJSON(task as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
