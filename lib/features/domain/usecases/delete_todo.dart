import '../../../core/usecases/usecases.dart';
import '../repositories/todo_repository.dart';

class DeleteTodo implements UseCase<void, String> {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  @override
  Future<void> call(String id) async {
    await repository.deleteTodo(id);
  }
}

