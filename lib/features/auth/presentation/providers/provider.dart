import 'package:circle_of_light/features/auth/domain/usecases/exchange_code_usecase.dart';

import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:riverpod/riverpod.dart';

final dioProvider = Provider((ref) => Dio());

final remoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(ref.read(dioProvider)),
);

final authRepositoryProvider = Provider(
  (ref) => AuthRepoImpl(ref.read(remoteDataSourceProvider)),
);
final exchangeCodeUseCaseProvider = Provider(
  (ref) => ExchangeCodeUseCase(ref.read(authRepositoryProvider)),
);