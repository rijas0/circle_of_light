import 'package:circle_of_light/features/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<UserModel> exchangeCode(String code) async {
    final res = await dio.post("SUPABASE_FUNCTION", data: {"code": code});

    return UserModel.fromJson(res.data);
  }
}
