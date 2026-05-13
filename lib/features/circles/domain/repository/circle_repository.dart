import 'package:circle_of_light/features/circles/data/models/circle_model.dart';

abstract class CircleRepository {
  Future<CircleModel>getCircleDetails({required String accessToken});
}