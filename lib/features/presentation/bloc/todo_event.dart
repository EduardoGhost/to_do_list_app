part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object?> get props => [];
}

class LoadTodosEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final String title;
  const AddTodoEvent(this.title);

  @override
  List<Object?> get props => [title];
}

class DeleteTodoEvent extends TodoEvent {
  final String id;
  const DeleteTodoEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class ToggleTodoStatusEvent extends TodoEvent {
  final TodoEntity todo;
  const ToggleTodoStatusEvent(this.todo);

  @override
  List<Object?> get props => [todo];
}

class ChangeFilterEvent extends TodoEvent {
  final TodoFilter filter;
  ChangeFilterEvent(this.filter);
}
