import 'package:circle_of_light/core/api/app_api.dart';
import 'package:circle_of_light/features/circles/data/models/circle_model.dart';
import 'package:dio/dio.dart';

class CircleRemoteDataSource {
  final Dio dio;

  CircleRemoteDataSource(this.dio);

  Future<CircleModel> getCircleDetails({
    required String accessToken
  })async{
    try{
      final response = await dio.get(circleDetailsEndpoint,options: Options(headers:{"Authorization": "Bearer $accessToken"}));
      if(response.data == null){
        throw Exception("Something went wrong");
      }
      return CircleModel.fromJSON(response.data);
    }catch(e){
      throw Exception("Failed to load Circle Details");
    }
  }
  
}