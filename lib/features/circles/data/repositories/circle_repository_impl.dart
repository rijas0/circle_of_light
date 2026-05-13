import 'package:circle_of_light/features/circles/data/datasource/circle_remote_datasource.dart';
import 'package:circle_of_light/features/circles/data/models/circle_model.dart';
import 'package:circle_of_light/features/circles/domain/repository/circle_repository.dart';

class CircleRepositoryImpl implements CircleRepository{
  final CircleRemoteDataSource dataSource;

  CircleRepositoryImpl(this.dataSource);
  @override
  Future<CircleModel> getCircleDetails({required String accessToken}) async{
    return dataSource.getCircleDetails(accessToken: accessToken);
  }
}