import 'package:circle_of_light/core/api/app_api.dart';
import 'package:circle_of_light/features/circles/data/models/circle_model.dart';
import 'package:dio/dio.dart';

class CircleRemoteDataSource {
  final Dio dio;

  CircleRemoteDataSource(this.dio);

  Future<CircleModel> createCircle({
    required String accessToken,
    required String name,
    required String description,
    required String focus,
    required String privacy,
  }) async {
    final response = await dio.post(
      circleCreationEndpoint,
      data: {
        "name": name,
        "description": description,
        "focus": focus,
        "privacy": privacy,
      },
      options: Options(
        headers: {
          "Authorization": "Bearer $accessToken",
        },
      ),
    );

    return CircleModel.fromJson(response.data['circle']);
  }
}