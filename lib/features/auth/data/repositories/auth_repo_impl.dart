import '../datasources/auth_remote_datasource.dart';
import '../../domain/entities/user_entitie.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepoImpl implements AuthRepository{
  final AuthRemoteDataSource remote;
  AuthRepoImpl(this.remote);

  @override
  Future<UserEntity> exchangeCode(String code) {
   return remote.exchangeCode(code);
  }
  
  @override
  Future<UserEntity> loginWithQuran() async{
     final model = await remote.loginWithQuran();
    return model.toEntity();
  }

}