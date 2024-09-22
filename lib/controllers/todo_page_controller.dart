import 'dart:ui';

import 'package:flutter_todo_list/models/model_todo.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/services/db_todo_category.dart';
import 'package:get/get.dart';

class TodoPageController extends GetxController {
  static TodoPageController ctrl = Get.put(TodoPageController());

  late ModelTodoCategory selectedTodoCate;
  ModelTodo? selectToDo;

  void onRemoveTodoCategory(
    ModelTodoCategory todoCate, {
    required VoidCallback onComplete,
  }) async {
    await DBTodoCategory.boxDeleteOne(todoCate);
    onComplete.call();
  }

  void onGetTodoCategoryById(String id) {
    final result = DBTodoCategory.boxGetObjectById(id: id);

    if (result == null) {
      return;
    }

    selectedTodoCate = result;
  }
}
