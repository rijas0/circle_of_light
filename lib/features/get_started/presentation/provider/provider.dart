import '../../data/datasource/user_circle_check_datasource.dart';
import '../../data/repository/user_circle_check_impl.dart';
import '../../domain/usercase/user_circle_check_use_case.dart';
import '../viewmodel/get_started_notifier.dart';
import '../viewmodel/get_started_state.dart';
import 'package:circle_of_light/shared/providers/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final userCircleCheckDataSourceProvider = Provider(
  (ref) => UserCircleCheckDatasource(
    ref.read(dioProvider),
    ref.read(tokenStorageProvider),
  ),
);

final userCircleCheckRepoProvider = Provider(
  (ref) => UserCircleCheckImpl(ref.read(userCircleCheckDataSourceProvider)),
);

final userCircleCheckUseCaseProvider = Provider(
  (ref) => UserCircleCheckUseCase(ref.read(userCircleCheckRepoProvider)),
);

final userCircleCheckNotifierProvider =
    StateNotifierProvider<GetStartedNotifier, GetStartedState>(
      (ref) => GetStartedNotifier(ref.read(userCircleCheckUseCaseProvider)),
    );
