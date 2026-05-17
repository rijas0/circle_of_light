import 'dart:developer';

import 'package:circle_of_light/features/circles/presentation/provider/provider.dart';
import 'package:circle_of_light/features/circles/presentation/viewmodel/circle_details_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/create_task_entity.dart';
import '../../domain/entities/delete_task_entity.dart';
import '../../domain/usecases/circle_task_usecase.dart';
import 'circle_task_crud_state.dart';
import 'package:flutter_riverpod/legacy.dart';

class CircleTaskCrudNotifier extends StateNotifier<CircleTaskCrudState>{
  final CircleTaskUseCase useCase;
  final Ref ref;
  CircleTaskCrudNotifier(this.useCase,this.ref):super(CircleTaskCrudState());

  Future<void> createTask({required CreateTaskEntity task})async{
    state = state.copyWith(isLoading: true);
    try{
      final Map<String,dynamic> response = await useCase.create(task: task);
      log('Response $response');
      state = state.copyWith(isLoading: false,response: response);
      ref.read(circleDetailsNotifierProvider.notifier);
    }catch(e){
      log('Error ${e.toString()}');
      state = state.copyWith(isLoading: false,error: e.toString());
    }
  }

  Future<void> updateTask({required CreateTaskEntity task})async{
    state = state.copyWith(isLoading: true);
    try{
      final Map<String,dynamic> response = await useCase.update(task: task);
      log('Response $response');
      state = state.copyWith(isLoading: false,response: response);
    }catch(e){
      log('Error ${e.toString()}');
      state = state.copyWith(isLoading: false,error: e.toString());
    }
  }

  Future<void> deleteTask({required DeleteTaskEntity task})async{
    state = state.copyWith(isLoading: true);
    try{
      final Map<String,dynamic> response = await useCase.delete(task: task);
      log('Response $response');
      state = state.copyWith(isLoading: false,response: response);
    }catch(e){
      log('Error ${e.toString()}');
      state = state.copyWith(isLoading: false,error: e.toString());
    }
  }


}