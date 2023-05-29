part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

/// Add new Task
class AddTaskEvent extends TasksEvent {
  final Task task;
  const AddTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}

/// Update Task
class UpdateTaskEvent extends TasksEvent {
  final Task task;
  const UpdateTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}

/// Move Task into the RecycleBin
class RemoveTaskEvent extends TasksEvent {
  final Task task;
  const RemoveTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}

/// Delete Task
class DeleteTaskEvent extends TasksEvent {
  final Task task;
  const DeleteTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}
