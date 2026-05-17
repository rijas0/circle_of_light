import '../datasource/user_circle_check_datasource.dart';
import '../model/user_circle_check_model.dart';
import '../../domain/repository/user_circle_check_repository.dart';

class UserCircleCheckImpl implements UserCircleCheckRepository{
  final UserCircleCheckDatasource datasource;

  UserCircleCheckImpl(this.datasource);
  @override
  Future<UserCircleCheckModel> checkUserCircle() async{
    return await datasource.checkUserHasCircle();
  }
}