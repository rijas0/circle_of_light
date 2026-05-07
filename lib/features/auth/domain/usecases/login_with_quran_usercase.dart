import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

class LoginWithQuranUseCase {
  final AuthRepository repository;

  LoginWithQuranUseCase(this.repository);

  Future<AuthResult> call() {
    return repository.loginWithQuran();
  }
}
