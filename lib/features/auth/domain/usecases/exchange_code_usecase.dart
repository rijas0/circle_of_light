import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

class ExchangeCodeUseCase {
  final AuthRepository repository;

  ExchangeCodeUseCase(this.repository);

  Future<AuthResult> call(String code) {
    return repository.exchangeCode(code);
  }
}
