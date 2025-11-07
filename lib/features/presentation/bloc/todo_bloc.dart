import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/todo_filter.dart';
import '../../domain/entities/todo_entity.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/update_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';


class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodosUseCase;
  final AddTodo addTodoUseCase;
  final DeleteTodo deleteTodoUseCase;
  final UpdateTodo updateTodoUseCase;

  TodoBloc({
    required this.getTodosUseCase,
    required this.addTodoUseCase,
    required this.deleteTodoUseCase,
    required this.updateTodoUseCase,
  }) : super(const TodoState()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
    on<ToggleTodoStatusEvent>(_onToggleTodoStatus);
    on<ChangeFilterEvent>(_onChangeFilter);

  }

  Future<void> _onLoadTodos(
      LoadTodosEvent event, Emitter<TodoState> emit) async {
    emit(state.copyWith(isLoading: true));
    final todos = await getTodosUseCase.call(NoParams());
    emit(state.copyWith(isLoading: false, todos: todos));
  }

  Future<void> _onAddTodo(
      AddTodoEvent event, Emitter<TodoState> emit) async {
    final newTodo = TodoEntity(
      id: const Uuid().v4(),
      title: event.title,
    );
    await addTodoUseCase.call(newTodo);
    add(LoadTodosEvent());
  }

  Future<void> _onDeleteTodo(
      DeleteTodoEvent event, Emitter<TodoState> emit) async {
    await deleteTodoUseCase.call(event.id);
    add(LoadTodosEvent());
  }

  Future<void> _onToggleTodoStatus(
      ToggleTodoStatusEvent event, Emitter<TodoState> emit) async {
    final todo = event.todo;
    final updated = todo.copyWith(
      status: todo.isDone ? TodoStatus.pending : TodoStatus.done,
    );
    await updateTodoUseCase.call(updated);
    add(LoadTodosEvent());
  }

  void _onChangeFilter(ChangeFilterEvent event, Emitter<TodoState> emit) {
    emit(state.copyWith(filter: event.filter));
  }


  List<TodoEntity> applyFilter(List<TodoEntity> todos, TodoFilter filter) {
    switch (filter) {
      case TodoFilter.pending:
        return todos.where((t) => !t.isDone).toList();
      case TodoFilter.done:
        return todos.where((t) => t.isDone).toList();
      case TodoFilter.all:
      return todos;
    }
  }

}

