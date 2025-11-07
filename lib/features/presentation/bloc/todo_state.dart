part of 'todo_bloc.dart';

class TodoState {
  final List<TodoEntity> todos;
  final bool isLoading;
  final String? errorMessage;
  final TodoFilter filter;

  const TodoState({
    this.todos = const [],
    this.isLoading = false,
    this.errorMessage,
    this.filter = TodoFilter.all,
  });

  TodoState copyWith({
    List<TodoEntity>? todos,
    bool? isLoading,
    String? errorMessage,
    TodoFilter? filter,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      filter: filter ?? this.filter,
    );
  }
}

