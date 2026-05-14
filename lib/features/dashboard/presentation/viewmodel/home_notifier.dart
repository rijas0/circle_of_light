import '../../domain/usecases/home_usecase.dart';
import 'home_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeUseCase homeUseCase;
  HomeNotifier(this.homeUseCase) : super(HomeState());

  Future<void> getHomeDetails() async {
    state = state.copyWith(isLoading: true);
    try {
      final homeDetails = await homeUseCase();
      state = state.copyWith(isLoading: false, home: homeDetails);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
