import 'package:circle_of_light/features/dashboard/data/model/home_model.dart';

abstract class HomeRepository {
  Future<HomeModel> getHomeDetails();
}