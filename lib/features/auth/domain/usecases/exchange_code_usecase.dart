import '../entities/user_entitie.dart';
import '../repositories/auth_repository.dart';

class ExchangeCodeUseCase {
  final AuthRepository repository;

  ExchangeCodeUseCase(this.repository);

  Future<UserEntity> call(String code) {
    return repository.exchangeCode(code);
  }
}