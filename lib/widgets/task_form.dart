import 'package:flutter/material.dart';
import '../models/task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TaskForm extends StatefulWidget {
  final Task? task;
  final void Function(Task) onSave;

  TaskForm({this.task, required this.onSave});

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _titleController.text = widget.task!.title;
      _descriptionController.text = widget.task!.description;
    }
  }

  void _submit() {
    final task = Task(
      id: widget.task?.id,
      title: _titleController.text,
      description: _descriptionController.text,
    );
    widget.onSave(task);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(widget.task == null ? loc.newTask : loc.editTask),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: loc.title),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: loc.description),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(loc.cancel),
        ),
        ElevatedButton(onPressed: _submit, child: Text(loc.save)),
      ],
    );
  }
}
