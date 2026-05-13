import 'package:circle_of_light/core/api/app_api.dart';
import 'package:circle_of_light/features/dashboard/data/model/home_model.dart';
import 'package:dio/dio.dart';

class HomeRemoteDatasource {
  final Dio dio;
  HomeRemoteDatasource(this.dio);

  Future<HomeModel> getHomeDetails({
    required String accessToken
  })async{
    try{
      final response = await dio.get(homeDetailsEndpoint,options: Options(headers:{"Authorization": "Bearer $accessToken"}));
      if(response.data == null){
        throw Exception("Something went wrong");
      }
      return HomeModel.fromJSON(response.data);
    }catch(e){
      throw Exception("Failed to load Home Details");
    }
  }
}