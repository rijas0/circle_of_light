import 'dart:developer';

import 'package:circle_of_light/core/api/app_api.dart';
import 'package:circle_of_light/features/auth/data/model/user_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

class AuthRemoteDataSource {
  final Dio dio;
  final FlutterAppAuth appAuth;

  AuthRemoteDataSource(this.dio, this.appAuth);

  Future<UserModel> loginWithQuran() async {
    const clientId = "b90f5393-b76b-41dd-bdd8-b7c738536464";
    const redirectUri = "dayira://quran-login";

    const String issuer = 'https://prelive-oauth2.quran.foundation/oauth2/auth';
    const String tokenEndpoint =
        'https://prelive-oauth2.quran.foundation/oauth2/token';
    try {
      final result = await appAuth.authorize(
        AuthorizationRequest(
          clientId,
          redirectUri,
          serviceConfiguration: const AuthorizationServiceConfiguration(
            authorizationEndpoint: issuer,
            tokenEndpoint: tokenEndpoint,
          ),
          scopes: ['openid'],
        ),
      );

      log("RESULT: $result");
      log("CODE: ${result.authorizationCode}");

      if (result == null || result.authorizationCode == null) {
        throw Exception("User cancelled login");
      }

      final code = result.authorizationCode!;

      // final response = await dio.post(
      //   'https://YOUR_PROJECT.functions.supabase.co/exchange-code',
      //   data: {"code": code},
      // );

      // return UserModel.fromJson(response.data);
      const dummyData = {
        "id":"12",
        "name":"Rijas",
        "email":"rijas@0"
      };
      return UserModel.fromJson(dummyData);
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  Future<UserModel> exchangeCode(String code) async {
    final res = await dio.post("SUPABASE_FUNCTION", data: {"code": code});
    return UserModel.fromJson(res.data);
  }
}
