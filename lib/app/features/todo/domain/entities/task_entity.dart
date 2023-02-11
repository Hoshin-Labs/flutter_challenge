import 'dart:core';

class TaskEntity {
  TaskEntity({
    this.id,
    this.taskName,
    this.description,
    this.taskDate,
    this.priorityLevel,
    this.isDone = false,
  });
  String? id;
  String? taskName;
  String? description;
  String? taskDate;
  String? priorityLevel;
  bool isDone;

  TaskEntity copyWith({
    String? id,
    String? taskName,
    String? description,
    String? taskDate,
    String? priorityLevel,
    bool? isDone,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      description: description ?? this.description,
      taskDate: taskDate ?? this.taskDate,
      priorityLevel: priorityLevel ?? this.priorityLevel,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  String toString() {
    return 'TodoEntity(taskName: $taskName, description: $description, taskDate: $taskDate, priorityLevel: $priorityLevel, isDone: $isDone)';
  }
}
