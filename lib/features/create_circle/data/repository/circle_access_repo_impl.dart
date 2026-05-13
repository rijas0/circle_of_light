import 'package:circle_of_light/features/create_circle/data/datasource/circle_access_datasource.dart';
import 'package:circle_of_light/features/create_circle/data/model/circle_access_model.dart';
import 'package:circle_of_light/features/create_circle/domain/repository/circle_access_repository.dart';

class CircleAccessRepoImpl implements CircleAccessRepository {
  final CircleAccessDatasource dataSource;
  CircleAccessRepoImpl(this.dataSource);

  @override
  Future<CircleAccessModel> createCircle({
    required String name,
    required String description,
    required String focus,
    required String privacy,
  }) {
    return dataSource.createCircle(
      name: name,
      description: description,
      focus: focus,
      privacy: privacy,
    );
  }

  @override
  Future<CircleAccessModel> joinCircle({
    required String inviteCode,
  }) {
    return dataSource.joinCircle(inviteCode: inviteCode);
  }
}
