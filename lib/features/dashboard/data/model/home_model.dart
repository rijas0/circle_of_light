import 'package:circle_of_light/features/circles/data/models/circle_model.dart';
import 'package:circle_of_light/features/dashboard/domain/entity/home_entity.dart';

class HomeModel extends HomeEntity {
  HomeModel({
    required super.userName,
    required super.dailyQuote,
    required super.circleName,
    required super.circleMembers,
    required super.dailyStreak,
    required super.completedTask,
    required super.totalTask,
    required super.completedMembersCount,
    required super.versesReadTW,
    required super.reflectionTW,
    required super.totalCheckInTw,
    required super.consistencyTW,
    required super.circleList
  });

  factory HomeModel.fromJSON(Map<String, dynamic> json) {
    return HomeModel(
      userName: json['userName'],
      dailyQuote: json['dailyQuote'],
      circleName: json['circleName'],
      circleMembers: json['circleMembers'],
      dailyStreak: json['dailyStreak'],
      completedTask: json['completedTask'],
      totalTask: json['totalTask'],
      completedMembersCount: json['completedMembersCount'],
      versesReadTW: json['versesReadTW'],
      reflectionTW: json['reflectionTW'],
      totalCheckInTw: json['totalCheckInTw'],
      consistencyTW: json['consistencyTW'],
      circleList:
          (json['circleList'] as List<dynamic>?)
              ?.map(
                (task) =>
                    CircleModel.fromJSON(task as Map<String, dynamic>),
              )
              .toList() ??
          [], // this should be return list of daily task in a circle
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'userName': userName,
      'dailyQuote': dailyQuote,
      'circleName': circleName,
      'circleMembers': circleMembers,
      'dailyStreak': dailyStreak,
      'completedTask': completedTask,
      'totalTask': totalTask,
      'completedMembersCount': completedMembersCount,
      'versesReadTW': versesReadTW,
      'reflectionTW': reflectionTW,
      'totalCheckInTw': totalCheckInTw,
      'consistencyTW': consistencyTW,
      // 'circleTasks': taskList.map((task)=>task.toJSON()).toList(),
    };
  }
}
