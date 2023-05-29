import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../models/task.dart';
import '../bloc_exports.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<RemoveTaskEvent>(_onRemoveTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  void _onAddTask(AddTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      allTasks: List.from(state.allTasks)..add(event.task),
      // Wie emitten eine neue Task-Liste mit dem neuen State.
      removedTasks: state.removedTasks,
      // Wir müssen zugleilch auch die Removed Tasks-Liste (wieder) emitten, da
      // da sie sonst mit null überschrieben und damit effektiv gelöscht wird.
    ));
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTasks.indexOf(task);

    // Zunächst entfernen wir den "alten" Task aus der Liste:
    List<Task> allTasks = List.from(state.allTasks)..remove(task);

    // Anschließend fügen wir den neuen Task mit dem neuen Wert hinzu (falls
    // der aktuelle Wert "false" ist, dann ist der neue Wert "true" und vice versa).
    // Wir verwenden "insert" (statt "add") und den index-Wert, damit genau die Checkbox
    // markiert wird, die wir angeklickt haben - andernfalls werden die Checkboxen
    // einfach von unten nach oben abgearbeitet.
    task.isDone == false
        ? allTasks.insert(index, task.copyWith(isDone: true))
        : allTasks.insert(index, task.copyWith(isDone: false));

    // Und zuletzt emitten wir den neuen State mit dem aktualisierten Task;
    // zusätzlich müssen wir auch den aktuellen state der removed Tasks emitten,
    // damit diese nicht mit null-Werten überschrieben werden (wie beim AddTask).
    emit(TasksState(allTasks: allTasks, removedTasks: state.removedTasks));
  }

  void _onRemoveTask(RemoveTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        allTasks: List.from(state.allTasks)..remove(event.task),
        removedTasks: List.from(state.removedTasks)
          ..add(
            event.task.copyWith(isDeleted: true),
          ),
      ),
    );
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        allTasks: state.allTasks,
        removedTasks: List.from(state.removedTasks)..remove(event.task),
      ),
    );
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
