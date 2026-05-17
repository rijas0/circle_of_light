import '../../data/models/circle_list_model.dart';
import '../repository/circle_repository.dart';

class CircleUseCase {
  final CircleRepository repository;

  CircleUseCase(this.repository);

  Future<List<CircleListModel>> call() {
    return repository.getCircleDetails();
  }
}