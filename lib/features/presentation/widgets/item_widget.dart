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
    return Column(
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
              fontSize: 16,
              decoration: todo.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: todo.isDone ? Colors.grey : Colors.black87,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: onDelete,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 60),
          child: Divider(
            height: 1,
            thickness: 0.8,
            color: Colors.grey,
            endIndent: 16,
          ),
        ),
      ],
    );
  }
}


