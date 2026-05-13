import 'package:circle_of_light/features/dashboard/data/datasource/home_remote_datasource.dart';
import 'package:circle_of_light/features/dashboard/data/model/home_model.dart';
import 'package:circle_of_light/features/dashboard/domain/repository/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository{
  final HomeRemoteDatasource datasource;

  HomeRepositoryImpl(this.datasource);
  
  @override
  Future<HomeModel> getHomeDetails({required String accessToken}) {
    return datasource.getHomeDetails(accessToken: accessToken);
  }
}