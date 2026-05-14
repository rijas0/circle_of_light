import 'dart:developer';

import '../../domain/usecases/circle_usecase.dart';
import 'circle_state.dart';
import 'package:riverpod/legacy.dart';

class CircleNotifier extends StateNotifier<CircleState> {
  final CircleUseCase circleUseCase;

  CircleNotifier(this.circleUseCase) : super(CircleState());

  Future<void> getCircleDetails() async {
    state = state.copyWith(isLoading: true);
    try {
      final circles = await circleUseCase.call();
      log('CircleNotifier: loaded ${circles.length} circles');
      state = state.copyWith(isLoading: false, circles: circles);
    } catch (e) {
      log('CircleNotifier error: $e');
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}