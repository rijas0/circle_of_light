import 'package:circle_of_light/features/get_started/data/model/user_circle_check_model.dart';
import 'package:circle_of_light/features/get_started/domain/repository/user_circle_check_repository.dart';

class UserCircleCheckUseCase {
  final UserCircleCheckRepository repository;
  UserCircleCheckUseCase(this.repository);

  Future<UserCircleCheckModel>call(){
    return repository.checkUserCircle();
  }
}