import '../entities/user_entitie.dart';
import '../repositories/auth_repository.dart';

class LoginWithQuranUseCase {
  final AuthRepository repository;

  LoginWithQuranUseCase(this.repository);

  Future<UserEntity> call() {
    return repository.loginWithQuran();
  }
}