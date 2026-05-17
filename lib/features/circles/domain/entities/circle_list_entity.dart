import '../../data/models/circle_member_model.dart';
import '../../data/models/circle_progress_model.dart';
import '../../data/models/circle_task_model.dart';

class CircleListEntity {
  const CircleListEntity({
    required this.circleId,
    required this.circleName,
    required this.memberCount,
    required this.isPublic,
    required this.creatorId,
    required this.focus,
    required this.membersList,
    this.avatarUrl,
    this.circleDescription,
    this.inviteCode,
  });

  final String circleId;
  final String circleName;
  final String? circleDescription;
  final String? avatarUrl;
  final int memberCount;
  final String creatorId;
  final String? inviteCode;
  final String focus;
  final bool isPublic;
  final List<CircleMemberModel> membersList;
}
