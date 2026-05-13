import 'package:circle_of_light/features/dashboard/data/model/home_model.dart';
import 'package:circle_of_light/features/dashboard/domain/repository/home_repository.dart';

class HomeUseCase {
  final HomeRepository repository;

  HomeUseCase(this.repository);

  Future<HomeModel> call({required String accessToken}){
    return repository.getHomeDetails(accessToken: accessToken);
  }
}