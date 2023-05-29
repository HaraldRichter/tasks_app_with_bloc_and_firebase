import 'package:flutter/material.dart';
import '../models/task.dart';
import '/blocs/bloc_exports.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
  });

  final Task task;

  void _removeOrDeleteTask(BuildContext ctx, Task task) {
    task.isDeleted!
        ? ctx.read<TasksBloc>().add(DeleteTaskEvent(task: task))
        : ctx.read<TasksBloc>().add(RemoveTaskEvent(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        task.title,
        style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        value: task.isDone,
        onChanged: task.isDeleted == false
            ? (value) {
                context.read<TasksBloc>().add(UpdateTaskEvent(task: task));
              }
            : null, // Falls der Task im Mülleimer ist, dann wird die Checkbox deaktiviert.
      ),
      onLongPress: () {
        _removeOrDeleteTask(context, task);
      },
    );
  }
}
