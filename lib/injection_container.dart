import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/data/datasources/todo_local_data_source.dart';
import 'features/data/repositories/todo_repository_impl.dart';
import 'features/domain/repositories/todo_repository.dart';
import 'features/domain/usecases/add_todo.dart';
import 'features/domain/usecases/delete_todo.dart';
import 'features/domain/usecases/get_todos.dart';
import 'features/domain/usecases/update_todo.dart';
import 'features/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Features - Bloc
  sl.registerFactory(() => TodoBloc(
    getTodosUseCase: sl(),
    addTodoUseCase: sl(),
    deleteTodoUseCase: sl(),
    updateTodoUseCase: sl(),
  ));

  // Usecases
  sl.registerLazySingleton(() => GetTodos(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));

  // Repository
  sl.registerLazySingleton<TodoRepository>(
          () => TodoRepositoryImpl(localDataSource: sl()));

  // Data source
  sl.registerLazySingleton<TodoLocalDataSource>(
          () => TodoLocalDataSourceImpl(sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
