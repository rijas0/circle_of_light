import 'package:circle_of_light/features/circles/data/models/circle_member_model.dart';
import 'package:circle_of_light/features/circles/data/models/circle_progress_model.dart';
import 'package:circle_of_light/features/circles/data/models/circle_task_model.dart';
import 'package:circle_of_light/features/circles/domain/entities/circle_details_entity.dart';

import '../../domain/entities/circle_entity.dart';

class CircleDetailsModel extends CircleDetailsEntity {
  const CircleDetailsModel({
    required super.userId,
    required super.circleId,
    required super.circleName,
    required super.memberCount,
    required super.isPublic,
    required super.focus,
    required super.circleMetrics,
    required super.creatorId,
    required super.membersList,
    required super.taskList,
    required super.completedMembers,
    super.circleDescription,
    super.avatarUrl,
    super.inviteCode,
  });

  factory CircleDetailsModel.fromJSON(Map<String, dynamic> json) {
    final info = json['circle_info'] as Map<String, dynamic>? ?? {};
    final metrics = json['metrics'] as Map<String, dynamic>?;

    return CircleDetailsModel(
      userId: info['requested_by_user_id'] ?? '',
      circleId: info['id'] ?? '',
      circleName: info['name'] ?? '',
      memberCount: metrics?['total_members_count'] ?? 0,
      isPublic: info['is_public'] ?? false,
      inviteCode: info['invite_code']?.toString(),
      focus: info['focus'] ?? '',
      creatorId: info['creator_id'],
      circleDescription: info['description'],
      avatarUrl: info['avatar_url'],
      completedMembers: metrics?['completed_members_count']?.toString() ?? '0',
      membersList:
          (json['members'] as List<dynamic>?)
              ?.map((m) => CircleMemberModel.fromJSON(m as Map<String, dynamic>))
              .toList() ??
          [],
      circleMetrics: metrics != null
          ? CircleProgressModel.fromJSON(metrics)
          : CircleProgressModel(
              completedMembersCount: 0,
              completedTaskCount: 0,
              overallPercentage: 0,
              totalTaskCount: 0,
              totalMembersCount: 0,
            ),
      taskList: (json['today_tasks'] as List<dynamic>?)
              ?.map((t) => CircleTaskModel.fromJSON(t as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
