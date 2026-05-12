import 'package:circle_of_light/features/circles/data/datasource/circle_remote_datasource.dart';
import 'package:circle_of_light/features/create_circle/data/datasource/circle_access_datasource.dart';
import 'package:circle_of_light/features/create_circle/data/repository/circle_access_repo_impl.dart';
import 'package:circle_of_light/features/create_circle/domain/usecases/create_circle_usecase.dart';
import 'package:circle_of_light/features/create_circle/presentation/viewmodel/circle_access_notifier.dart';
import 'package:circle_of_light/features/create_circle/presentation/viewmodel/circle_access_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final dioProvider = Provider((ref)=>Dio());

final circleRemoteDatasourceProvider =
    Provider((ref) => CircleAccessDatasource(ref.read(dioProvider)));

final circleRepositoryProvider =
    Provider((ref) => CircleAccessRepoImpl(
          ref.read(circleRemoteDatasourceProvider),
        ));

final createCircleUseCaseProvider =
    Provider((ref) => CreateCircleUseCase(
          ref.read(circleRepositoryProvider),
        ));

final circleNotifierProvider =
    StateNotifierProvider<CircleAccessNotifier, CircleAccessState>(
  (ref) => CircleAccessNotifier(
    ref.read(createCircleUseCaseProvider),
  ),
);