import 'package:circle_of_light/core/api/app_api.dart';
import 'package:circle_of_light/features/create_circle/data/model/circle_access_model.dart';
import 'package:dio/dio.dart';

class CircleAccessDatasource {
  final Dio dio;

  CircleAccessDatasource(this.dio);
  Future<CircleAccessModel> createCircle({
    required String accessToken,
    required String name,
    required String description,
    required String focus,
    required String privacy,
  }) async {
    try {
      final response = await dio.post(
        circleCreationEndpoint,
        data: {
          "name": name,
          "description": description,
          "focus": focus,
          "privacy": privacy,
        },
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );

      if (response.data == null) {
        throw Exception("User cancelled login");
      }
       return CircleAccessModel.fromJson(response.data['circle']);
    } catch (e) {
      throw Exception("Login failed: $e");
    }
   
  }
}
