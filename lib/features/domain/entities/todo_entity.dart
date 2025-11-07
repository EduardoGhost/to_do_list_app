import 'package:equatable/equatable.dart';

enum TodoStatus {
  pending,
  done,
}

class TodoEntity extends Equatable {
  final String id;
  final String title;
  final TodoStatus status;

  const TodoEntity({
    required this.id,
    required this.title,
    this.status = TodoStatus.pending,
  });

  bool get isDone => status == TodoStatus.done;

  TodoEntity copyWith({
    String? id,
    String? title,
    TodoStatus? status,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [id, title, status];
}
