import "package:circle_of_light/features/circles/data/models/circle_list_model.dart";


class HomeEntity {
  final String userName;
  final String dailyQuote;
  final String circleName;
  final String circleMembers;
  final String dailyStreak;
  final String completedTask;
  final String totalTask;
  final String completedMembersCount;
  final String versesReadTW;
  final String reflectionTW;
  final String totalCheckInTw;
  final String consistencyTW;
  final List<CircleListModel> circleList;

  HomeEntity({
    required this.userName,
    required this.dailyQuote,
    required this.circleName,
    required this.circleMembers,
    required this.dailyStreak,
    required this.completedTask,
    required this.totalTask,
    required this.completedMembersCount,
    required this.versesReadTW,
    required this.reflectionTW,
    required this.totalCheckInTw,
    required this.consistencyTW,
    required this.circleList,
  });
}
