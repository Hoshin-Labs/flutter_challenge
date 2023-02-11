part of 'todo_cubit.dart';

@immutable
abstract class TodoState extends Equatable {
  const TodoState() : super();
  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  const TodoLoaded(this.tasks);
  final List<TaskEntity> tasks;

  @override
  List<Object> get props => [tasks];
}

class TaskAdded extends TodoState {}

class TaskUpdated extends TodoState {}

class TaskDeleted extends TodoState {}

class TodoError extends TodoState {}
