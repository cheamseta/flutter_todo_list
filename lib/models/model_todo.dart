import 'package:flutter_todo_list/models/model_subtask.dart';

class ModelTodo {
  String id;
  String title;
  int timestamp;
  String subtitle;
  String todoCategoryId;
  bool isCompleted;
  bool isPriority;
  List<ModelSubtask> subtasks;
  List<String> tags;
  int reminderTimestamp;

  ModelTodo(
      {required this.id,
      required this.title,
      required this.todoCategoryId,
      required this.timestamp,
      required this.subtasks,
      required this.isPriority,
      required this.tags,
      this.isCompleted = false,
      this.subtitle = '',
      this.reminderTimestamp = 0});

  Map toMap() {
    List<Map> subtasksMap = subtasks.map((e) => e.toMap()).toList();

    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'isCompleted': isCompleted,
      'todoCategoryId': todoCategoryId,
      'timestamp': timestamp,
      'tags': tags,
      'reminderTimestamp': reminderTimestamp,
      'isPriority': isPriority,
      'subtasks': subtasksMap
    };
  }

  factory ModelTodo.fromJson(Map<dynamic, dynamic> json) {
    List<ModelSubtask> subtasks = [];

    if (json['subtasks'] != null) {
      subtasks = List.from(json['subtasks'])
          .map((e) => ModelSubtask.fromJson(e))
          .toList();
    }

    return ModelTodo(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      isCompleted: json['isCompleted'] ?? false,
      isPriority: json['isPriority'] ?? false,
      todoCategoryId: json['todoCategoryId'],
      reminderTimestamp: json['reminderTimestamp'] ?? 0,
      tags: json['tags'] ?? [].cast<String>(),
      subtasks: subtasks,
      timestamp: int.tryParse(json['timestamp'].toString()) ?? 0,
    );
  }
}
