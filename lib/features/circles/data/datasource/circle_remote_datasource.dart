import 'dart:developer';

import 'package:circle_of_light/core/api/app_api.dart';
import 'package:circle_of_light/core/storage/token_storage_service.dart';
import 'package:circle_of_light/features/circles/data/models/circle_model.dart';
import 'package:dio/dio.dart';

class CircleRemoteDataSource {
  final Dio dio;
  final TokenStorageService tokenStorage;

  CircleRemoteDataSource(this.dio, this.tokenStorage);

  Future<List<CircleModel>> getCircleDetails() async {
    try {
      log('start calling');
      final token = await tokenStorage.getAccessToken();
      final response = await dio.get(
        circleListEndpoint,
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );
      if (response.data == null) {
        log('something error');
        throw Exception("Something went wrong");
      }
      log('Response ${response.data}');
      final list = response.data as List<dynamic>;
      return list
          .map((item) => CircleModel.fromJSON(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Failed to load Circle Details");
    }
  }
}
