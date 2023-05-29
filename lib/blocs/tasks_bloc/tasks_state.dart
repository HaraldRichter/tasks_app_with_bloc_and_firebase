part of 'tasks_bloc.dart';

@immutable
class TasksState extends Equatable {
  // Wir erstellen zwei Listen, eine für alle Tasks, eine für die Tasks, die im
  // RecycleBin liegen. Beide Listen werden als leere Listen initialisiert.
  final List<Task> allTasks;
  final List<Task> removedTasks;
  const TasksState({
    this.allTasks = const <Task>[],
    this.removedTasks = const <Task>[],
  });

  // Zum Abgleich der Listen mit Hilfe des Equatable-Packages:
  @override
  List<Object?> get props => [allTasks, removedTasks];

  /// Stuff für HydratedBloc:
  Map<String, dynamic> toMap() {
    return {
      'allTasks': allTasks.map((x) => x.toMap()).toList(),
      'removedTasks': removedTasks.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
      allTasks: List<Task>.from(
        map['allTasks']?.map(
          (x) => Task.fromMap(x),
        ),
      ),
      removedTasks: List<Task>.from(
        map['removedTasks']?.map(
          (x) => Task.fromMap(x),
        ),
      ),
    );
  }
}
