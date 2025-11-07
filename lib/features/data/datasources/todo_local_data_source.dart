import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getTodos();
  Future<void> saveTodos(List<TodoModel> todos);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  static const String _storageKey = 'todos';
  final SharedPreferences sharedPreferences;

  TodoLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<List<TodoModel>> getTodos() async {
    final jsonString = sharedPreferences.getString(_storageKey);
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }

    try {
      return TodoModel.listFromJson(jsonString);
    } catch (e) {
      print('Erro ao carregar todos: $e');
      return [];
    }
  }

  @override
  Future<void> saveTodos(List<TodoModel> todos) async {
    try {
      final jsonString = TodoModel.listToJson(todos);
      await sharedPreferences.setString(_storageKey, jsonString);
    } catch (e) {
      print('Erro ao salvar todos: $e');
    }
  }
}
