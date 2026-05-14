import '../../data/models/circle_member_model.dart';
import '../../data/models/circle_progress_model.dart';
import '../../data/models/circle_task_model.dart';

class CircleEntity {
  const CircleEntity({
    required this.circleId,
    required this.circleName,
    required this.memberCount,
    required this.isPublic,
    required this.inviteId,
    required this.creatorId, 
    required this.focus,
    required this.circleProgress,
    required this.membersList,
    required this.taskList,
    required this.completedMembers,
    this.avatarUrl,
    this.circleDescription, 


  });
  final String circleId;
  final String circleName;
  final String? circleDescription;
  final String? avatarUrl;
  final int memberCount;
  final int creatorId;
  final int inviteId;
  final String focus;
  final bool isPublic;
  final String completedMembers;
  final List<CircleMemberModel>membersList;
  final List<CircleTaskModel> taskList;
  final CircleProgressModel circleProgress;
}
