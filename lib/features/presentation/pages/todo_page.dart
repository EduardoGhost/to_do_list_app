import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/todo_filter.dart';
import '../bloc/todo_bloc.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minha Lista de Tarefas')),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          final filteredTodos =
          context.read<TodoBloc>().applyFilter(state.todos, state.filter);

          return Column(
            children: [
              // --- bar ---
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: state.filter == TodoFilter.all,
                      onSelected: (_) => context
                          .read<TodoBloc>()
                          .add(ChangeFilterEvent(TodoFilter.all)),
                    ),
                    FilterChip(
                      label: const Text('Pending'),
                      selected: state.filter == TodoFilter.pending,
                      onSelected: (_) => context
                          .read<TodoBloc>()
                          .add(ChangeFilterEvent(TodoFilter.pending)),
                    ),
                    FilterChip(
                      label: const Text('Done'),
                      selected: state.filter == TodoFilter.done,
                      onSelected: (_) => context
                          .read<TodoBloc>()
                          .add(ChangeFilterEvent(TodoFilter.done)),
                    ),
                  ],
                ),
              ),

              // --- Lista de tarefas ---
              if (state.isLoading)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (filteredTodos.isEmpty)
                const Expanded(
                  child: Center(child: Text('Nenhuma tarefa.')),
                )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTodos.length,
                    itemBuilder: (context, index) {
                      final todo = filteredTodos[index];
                      return ListTile(
                        leading: Checkbox(
                          value: todo.isDone,
                          onChanged: (_) {
                            context.read<TodoBloc>().add(
                              ToggleTodoStatusEvent(todo),
                            );
                          },
                        ),
                        title: Text(
                          todo.title,
                          style: TextStyle(
                            decoration: todo.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => context
                              .read<TodoBloc>()
                              .add(DeleteTodoEvent(todo.id)),
                        ),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final controller = TextEditingController();
          final result = await showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Nova Tarefa'),
              content: TextField(
                controller: controller,
                decoration: const InputDecoration(hintText: 'Digite o nome da tarefa'),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}




