import 'package:flutter/material.dart';
import '../../domain/entities/todo_entity.dart';

class ItemWidget extends StatelessWidget {
  final TodoEntity todo;
  final VoidCallback onToggle;
  final VoidCallback onDelete;

  const ItemWidget({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: todo.isDone ? 0.6 : 1.0,
      duration: const Duration(milliseconds: 300),
      child: Column(
        children: [
          ListTile(
            leading: Checkbox(
              value: todo.isDone,
              onChanged: (_) => onToggle(),
              checkColor: Colors.white,
              activeColor: const Color(0xFF1565C0),
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
              onPressed: onDelete,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 60),
            child: Divider(thickness: 1, height: 1),
          ),
        ],
      ),
    );
  }
}


