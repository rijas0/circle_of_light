import '../entities/create_task_entity.dart';
import '../entities/delete_task_entity.dart';
import '../repository/circle_repository.dart';

class CircleTaskUseCase {
  final CircleRepository repository;

  CircleTaskUseCase(this.repository);

  Future<Map<String,dynamic>> create({required CreateTaskEntity task}) {
    return repository.createTask(task: task);
  }
  Future<Map<String,dynamic>> update({required CreateTaskEntity task}) {
    return repository.updateTask(task: task);
  }
  Future<Map<String,dynamic>> delete({required DeleteTaskEntity task}) {
    return repository.deleteTask(deleteTask: task);
  }
}