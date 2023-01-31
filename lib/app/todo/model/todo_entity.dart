import 'dart:core';

class TodoEntity {
  TodoEntity({
    required this.taskName,
    required this.description,
    required this.taskDate,
    required this.priorityLevel,
    required this.isDone,
  });
  late String taskName;
  late String description;
  late String taskDate;
  late String priorityLevel;
  late bool isDone;

  TodoEntity copyWith({
    String? taskName,
    String? description,
    String? taskDate,
    String? priorityLevel,
    bool? isDone,
  }) {
    return TodoEntity(
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TodoEntity &&
        other.taskName == taskName &&
        other.description == description &&
        other.taskDate == taskDate &&
        other.priorityLevel == priorityLevel &&
        other.isDone == isDone;
  }

  @override
  int get hashCode {
    return taskName.hashCode ^
        description.hashCode ^
        taskDate.hashCode ^
        priorityLevel.hashCode ^
        isDone.hashCode;
  }
}
