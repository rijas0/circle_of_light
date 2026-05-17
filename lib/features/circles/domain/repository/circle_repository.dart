import 'package:circle_of_light/features/circles/data/models/circle_details_model.dart';
import 'package:circle_of_light/features/circles/data/models/circle_list_model.dart';
import 'package:circle_of_light/features/circles/domain/entities/create_task_entity.dart';
import 'package:circle_of_light/features/circles/domain/entities/delete_task_entity.dart';

abstract class CircleRepository {
  Future<List<CircleListModel>> getCircleDetails();
  Future<CircleDetailsModel> fetchUserCircleDetails({required String circleId});
  Future<Map<String,dynamic>> createTask({required CreateTaskEntity task});
  Future<Map<String,dynamic>> updateTask({required CreateTaskEntity task});
  Future<Map<String,dynamic>> deleteTask({required DeleteTaskEntity deleteTask});
}