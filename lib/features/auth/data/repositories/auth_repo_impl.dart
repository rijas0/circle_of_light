import '../datasources/auth_remote_datasource.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/entities/user_entitie.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  AuthRepoImpl(this.remote);

  @override
  Future<AuthResult> exchangeCode(String code) async {
    final model = await remote.exchangeCode(code);
    return AuthResult(user: model.toEntity(), accessToken: model.accessToken);
  }

  @override
  Future<AuthResult> loginWithQuran() async {
    final model = await remote.loginWithQuran();
    return AuthResult(user: model.toEntity(), accessToken: model.accessToken);
  }

  @override
  Future<AuthResult> logout() async {
    await remote.logout();
    return AuthResult(
      user: UserEntity(id: '', email: '', name: '', avatarUrl: '', role: '', createdAt: ''),
      accessToken: '',
    );
  }
}
