import 'package:flutter_todo_list/models/model_progress.dart';
import 'package:flutter_todo_list/services/db_todo.dart';

class ModelTodoCategory {
  String id;
  String title;
  String color;
  String emoji;
  int timestamp;
  bool isCompleted;

  ModelTodoCategory({
    required this.id,
    required this.title,
    required this.color,
    required this.emoji,
    required this.timestamp,
    required this.isCompleted,
  });

  Map toMap() {
    return {
      'id': id,
      'title': title,
      'color': color,
      'emoji': emoji,
      'timestamp': timestamp,
      'isCompleted': isCompleted
    };
  }

  factory ModelTodoCategory.fromJson(Map<dynamic, dynamic> json) {
    return ModelTodoCategory(
      id: json['id'],
      title: json['title'],
      color: json['color'],
      emoji: json['emoji'] ?? '🥰',
      isCompleted: json['isCompleted'] ?? false,
      timestamp: int.tryParse(json['timestamp'].toString()) ?? 0,
    );
  }

  ModelProgressTodo get progressCalculation {
    final todoList = DBTodo.boxGetByKeyValue(
      key: 'todoCategoryId',
      value: id,
    );

    if (todoList == null) {
      return ModelProgressTodo(percentage: 0, displayString: '...');
    }

    if (todoList.isEmpty) {
      return ModelProgressTodo(percentage: 0, displayString: '...');
    }

    int total = todoList.length;
    int completed =
        todoList.where((todo) => todo['isCompleted'] == true).length;
    double cal = completed / total;
    String disp = '$completed/$total';

    return ModelProgressTodo(percentage: cal, displayString: disp);
  }
}
