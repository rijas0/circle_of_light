import 'dart:developer';

import 'package:circle_of_light/core/api/app_api.dart';
import 'package:circle_of_light/features/circles/domain/entities/create_task_entity.dart';
import 'package:circle_of_light/features/circles/domain/entities/delete_task_entity.dart';
import '../../../../core/storage/token_storage_service.dart';
import '../models/circle_details_model.dart';
import 'package:dio/dio.dart';

import '../models/circle_list_model.dart';

class CircleRemoteDataSource {
  final Dio dio;
  final TokenStorageService tokenStorage;

  CircleRemoteDataSource(this.dio, this.tokenStorage);

  Future<List<CircleListModel>> getCircleDetails() async {
    try {
      final token = await tokenStorage.getAccessToken();
      final response = await dio.get(
        circleListEndpoint,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.data == null) {
        throw Exception("Something went wrong");
      }
      final list = response.data as List<dynamic>;
      return list
          .map((item) => CircleListModel.fromJSON(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Failed to load Circle Details");
    }
  }

  Future<CircleDetailsModel> fetchCircleDetails({required String circleId}) async {
    try {
      final token = await tokenStorage.getAccessToken();
      final response = await dio.post(
        circleDetailsEndpoint,
        data: {
          'circle_id':circleId
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.data == null) {
        throw Exception("Something went wrong");
      }
      return CircleDetailsModel.fromJSON(response.data);
    } catch (e) {
      throw Exception("Failed to load Circle Details ${e.toString()}");
    }
  }

  Future<Map<String,dynamic>> createTask({required CreateTaskEntity task })async{
    try{
      final token = await tokenStorage.getAccessToken();
      final response = await dio.post(
        circleTaskCRUDEndpoint,
        data: {
          'action': 'CREATE',
          'circle_id': task.circleId,
          'name': task.taskName,
          'description': task.taskDescription,
          'type': task.taskType,
          'due_date': task.taskDueDate
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.data == null) {
        throw Exception("Something went wrong");
      }
      return {'success':true,'message':'Task created'};
    }catch(e){
      throw Exception("Failed to load Circle Details ${e.toString()}");
    }
  }

  Future<Map<String,dynamic>> updateTask({required CreateTaskEntity task })async{
    try{
      final token = await tokenStorage.getAccessToken();
      final response = await dio.post(
        circleTaskCRUDEndpoint,
        data: {
          'action': 'UPDATE',
          'circle_id': task.circleId,
          'name': task.taskName,
          'description': task.taskDescription,
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.data == null) {
        throw Exception("Something went wrong");
      }
      return {'success':true,'message':'Task Updated'};
    }catch(e){
      throw Exception("Failed to load Circle Details ${e.toString()}");
    }
  }
  Future<Map<String,dynamic>> deleteTask({required DeleteTaskEntity deleteTask })async{
    try{
      final token = await tokenStorage.getAccessToken();
      final response = await dio.post(
        circleTaskCRUDEndpoint,
        data: {
          'action': 'UPDATE',
          'circle_id': deleteTask.circleId,
          'task_id': deleteTask.taskId
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.data == null) {
        throw Exception("Something went wrong");
      }
      return {'success':true,'message':'Task Deleted'};
    }catch(e){
      throw Exception("Failed to load Circle Details ${e.toString()}");
    }
  }
}
