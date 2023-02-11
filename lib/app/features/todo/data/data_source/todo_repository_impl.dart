import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/app/features/todo/domain/entities/task_entity.dart';
import 'package:todo_app/app/features/todo/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final database = FirebaseDatabase.instance;
  final user = FirebaseAuth.instance.currentUser;

  @override
  Stream<DatabaseEvent> getTasks() {
    final data = database.ref('users/${user!.uid}/tasks/');
    return data.onValue;
  }

  @override
  Future<void> addTask(TaskEntity task) async {
    await database.ref('users/${user!.uid}/tasks/').push().set({
      'title': task.taskName.toString().trim(),
      'description': task.description.toString().trim(),
      'isDone': task.isDone,
      'date': task.taskDate,
      'priority': task.priorityLevel
    }).then(
      (value) {},
    );

  }

  @override
  Future<void> updateTask(TaskEntity task) async {
    await database.ref('users/${user!.uid}/tasks/${task.id}').set({
      'title': task.taskName.toString().trim(),
      'description': task.description.toString().trim(),
      'isDone': task.isDone,
      'date': task.taskDate,
      'priority': task.priorityLevel
    }).then(
      (value) {},
    );
  }

  @override
  Future<void> deleteTask(String id) async {
    await database.ref('users/${user!.uid}/tasks/$id').remove().then(
          (value) {},
        );
  }
}
