import 'dart:developer';

import 'package:circle_of_light/core/api/app_api.dart';
import 'package:circle_of_light/core/storage/token_storage_service.dart';
import 'package:circle_of_light/features/create_circle/data/model/circle_access_model.dart';
import 'package:dio/dio.dart';

class CircleAccessDatasource {
  final Dio dio;
  final TokenStorageService tokenStorage;

  CircleAccessDatasource(this.dio, this.tokenStorage);
  Future<CircleAccessModel> createCircle({
    required String name,
    required String description,
    required String focus,
    required String privacy,
  }) async {
    try {
      final token = await tokenStorage.getAccessToken();
      final response = await dio.post(
        circleCreationEndpoint,
        data: {
          "name": name,
          "description": description,
          "focus": focus,
          "privacy": privacy,
        },
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.data == null) {
        throw Exception("User cancelled login");
      }
      
       return CircleAccessModel.fromJson(response.data['circle']);
    } catch (e) {
      throw Exception("Failed to create circle: $e");
    }
   
  }

  Future<CircleAccessModel> joinCircle({
    required String inviteCode,
  }) async {
    try {
      final token = await tokenStorage.getAccessToken();
      final response = await dio.post(
        joinCircleEndpoint,
        data: {"invite_code": inviteCode},
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      if (response.data == null) {
        throw Exception("No response from server");
      }
      log('join response ${response.data}');
      return CircleAccessModel.fromJson(response.data['circle']);
    } catch (e) {
      throw Exception("Failed to join circle: $e");
    }
  }
}
