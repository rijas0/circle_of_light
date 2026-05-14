
import 'package:circle_of_light/features/circles/data/datasource/circle_remote_datasource.dart';
import 'package:circle_of_light/features/circles/data/repositories/circle_repository_impl.dart';
import 'package:circle_of_light/features/circles/domain/usecases/circle_usecase.dart';
import 'package:circle_of_light/features/circles/presentation/viewmodel/circle_notifier.dart';
import 'package:circle_of_light/features/circles/presentation/viewmodel/circle_state.dart';
import 'package:circle_of_light/shared/providers/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final circleListRemoteDatasourceProvider = Provider((ref)=>CircleRemoteDataSource(ref.read(dioProvider),ref.read(tokenStorageProvider)));
final circleListRepositoryProvider = Provider((ref)=>CircleRepositoryImpl(ref.read(circleListRemoteDatasourceProvider)));
final circleListUseCaseProvider = Provider((ref)=>CircleUseCase(ref.read(circleListRepositoryProvider)));
final circleListProvider = StateNotifierProvider<CircleNotifier,CircleState>((ref)=> CircleNotifier(ref.read(circleListUseCaseProvider)));