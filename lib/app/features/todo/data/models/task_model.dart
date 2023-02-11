import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/app/features/todo/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    super.id,
    super.taskName,
    super.description,
    super.taskDate,
    super.priorityLevel,
    super.isDone,
  });

  factory TaskModel.fromSnapshot(DataSnapshot snapshot) {
    return TaskModel(
      id: snapshot.key.toString(),
      taskName: snapshot.child('title').value.toString(),
      description: snapshot.child('description').value.toString(),
      taskDate: snapshot.child('date').value.toString(),
      isDone: snapshot.child('isDone').value! as bool,
      priorityLevel: snapshot.child('priority').value.toString(),
    );
  }

  TaskEntity toEntity() {
    return TaskEntity(
      id: id,
      taskName: taskName,
      description: description,
      taskDate: taskDate,
      priorityLevel: priorityLevel,
      isDone: isDone,
    );
  }
}
