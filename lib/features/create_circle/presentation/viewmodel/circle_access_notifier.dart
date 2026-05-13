import '../../domain/usecases/create_circle_usecase.dart';
import 'circle_access_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class CircleAccessNotifier extends StateNotifier<CircleAccessState> {
  final CreateCircleUseCase createCircleUseCase;

  CircleAccessNotifier(this.createCircleUseCase) : super(CircleAccessState());

  Future<void> createCircle({
    required String accessToken,
    required String name,
    required String description,
    required String focus,
    required String privacy,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final circle = await createCircleUseCase(
        accessToken: accessToken,
        name: name,
        description: description,
        focus: focus,
        privacy: privacy,
      );
      state = state.copyWith(isLoading: false, circle: circle);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
