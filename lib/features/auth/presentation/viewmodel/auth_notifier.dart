import 'dart:developer';

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
    state = AuthState(isLoading: true, isInitializing: false);
    try {
      final result = await exchangeCode(code);
      state = AuthState(user: result.user, isInitializing: false);
    } catch (e) {
      state = AuthState(isInitializing: false);
    }
  }

  Future<void> loginWithQuran() async {
    state = state.copyWith(isLoading: true, error: null, isInitializing: false);

    try {
      final AuthResult result = await login();
      final hasJoinedRoom = await checkRoom(result.user.id);

      log('loginWithQuran: accessToken length: ${result.accessToken.length}, userId: ${result.user.id}');
      log('loginWithQuran: token starts with: ${result.accessToken.substring(0, result.accessToken.length > 20 ? 20 : result.accessToken.length)}');
      await tokenStorage.saveTokens(
        accessToken: result.accessToken,
        userId: result.user.id,
        email: result.user.email,
        name: result.user.name,
        role: result.user.role,
        avatarUrl: result.user.avatarUrl,
        createdAt: result.user.createdAt,
      );
      final stored = await tokenStorage.getAccessToken();
      log('loginWithQuran: stored token length: ${stored?.length ?? 0}');

      state = state.copyWith(
        isLoading: false,
        user: result.user,
        hasJoinedRoom: hasJoinedRoom,
        isInitializing: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
        isInitializing: false,
      );
    }
  }

  Future<void> restoreSession() async {
    try {
      final isLoggedIn = await tokenStorage.isLoggedIn();
      if (!isLoggedIn) {
        state = state.copyWith(isInitializing: false);
        return;
      }

      final userData = await tokenStorage.getUserData();

      if (userData['id'] == null) {
        state = state.copyWith(isInitializing: false);
        return;
      }

      state = state.copyWith(
        isInitializing: false,
        user: UserEntity(
          id: userData['id']!,
          email: userData['email'] ?? '',
          name: userData['name'] ?? '',
          role: userData['role'] ?? '',
          avatarUrl: userData['avatarUrl'] ?? '',
          createdAt: userData['createdAt'] ?? '',
        ),
      );
    } catch (_) {
      state = state.copyWith(isInitializing: false);
    }
  }

  Future<void> logout() async {
    await tokenStorage.clearTokens();
    state = AuthState(isInitializing: false);
  }

  void setHasJoinedRoom() {
    state = state.copyWith(hasJoinedRoom: true);
  }
}
