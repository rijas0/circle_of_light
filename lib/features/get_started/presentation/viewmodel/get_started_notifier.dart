import 'package:circle_of_light/features/get_started/domain/usercase/user_circle_check_use_case.dart';
import 'package:circle_of_light/features/get_started/presentation/viewmodel/get_started_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class GetStartedNotifier extends StateNotifier<GetStartedState>{
  final UserCircleCheckUseCase useCase;

  GetStartedNotifier(this.useCase):super(GetStartedState());
  
  Future<void> checkUserHasCircle()async {
    state = state.copyWith(isLoading: true);
    try {
      final response = await  useCase.call();
      state = state.copyWith(isLoading: false, userCircleStatus: response);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}