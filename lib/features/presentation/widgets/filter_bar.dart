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
          _buildSegment('All', TodoFilter.all, position: 0),
          _buildSegment('Pending', TodoFilter.pending, position: 1),
          _buildSegment('Done', TodoFilter.done, position: 2),
        ],
      ),
    );
  }

  Widget _buildSegment(String label, TodoFilter value, {required int position}) {
    final bool isSelected = filter == value;

    final borderMap = <int, BorderRadius>{
      0: const BorderRadius.only(
        topLeft: Radius.circular(20),
        bottomLeft: Radius.circular(20),
      ),
      1: BorderRadius.zero,
      2: const BorderRadius.only(
        topRight: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    };
    final borderRadius = borderMap[position] ?? BorderRadius.zero;

    return Expanded(
      child: GestureDetector(
        onTap: () => onFilterChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF1565C0) : Colors.transparent,
            borderRadius: borderRadius,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black54,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}


