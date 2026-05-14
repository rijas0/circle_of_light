import 'package:circle_of_light/core/api/app_api.dart';
import 'package:circle_of_light/core/storage/token_storage_service.dart';
import 'package:circle_of_light/features/dashboard/data/model/home_model.dart';
import 'package:dio/dio.dart';

class HomeRemoteDatasource {
  final Dio dio;
final TokenStorageService tokenStorage;
  HomeRemoteDatasource(this.dio,this.tokenStorage);


  Future<HomeModel> getHomeDetails()async{
    try{
      final token = await tokenStorage.getAccessToken();
      final response = await dio.get(homeDetailsEndpoint,options: Options(headers:{"Authorization": "Bearer $token"}));
      if(response.data == null){
        throw Exception("Something went wrong");
      }
      return HomeModel.fromJSON(response.data);
    }catch(e){
      throw Exception("Failed to load Home Details");
    }
  }
}