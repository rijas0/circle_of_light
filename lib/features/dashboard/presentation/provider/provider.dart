import '../../data/datasource/home_remote_datasource.dart';
import '../../data/repository/home_repository_impl.dart';
import '../../domain/usecases/home_usecase.dart';
import '../viewmodel/home_notifier.dart';
import '../viewmodel/home_state.dart';
import 'package:circle_of_light/shared/providers/provider.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod/riverpod.dart';

final homeRemoteDatasourceProvider = Provider(
  (ref) => HomeRemoteDatasource(ref.read(dioProvider)),
);

final homeRepositoryProvider = Provider(
  (ref) => HomeRepositoryImpl(ref.read(homeRemoteDatasourceProvider)),
);

final homeUseCaseProvider = Provider(
  (ref) => HomeUseCase(ref.read(homeRepositoryProvider)),
);

final homeNotifierProvider = Provider(
  (ref) => StateNotifierProvider<HomeNotifier, HomeState>(
    (ref) => HomeNotifier(ref.read(homeUseCaseProvider)),
  ),
);
