import 'package:flutter/material.dart';
import 'package:tasks_app_with_bloc_and_firebase/widgets/task_tile.dart';
import '/blocs/bloc_exports.dart';

import '../models/task.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    super.key,
    required this.tasksList,
  });

  final List<Task> tasksList;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.tasksList.length,
        itemBuilder: (context, index) {
          // Wir separieren die einzelnen Tasks aus der tasksList mit Hilfe des index...
          var task = widget.tasksList[index];
          // ...und packen dann jeden Task in einen ListTile:
          return TaskTile(task: task);
        },
      ),
    );
  }
}
