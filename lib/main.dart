import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/presentation/pages/todo_page.dart';
import 'injection_container.dart' as di;
import 'features/presentation/bloc/todo_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo List',
      home: BlocProvider(
        create: (_) => di.sl<TodoBloc>()..add(LoadTodosEvent()),
        child: const TodoPage(),
      ),
    );
  }
}
