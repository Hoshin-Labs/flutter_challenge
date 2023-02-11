import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/app/features/todo/data/models/task_model.dart';
import 'package:todo_app/app/features/todo/domain/entities/task_entity.dart';
import 'package:todo_app/app/features/todo/domain/repositories/todo_repository.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this.todoRepository) : super(TodoInitial());

  final TodoRepository todoRepository;
  StreamSubscription? todoSubscription;

  Future<void> getTasks() async {
    try {
      await todoSubscription?.cancel();
      emit(TodoLoading());
      final tasks = <TaskEntity>[];
      todoSubscription = todoRepository.getTasks().listen((event) {
        tasks.clear();
        final data = event.snapshot;
        if (data.exists) {
          //snapshot to list
          for (final element in data.children) {
            final task = TaskModel.fromSnapshot(element);
            final entity = task.toEntity();
            tasks.add(entity);
          }
        }
        emit(TodoLoaded(tasks));
      });
    } catch (e) {
      emit(TodoError());
    }
  }

  Future<void> addTask(TaskEntity task) async {
    try {
      emit(TodoLoading());
      await todoRepository.addTask(task);
      emit(TaskAdded());
    } catch (e) {
      emit(TodoError());
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      emit(TodoLoading());
      await todoRepository.deleteTask(id);
      emit(TaskDeleted());
    } catch (e) {
      emit(TodoError());
    }
  }

  Future<void> updateTask(TaskEntity task) async {
    try {
      emit(TodoLoading());
      await todoRepository.updateTask(task);
      emit(TaskUpdated());
    } catch (e) {
      emit(TodoError());
    }
  }
}
