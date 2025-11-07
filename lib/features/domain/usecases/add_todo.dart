import '../../../core/usecases/usecases.dart';
import '../entities/todo_entity.dart';
import '../repositories/todo_repository.dart';

class AddTodo implements UseCase<void, TodoEntity> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  Future<void> call(TodoEntity todo) async {
    await repository.addTodo(todo);
  }
}
