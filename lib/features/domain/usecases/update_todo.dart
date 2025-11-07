import '../../../core/usecases/usecases.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class UpdateTodo implements UseCase<void, TodoEntity> {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  @override
  Future<void> call(TodoEntity todo) async {
    await repository.updateTodo(todo);
  }
}

