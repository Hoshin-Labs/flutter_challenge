import 'package:flutter/material.dart';
import 'package:todo_app/app/todo/model/todo_entity.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.item,
    required this.onChanged,
  });

  final TodoEntity item;
  final Function(bool) onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.taskName),
          Text('${item.taskDate}*${item.priorityLevel}'),
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
