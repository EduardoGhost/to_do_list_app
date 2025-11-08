import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/todo_filter.dart';
import '../bloc/todo_bloc.dart';
import '../widgets/todo_app_bar.dart';
import '../widgets/filter_bar.dart';
import '../widgets/empty_widget.dart';
import '../widgets/item_widget.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TodoAppBar(title: 'To do List'),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          final bloc = context.read<TodoBloc>();
          final filteredTodos = bloc.applyFilter(state.todos, state.filter);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: FilterBar(
                  filter: state.filter,
                  onFilterChanged: (filter) =>
                      bloc.add(ChangeFilterEvent(filter)),
                ),
              ),

              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: Builder(
                    key: ValueKey(state.todos.length + state.filter.index),
                    builder: (context) {
                      if (state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state.errorMessage != null) {
                        return Center(
                          child: Text(
                            state.errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }

                      if (filteredTodos.isEmpty) {
                        String message;
                        switch (state.filter) {
                          case TodoFilter.pending:
                            message = 'Você não tem tarefas pendentes!';
                            break;
                          case TodoFilter.done:
                            message = 'Nenhuma tarefa concluída ainda.';
                            break;
                          default:
                            message = 'Nenhuma tarefa por aqui!';
                        }

                        return EmptyWidget(message: message);
                      }

                      return ListView.builder(
                        key: ValueKey(filteredTodos.length),
                        itemCount: filteredTodos.length,
                        itemBuilder: (context, index) {
                          final todo = filteredTodos[index];
                          return ItemWidget(
                            todo: todo,
                            onToggle: () =>
                                bloc.add(ToggleTodoStatusEvent(todo)),
                            onDelete: () =>
                                bloc.add(DeleteTodoEvent(todo.id)),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF012456),
        elevation: 6,
        shape: const CircleBorder(),
        onPressed: () async {
          final controller = TextEditingController();
          final result = await showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Nova Tarefa'),
              content: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Digite o nome da tarefa',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context, controller.text),
                  child: const Text('Adicionar'),
                ),
              ],
            ),
          );

          if (result != null && result.isNotEmpty) {
            context.read<TodoBloc>().add(AddTodoEvent(result));
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}