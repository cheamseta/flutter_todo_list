import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/model_subtask.dart';
import 'package:flutter_todo_list/models/model_todo.dart';
import 'package:flutter_todo_list/services/db_todo.dart';
import 'package:get/get.dart';

class TodoDetailController extends GetxController {
  static TodoDetailController ctrl = Get.put(TodoDetailController());
  late ModelTodo selectdTodo;

  void onAddSubtask({
    required ModelSubtask subtask,
    required VoidCallback onComplete,
  }) async {
    selectdTodo.subtasks.add(subtask);
    await DBTodo.boxSave(selectdTodo);
    update();
    onComplete.call();
  }

  void onRemoveSubtask({
    required ModelSubtask subtask,
    required ModelTodo todo,
  }) async {
    todo.subtasks.remove(subtask);
    await DBTodo.boxSave(todo);
    update();
  }

  void onSaveTags({
    required String tag,
    required ModelTodo todo,
  }) async {
    todo.tags.add(tag);
    await DBTodo.boxSave(todo);
    update();
  }

  void onRemoveTags({
    required String tag,
    required ModelTodo todo,
  }) async {
    todo.tags.remove(tag);
    await DBTodo.boxSave(todo);
    update();
  }

  void onSaveSubtitl({
    required ModelTodo todo,
    required String text,
    required onComplete,
  }) async {
    todo.subtitle = text;
    await DBTodo.boxSave(todo);
    onComplete.call();
  }

  void onCheckSubtask({
    required ModelSubtask subtask,
    required ModelTodo todo,
  }) async {
    subtask.isCompleted = !subtask.isCompleted;
    await DBTodo.boxSave(todo);
    update();
  }

  void onSave(ModelTodo todo) async {
    await DBTodo.boxSave(todo);
  }
}
