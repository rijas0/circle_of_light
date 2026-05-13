import '../../data/model/circle_access_model.dart';
import '../repository/circle_access_repository.dart';

class JoinCircleUseCase {
  final CircleAccessRepository repository;

  JoinCircleUseCase(this.repository);

  Future<CircleAccessModel> call({
    required String inviteCode,
  }) {
    return repository.joinCircle(inviteCode: inviteCode);
  }
}
