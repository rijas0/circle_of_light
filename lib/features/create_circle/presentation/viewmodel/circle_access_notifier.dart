import '../../domain/usecases/create_circle_usecase.dart';
import '../../domain/usecases/join_circle_usecase.dart';
import 'circle_access_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class CircleAccessNotifier extends StateNotifier<CircleAccessState> {
  final CreateCircleUseCase createCircleUseCase;
  final JoinCircleUseCase joinCircleUseCase;

  CircleAccessNotifier(this.createCircleUseCase, this.joinCircleUseCase)
      : super(CircleAccessState());

  Future<CircleAccessState> createCircle({
    required String name,
    required String description,
    required String focus,
    required String privacy,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final circle = await createCircleUseCase(
        name: name,
        description: description,
        focus: focus,
        privacy: privacy,
      );
      state = state.copyWith(isLoading: false, circle: circle);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
    return state;
  }

  Future<CircleAccessState> joinCircle({
    required String inviteCode,
  }) async {
    state = state.copyWith(isLoading: true);
    try {
      final circle = await joinCircleUseCase(inviteCode: inviteCode);
      state = state.copyWith(isLoading: false, circle: circle);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
    return state;
  }
}
