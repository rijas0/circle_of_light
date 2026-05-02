import 'package:circle_of_light/features/auth/domain/usecases/check_user_room_usecase.dart';
import 'package:circle_of_light/features/auth/domain/usecases/login_with_quran_usercase.dart';

import '../../domain/usecases/exchange_code_usecase.dart';
import 'auth_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final ExchangeCodeUseCase exchangeCode;
  final LoginWithQuranUseCase login;
  final CheckUserRoomUseCase checkRoom;

  AuthNotifier(this.exchangeCode,this.login,this.checkRoom) : super(AuthState());

  Future<void> handleAuthCode(String code) async {
    state = AuthState(isLoading: true);
    try {
      final user = await exchangeCode(code);
      state = AuthState(user: user);
    } catch (e) {
      state = AuthState();
    }
  }
  Future<void> loginWithQuran() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final user = await login();
      final hasJoinedRoom = await checkRoom(user.id);
      state = state.copyWith(isLoading: false, user: user,hasJoinedRoom: hasJoinedRoom);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void setHasJoinedRoom() {
    state = state.copyWith(hasJoinedRoom: true);
  }
  
}
