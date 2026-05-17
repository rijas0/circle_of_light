import '../../data/model/user_circle_check_model.dart';

abstract class UserCircleCheckRepository {
  Future<UserCircleCheckModel> checkUserCircle();
}