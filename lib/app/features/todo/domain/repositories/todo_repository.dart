import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/app/features/todo/domain/entities/task_entity.dart';

abstract class TodoRepository {
  Stream<DatabaseEvent> getTasks();
  Future<void> addTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
  Future<void> deleteTask(String id);
}
