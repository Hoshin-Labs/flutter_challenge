import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:todo_app/app/core/presentation/notifications/push_notifications.dart';
import 'package:todo_app/app/core/presentation/utilities/snackbar_helper.dart';
import 'package:todo_app/app/features/auth/presentation/cubit/authentication_cubit.dart';
import 'package:todo_app/app/features/todo/domain/entities/task_entity.dart';
import 'package:todo_app/app/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:todo_app/app/features/todo/presentation/screens/task_information_screen.dart';
import 'package:todo_app/app/features/todo/presentation/widgets/todo_item.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  static const String route = '/todo_screen';

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<TaskEntity> tasks = <TaskEntity>[];
  int numberOfTasksDone = 0;

  @override
  void initState() {
    super.initState();
    PushNotifications();
    context.read<TodoCubit>().getTasks();
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
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final connected = connectivity != ConnectivityResult.none;
          if (!connected) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Positioned(
                  height: 24,
                  left: 0,
                  right: 0,
                  child: ColoredBox(
                    color: connected ? const Color(0xFF00EE44) : const Color(0xFFEE4400),
                    child: Center(
                      child: Text(connected ? 'ONLINE' : 'OFFLINE'),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    'Not Connected!',
                  ),
                ),
              ],
            );
          } else {
            return BlocConsumer<TodoCubit, TodoState>(
              listener: (context, state) {
                if (state is TaskAdded) {
                  SnackBarHelper.showSnackBar(context, 'Task Added');
                  context.read<AuthenticationCubit>().sendNotification('Task Added');
                } else if (state is TaskUpdated) {
                  context.read<AuthenticationCubit>().sendNotification('Task Updated');
                } else if (state is TaskDeleted) {
                  SnackBarHelper.showSnackBar(context, 'Task Deleted');

                  context.read<AuthenticationCubit>().sendNotification('Task Deleted');
                }
              },
              builder: (context, state) {
                if (state is TodoLoaded) {
                  tasks = state.tasks;
                  numberOfTasksDone = tasks.where((element) => element.isDone).length;
                }
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is TodoLoading) ...[
                        const Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ],
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
                      if (tasks.isEmpty) ...[
                        const Center(
                          child: Text(
                            'No tasks yet',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                      ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(tasks[index].id.toString()),
                            background: const ColoredBox(
                              color: Colors.red,
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                context.read<TodoCubit>().deleteTask(tasks[index].id!);
                                tasks.removeAt(index);
                              }
                            },
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  TaskInformationScreen.route,
                                  arguments: TaskInformationScreenArgs(
                                    tasks[index],
                                  ),
                                );
                              },
                              child: TodoItem(
                                item: tasks[index],
                                onChanged: (bool isDone) {
                                  tasks[index].isDone = isDone;
                                  context.read<TodoCubit>().updateTask(tasks[index]);
                                },
                              ),
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
                          await Navigator.pushNamed(
                            context,
                            TaskInformationScreen.route,
                          );
                        },
                        child: Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.90,
                          color: Colors.blue[400],
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
                );
              },
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(),
          ],
        ),
      ),
    );
  }
}
