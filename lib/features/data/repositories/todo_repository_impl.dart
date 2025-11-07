import '../../domain/entities/todo_entity.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_data_source.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;

  TodoRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addTodo(TodoEntity todo) async {
    final todos = await localDataSource.getTodos();
    final newModel = TodoModel.fromEntity(todo);
    final updated = [...todos, newModel];
    await localDataSource.saveTodos(updated);
  }

  @override
  Future<void> deleteTodo(String id) async {
    final todos = await localDataSource.getTodos();
    final updated = todos.where((t) => t.id != id).toList();
    await localDataSource.saveTodos(updated);
  }

  @override
  Future<List<TodoEntity>> getTodos() async {
    final models = await localDataSource.getTodos();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> updateTodo(TodoEntity updatedTodo) async {
    final todos = await localDataSource.getTodos();
    final index = todos.indexWhere((t) => t.id == updatedTodo.id);
    if (index != -1) {
      todos[index] = TodoModel.fromEntity(updatedTodo);
      await localDataSource.saveTodos(todos);
    }
  }
}


