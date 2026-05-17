
import 'dart:developer';

import 'package:circle_of_light/features/circles/presentation/viewmodel/circle_details_state.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../domain/usecases/circle_details_usecase.dart';

class CircleDetailsNotifier extends StateNotifier<CircleDetailsState> {
  final CircleDetailsUseCase circleDetailsUseCase;

  CircleDetailsNotifier(this.circleDetailsUseCase) : super(CircleDetailsState());

  Future<void> fetchCircleDetails({required String circleId}) async {
    state = state.copyWith(isLoading: true);
    try {

      final circles = await circleDetailsUseCase.call(circleId: circleId);
      state = state.copyWith(isLoading: false, circleDetails: circles);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }




}