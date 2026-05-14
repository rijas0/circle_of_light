import 'package:circle_of_light/features/circles/data/models/circle_model.dart';
import 'package:circle_of_light/features/circles/domain/repository/circle_repository.dart';

class CircleUseCase {
  final CircleRepository repository;

  CircleUseCase(this.repository);

  Future<List<CircleModel>> call() {
    return repository.getCircleDetails();
  }
}