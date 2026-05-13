import '../../data/model/circle_access_model.dart';

abstract class CircleAccessRepository {
  Future<CircleAccessModel> createCircle({
    required String name,
    required String description,
    required String focus,
    required String privacy,
  });

  Future<CircleAccessModel> joinCircle({
    required String inviteCode,
  });
}