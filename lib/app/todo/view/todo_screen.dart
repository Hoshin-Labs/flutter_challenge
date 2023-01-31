import 'package:flutter/material.dart';
import 'package:todo_app/app/todo/model/todo_entity.dart';
import 'package:todo_app/app/todo/view/add_todo_screen.dart';
import 'package:todo_app/app/todo/view/widgets/todo_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TodoEntity> tasks = <TodoEntity>[];
  late int numberOfTasksDone;

  @override
  void initState() {
    super.initState();
    initSampleTasks();
    updateTasks();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Tasks',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$numberOfTasksDone of ${tasks.length}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey<int>(index),
                  background: const ColoredBox(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      setState(() {
                        tasks.removeAt(index);
                      });
                      updateTasks();
                    }
                  },
                  child: TodoItem(
                    item: tasks[index],
                    onChanged: (bool isDone) {
                      setState(() {
                        tasks[index].isDone = isDone;
                        updateTasks();
                      });
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: tasks.length,
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                final task = await Navigator.push<TodoEntity>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddTodoScreen(),
                  ),
                );

                if (task != null) {
                  setState(() {
                    tasks.add(task);
                  });
                  updateTasks();
                }
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.90,
                color: Colors.blue[400]!,
                child: const Center(
                  child: Text(
                    'Add Task',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void initSampleTasks() {
    tasks
      ..add(
        TodoEntity(
          taskName: 'Test1',
          description: 'description',
          taskDate: 'June 4, 2022',
          priorityLevel: 'Low',
          isDone: false,
        ),
      )
      ..add(
        TodoEntity(
          taskName: 'Test2',
          description: 'description',
          taskDate: 'July 4, 2022',
          priorityLevel: 'Low',
          isDone: true,
        ),
      );
  }

  void updateTasks() {
    setState(() {
      numberOfTasksDone = tasks.where((element) => element.isDone).toList().length;
    });
  }
}
