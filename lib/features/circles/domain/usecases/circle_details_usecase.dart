import 'package:circle_of_light/features/circles/data/models/circle_details_model.dart';
import 'package:circle_of_light/features/circles/domain/repository/circle_repository.dart';

class CircleDetailsUseCase {
  final CircleRepository repository;

  CircleDetailsUseCase(this.repository);

  Future<CircleDetailsModel> call({required String circleId}) {
    return repository.fetchUserCircleDetails(circleId: circleId);
  }
}