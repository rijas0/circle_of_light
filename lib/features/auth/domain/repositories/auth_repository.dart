import '../entities/auth_result.dart';

abstract class AuthRepository {
  Future<AuthResult> exchangeCode(String code);
  Future<AuthResult> loginWithQuran();
}
