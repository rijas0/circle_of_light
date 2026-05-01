import '../entities/user_entitie.dart';

abstract class AuthRepository {
  Future<UserEntity> exchangeCode(String code);
}