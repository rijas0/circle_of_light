import 'dart:developer';

import 'package:dio/dio.dart';

import '../storage/token_storage_service.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorageService tokenStorage;

  AuthInterceptor(this.tokenStorage);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Don't override if the caller already set an Authorization header
    if (options.headers.containsKey('Authorization')) {
      handler.next(options);
      return;
    }
    final token = await tokenStorage.getAccessToken();
    log('AuthInterceptor: token present: ${token?.isNotEmpty == true}');
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
