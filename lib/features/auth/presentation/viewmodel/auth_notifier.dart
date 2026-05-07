import 'package:circle_of_light/core/storage/token_storage_service.dart';
import 'package:circle_of_light/features/auth/domain/entities/auth_result.dart';
import 'package:circle_of_light/features/auth/domain/entities/user_entitie.dart';
import 'package:circle_of_light/features/auth/domain/usecases/check_user_room_usecase.dart';
import 'package:circle_of_light/features/auth/domain/usecases/login_with_quran_usercase.dart';

import '../../domain/usecases/exchange_code_usecase.dart';
import 'auth_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final ExchangeCodeUseCase exchangeCode;
  final LoginWithQuranUseCase login;
  final CheckUserRoomUseCase checkRoom;
  final TokenStorageService tokenStorage;

  AuthNotifier(this.exchangeCode, this.login, this.checkRoom, this.tokenStorage)
      : super(AuthState());

  Future<void> handleAuthCode(String code) async {
    state = AuthState(isLoading: true);
    try {
      final result = await exchangeCode(code);
      state = AuthState(user: result.user);
    } catch (e) {
      state = AuthState();
    }
  }

  Future<void> loginWithQuran() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final AuthResult result = await login();
      final hasJoinedRoom = await checkRoom(result.user.id);

      await tokenStorage.saveTokens(
        accessToken: result.accessToken,
        userId: result.user.id,
        email: result.user.email,
        name: result.user.name,
        role: result.user.role,
        avatarUrl: result.user.avatarUrl,
        createdAt: result.user.createdAt,
      );

      state = state.copyWith(
        isLoading: false,
        user: result.user,
        hasJoinedRoom: hasJoinedRoom,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<void> restoreSession() async {
    final isLoggedIn = await tokenStorage.isLoggedIn();
    if (!isLoggedIn) return;

    final userData = await tokenStorage.getUserData();

    if (userData['id'] == null) return;

    state = state.copyWith(
      user: UserEntity(
        id: userData['id']!,
        email: userData['email'] ?? '',
        name: userData['name'] ?? '',
        role: userData['role'] ?? '',
        avatarUrl: userData['avatarUrl'] ?? '',
        createdAt: userData['createdAt'] ?? '',
      ),
    );
  }

  Future<void> logout() async {
    await tokenStorage.clearTokens();
    state = AuthState();
  }

  void setHasJoinedRoom() {
    state = state.copyWith(hasJoinedRoom: true);
  }
}
