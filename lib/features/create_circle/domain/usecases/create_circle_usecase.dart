import '../../data/model/circle_access_model.dart';
import '../repository/circle_access_repository.dart';

class CreateCircleUseCase {
  final CircleAccessRepository repository;

  CreateCircleUseCase(this.repository);

  Future<CircleAccessModel> call({
    required String accessToken,
    required String name,
    required String description,
    required String focus,
    required String privacy,
  }) {
    return repository.createCircle(
      accessToken: accessToken,
      name: name,
      description: description,
      focus: focus,
      privacy: privacy,
    );
  }
}