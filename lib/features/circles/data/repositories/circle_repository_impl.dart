import 'package:circle_of_light/features/auth/presentation/providers/provider.dart';
import 'package:circle_of_light/features/circles/data/datasource/circle_remote_datasource.dart';
import 'package:circle_of_light/features/circles/data/models/circle_details_model.dart';
import 'package:circle_of_light/features/circles/data/models/circle_list_model.dart';
import 'package:circle_of_light/features/circles/domain/entities/create_task_entity.dart';
import 'package:circle_of_light/features/circles/domain/entities/delete_task_entity.dart';

import 'package:circle_of_light/features/circles/domain/repository/circle_repository.dart';

class CircleRepositoryImpl implements CircleRepository{
  final CircleRemoteDataSource dataSource;

  CircleRepositoryImpl(this.dataSource);
  @override
  Future<List<CircleListModel>> getCircleDetails() async {
    return dataSource.getCircleDetails();
  }

  @override
  Future<CircleDetailsModel> fetchUserCircleDetails({required String circleId}) {
   return dataSource.fetchCircleDetails(circleId: circleId);
  }

  @override
  Future<Map<String, dynamic>> createTask({required CreateTaskEntity task}) {
   return dataSource.createTask(task: task);
  }

  @override
  Future<Map<String, dynamic>> deleteTask({required DeleteTaskEntity deleteTask}) {
   return dataSource.deleteTask(deleteTask: deleteTask);
  }

  @override
  Future<Map<String, dynamic>> updateTask({required CreateTaskEntity task}) {
   return dataSource.updateTask(task: task);
  }
}