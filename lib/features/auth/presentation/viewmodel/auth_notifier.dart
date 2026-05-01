import '../../domain/usecases/exchange_code_usecase.dart';
import 'auth_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final ExchangeCodeUseCase exchangeCode;

  AuthNotifier(this.exchangeCode) : super(AuthState());

  Future<void> handleAuthCode(String code) async {
    state = AuthState(isLoading: true);
    try {
      final user = await exchangeCode(code);
      state = AuthState(user: user);
    } catch (e) {
      state = AuthState();
    }
  }
}