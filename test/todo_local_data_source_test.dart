import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_de_list_app/features/data/datasources/todo_local_data_source.dart';
import 'package:to_de_list_app/features/data/models/todo_model.dart';
import 'package:to_de_list_app/features/domain/entities/todo_entity.dart';


void main() {
  late TodoLocalDataSourceImpl dataSource;
  late SharedPreferences sharedPreferences;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    sharedPreferences = await SharedPreferences.getInstance();
    dataSource = TodoLocalDataSourceImpl(sharedPreferences);
  });

  group('TodoLocalDataSource', () {
    test('deve salvar e recuperar todos corretamente', () async {
      // Arrange
      final todos = [
        TodoModel(id: '1', title: 'Fazer café', status: TodoStatus.pending),
        TodoModel(id: '2', title: 'Estudar Flutter', status: TodoStatus.done),
      ];

      // Act
      await dataSource.saveTodos(todos);
      final result = await dataSource.getTodos();

      // Assert
      expect(result.length, 2);
      expect(result[0].title, 'Fazer café');
      expect(result[1].isDone, true);
    });

    test('deve retornar lista vazia se nada foi salvo', () async {
      // Act
      final result = await dataSource.getTodos();

      // Assert
      expect(result, isEmpty);
    });

    test('deve lidar com JSON corrompido sem lançar exceção', () async {
      // Arrange
      await sharedPreferences.setString('todos', 'json_invalido');

      // Act
      final result = await dataSource.getTodos();

      // Assert
      expect(result, isEmpty);
    });
  });
}
