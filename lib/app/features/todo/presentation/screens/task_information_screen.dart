import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/app/features/todo/domain/entities/task_entity.dart';
import 'package:todo_app/app/features/todo/presentation/cubit/todo_cubit.dart';

class TaskInformationScreenArgs {
  TaskInformationScreenArgs(this.task);
  final TaskEntity? task;
}

class TaskInformationScreen extends StatefulWidget {
  const TaskInformationScreen({
    super.key,
    this.task,
  });

  final TaskEntity? task;

  static const String route = '/task_information_screen';

  @override
  State<TaskInformationScreen> createState() => _TaskInformationScreenState();
}

class _TaskInformationScreenState extends State<TaskInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      nameController.text = widget.task!.taskName!;
      descriptionController.text = widget.task!.description!;
      dateController.text = widget.task!.taskDate!;
      priorityController.text = widget.task!.priorityLevel!;
    }
  }

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
        title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      ),
      body: BlocConsumer<TodoCubit, TodoState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Title'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(hintText: 'Description'),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(hintText: 'Date'),
                  keyboardType: TextInputType.datetime,
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
                    final task = TaskEntity(
                      taskName: nameController.text,
                      description: descriptionController.text,
                      taskDate: dateController.text,
                      priorityLevel: priorityController.text,
                    );
                    if (widget.task == null) {
                      context.read<TodoCubit>().addTask(task);
                    } else {
                      context.read<TodoCubit>().updateTask(task);
                    }
                    Navigator.pop(context, task);
                  },
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.90,
                    color: Colors.blue[400],
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
        },
      ),
    );
  }
}
