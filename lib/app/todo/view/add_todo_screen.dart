import 'package:flutter/material.dart';
import 'package:todo_app/app/todo/model/todo_entity.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    dateController.dispose();
    priorityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(hintText: 'Task Name'),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: dateController,
            decoration: const InputDecoration(hintText: 'Date'),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: priorityController,
            decoration: const InputDecoration(hintText: 'Priority'),
          ),
          const SizedBox(
            height: 8,
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              final task = TodoEntity(
                taskName: nameController.text,
                description: '',
                taskDate: dateController.text,
                priorityLevel: priorityController.text,
                isDone: false,
              );

              Navigator.pop(context, task);
            },
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.90,
              color: Colors.blue[400]!,
              child: const Center(
                child: Text(
                  'Done',
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
    );
  }
}
