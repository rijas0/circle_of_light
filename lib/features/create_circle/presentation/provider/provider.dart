import 'package:circle_of_light/features/create_circle/data/datasource/circle_access_datasource.dart';
import 'package:circle_of_light/features/create_circle/data/repository/circle_access_repo_impl.dart';
import 'package:circle_of_light/features/create_circle/domain/usecases/create_circle_usecase.dart';
import 'package:circle_of_light/features/create_circle/domain/usecases/join_circle_usecase.dart';
import 'package:circle_of_light/features/create_circle/presentation/viewmodel/circle_access_notifier.dart';
import 'package:circle_of_light/features/create_circle/presentation/viewmodel/circle_access_state.dart';
import 'package:circle_of_light/shared/providers/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';


final circleRemoteDatasourceProvider =
    Provider((ref) => CircleAccessDatasource(ref.read(dioProvider), ref.read(tokenStorageProvider)));

final circleRepositoryProvider =
    Provider((ref) => CircleAccessRepoImpl(
          ref.read(circleRemoteDatasourceProvider),
        ));

final createCircleUseCaseProvider =
    Provider((ref) => CreateCircleUseCase(
          ref.read(circleRepositoryProvider),
        ));

final joinCircleUseCaseProvider =
    Provider((ref) => JoinCircleUseCase(
          ref.read(circleRepositoryProvider),
        ));

final circleNotifierProvider =
    StateNotifierProvider<CircleAccessNotifier, CircleAccessState>(
  (ref) => CircleAccessNotifier(
    ref.read(createCircleUseCaseProvider),
    ref.read(joinCircleUseCaseProvider),
  ),
);