import '../../data/datasource/circle_remote_datasource.dart';
import '../../data/repositories/circle_repository_impl.dart';
import '../../domain/usecases/circle_details_usecase.dart';
import '../../domain/usecases/circle_task_usecase.dart';
import '../../domain/usecases/circle_usecase.dart';
import '../viewmodel/circle_details_notifier.dart';
import '../viewmodel/circle_details_state.dart';
import '../viewmodel/circle_notifier.dart';
import '../viewmodel/circle_state.dart';
import '../viewmodel/circle_task_crud_notifier.dart';
import '../viewmodel/circle_task_crud_state.dart';
import '../../../../shared/providers/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final circleListRemoteDatasourceProvider = Provider(
  (ref) => CircleRemoteDataSource(
    ref.read(dioProvider),
    ref.read(tokenStorageProvider),
  ),
);
final circleListRepositoryProvider = Provider(
  (ref) => CircleRepositoryImpl(ref.read(circleListRemoteDatasourceProvider)),
);
final circleListUseCaseProvider = Provider(
  (ref) => CircleUseCase(ref.read(circleListRepositoryProvider)),
);
final circleListNotifierProvider =
    StateNotifierProvider<CircleNotifier, CircleState>(
      (ref) => CircleNotifier(ref.read(circleListUseCaseProvider)),
    );
final circleDetailsUseCaseProvider = Provider(
  (ref) => CircleDetailsUseCase(ref.read(circleListRepositoryProvider)),
);
final circleDetailsNotifierProvider =
    StateNotifierProvider<CircleDetailsNotifier, CircleDetailsState>(
      (ref) => CircleDetailsNotifier(ref.read(circleDetailsUseCaseProvider)),
    );
final circleTaskUseCaseProvider = Provider(
  (ref) => CircleTaskUseCase(ref.read(circleListRepositoryProvider)),
);

final circleTaskCrudNotifierProvider =
    StateNotifierProvider<CircleTaskCrudNotifier, CircleTaskCrudState>(
      (ref) => CircleTaskCrudNotifier(ref.read(circleTaskUseCaseProvider),ref),
    );
