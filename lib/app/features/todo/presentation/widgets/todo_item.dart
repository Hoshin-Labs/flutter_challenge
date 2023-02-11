import 'package:flutter/material.dart';
import 'package:todo_app/app/features/todo/domain/entities/task_entity.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.item,
    required this.onChanged,
  });

  final TaskEntity item;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.taskName ?? '',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            item.description ?? '',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Text('${item.taskDate} * ${item.priorityLevel}'),
        ],
      ),
      trailing: Checkbox(
        onChanged: (bool? taskDone) {
          onChanged(taskDone!);
        },
        value: item.isDone,
      ),
    );
  }
}
