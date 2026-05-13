import 'package:circle_of_light/core/network/auth_interceptor.dart';
import 'package:circle_of_light/core/storage/token_storage_service.dart';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final tokenStorageProvider = Provider((ref) => TokenStorageService());

final dioProvider = Provider<Dio>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
  ));
  dio.interceptors.add(AuthInterceptor(tokenStorage));
  return dio;
});
