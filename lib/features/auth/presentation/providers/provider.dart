import 'package:circle_of_light/features/auth/data/repositories/room_repo_impl.dart';
import 'package:circle_of_light/features/auth/domain/usecases/check_user_room_usecase.dart';
import 'package:circle_of_light/features/auth/domain/usecases/exchange_code_usecase.dart';
import 'package:circle_of_light/features/auth/domain/usecases/login_with_quran_usercase.dart';
import 'package:circle_of_light/features/auth/presentation/viewmodel/auth_notifier.dart';
import 'package:circle_of_light/features/auth/presentation/viewmodel/auth_state.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final dioProvider = Provider((ref) => Dio());

final appAuthProvider = Provider((ref) => FlutterAppAuth());

final remoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(ref.read(dioProvider),ref.read(appAuthProvider)),
);

final authRepositoryProvider = Provider(
  (ref) => AuthRepoImpl(ref.read(remoteDataSourceProvider)),
);
final exchangeCodeUseCaseProvider = Provider(
  (ref) => ExchangeCodeUseCase(ref.read(authRepositoryProvider)),
);
final loginUseCaseProvider = Provider(
  (ref) => LoginWithQuranUseCase(
    ref.read(authRepositoryProvider),
  ),
);
final roomRepositoryProvider = Provider((ref)=>RoomRepositoryImpl(ref.read(dioProvider)));
final checkUserRoomUseCase = Provider((ref)=>CheckUserRoomUseCase(ref.read(roomRepositoryProvider)));
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(exchangeCodeUseCaseProvider),ref.read(loginUseCaseProvider),ref.read(checkUserRoomUseCase));
});