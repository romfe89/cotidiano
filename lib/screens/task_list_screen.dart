import 'package:flutter/material.dart';
import '../models/task.dart';
import '../db/task_database.dart';
import '../widgets/task_form.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> _tasks = [];
  Map<int, bool> _taskStatus = {};
  void _loadTasks() async {
    final tasks = await TaskDatabase.getTasks();
    final statusMap = <int, bool>{};

    for (final task in tasks) {
      final done = await TaskDatabase.isTaskDoneToday(task.id!);
      statusMap[task.id!] = done;
    }

    setState(() {
      _tasks = tasks;
      _taskStatus = statusMap;
    });
  }

  void _addOrEditTask({Task? task}) {
    showDialog(
      context: context,
      builder:
          (_) => TaskForm(
            task: task,
            onSave: (newTask) async {
              if (newTask.id == null) {
                await TaskDatabase.insertTask(newTask);
              } else {
                await TaskDatabase.updateTask(newTask);
              }
              Navigator.pop(context);
              _loadTasks();
            },
          ),
    );
  }

  void _deleteTask(int id) async {
    await TaskDatabase.deleteTask(id);
    _loadTasks();
  }

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Tarefas')),
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (_, i) {
          final task = _tasks[i];
          return ListTile(
            title: Text(task.title),
            subtitle: Text(task.description),
            leading: Checkbox(
              value: _taskStatus[task.id] ?? false,
              onChanged: (val) async {
                await TaskDatabase.setTaskDone(task.id!, val ?? false);
                _loadTasks();
              },
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _addOrEditTask(task: task),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteTask(task.id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditTask(),
        child: Icon(Icons.add),
      ),
    );
  }
}
