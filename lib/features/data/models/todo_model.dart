import 'dart:convert';
import '../../domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({
    required super.id,
    required super.title,
    super.status = TodoStatus.pending,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      status: json['status'] == 'done' ? TodoStatus.done : TodoStatus.pending,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'status': status == TodoStatus.done ? 'done' : 'pending',
    };
  }

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      title: entity.title,
      status: entity.status,
    );
  }

  TodoEntity toEntity() {
    return TodoEntity(id: id, title: title, status: status);
  }

  static List<TodoModel> listFromJson(String jsonString) {
    final List decoded = json.decode(jsonString);
    return decoded.map((e) => TodoModel.fromJson(e)).toList();
  }

  static String listToJson(List<TodoModel> todos) {
    final list = todos.map((e) => e.toJson()).toList();
    return json.encode(list);
  }
}



