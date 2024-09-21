import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/services/db_todo_category.dart';
import 'package:get/get.dart';

class TodoCategoryFormController extends GetxController {
  static TodoCategoryFormController ctrl =
      Get.put(TodoCategoryFormController());

  void onSaveTodoCategory(
    ModelTodoCategory saveTodoForm, {
    required VoidCallback onComplete,
    required VoidCallback onError,
  }) async {
    try {
      await DBTodoCategory.boxSave(saveTodoForm);
      onComplete.call();
    } catch (e) {
      onError.call();
    }
  }
}
