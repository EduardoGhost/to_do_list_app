import 'package:flutter/material.dart';
import '../../domain/entities/todo_filter.dart';

class FilterBar extends StatelessWidget {
  final TodoFilter filter;
  final ValueChanged<TodoFilter> onFilterChanged;

  const FilterBar({
    super.key,
    required this.filter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _buildSegment('All', TodoFilter.all),
          _buildSegment('Pending', TodoFilter.pending),
          _buildSegment('Done', TodoFilter.done),
        ],
      ),
    );
  }

  Widget _buildSegment(String label, TodoFilter value) {
    final bool isSelected = filter == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => onFilterChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1565C0) : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}


