import 'package:circle_of_light/features/circles/data/models/circle_member_model.dart';
import 'package:circle_of_light/features/circles/data/models/circle_progress_model.dart';
import 'package:circle_of_light/features/circles/data/models/circle_task_model.dart';
import 'package:circle_of_light/features/circles/domain/entities/circle_details_entity.dart';
import 'package:circle_of_light/features/circles/domain/entities/circle_list_entity.dart';

import '../../domain/entities/circle_entity.dart';

class CircleListModel extends CircleListEntity {
  const CircleListModel({
    required super.circleId,
    required super.circleName,
    required super.memberCount,
    required super.isPublic,
    required super.creatorId,
    required super.focus,
    required super.membersList,
    super.circleDescription,
    super.avatarUrl,
    super.inviteCode,
  });

  factory CircleListModel.fromJSON(Map<String, dynamic> json) {
    return CircleListModel(
      circleId: json['circle_id'] ?? '',
      circleName: json['name'] ?? '',
      memberCount: json['member_count'] ?? 0,
      isPublic: json['is_public'] ?? false,
      creatorId: json['creator_id']?.toString() ?? '',
      inviteCode: json['invite_code']?.toString(),
      focus: json['focus'] ?? '',
      circleDescription: json['description'],
      avatarUrl: json['avatar_url'],
      membersList:
      (json['members'] as List<dynamic>?)
          ?.map((m) => CircleMemberModel.fromJSON(m as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}
