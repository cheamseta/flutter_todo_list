import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_list/models/model_progress.dart';
import 'package:flutter_todo_list/models/model_todo.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/services/db_todo.dart';
import 'package:flutter_todo_list/services/db_todo_category.dart';
import 'package:flutter_todo_list/shared/helpers/helper_services.dart';
import 'package:get/get.dart';

class TodoListController extends GetxController {
  static TodoListController ctrl = Get.put(TodoListController());

  List<ModelTodo> todoList = [];
  ModelTodo? selectToDo;

  ModelProgressTodo get progressCalculation {
    if (todoList.isEmpty) {
      return ModelProgressTodo(percentage: 0, displayString: '...');
    }

    int total = todoList.length;
    int completed = todoList.where((todo) => todo.isCompleted == true).length;
    double cal = completed / total;
    String disp = '$completed/$total';

    return ModelProgressTodo(percentage: cal, displayString: disp);
  }

  void onCheckTodo(ModelTodo todo) async {
    todo.isCompleted = !todo.isCompleted;
    update();

    await DBTodo.boxSave(todo);
  }

  void onRemoveTodo(ModelTodo todo, {required VoidCallback onComplete}) async {
    if (selectToDo == todo) {
      selectToDo = null;
    }

    await DBTodo.boxDeleteOne(todo);
    onComplete.call();
  }

  void onCompletedTodoCategory(ModelTodoCategory todoCategory,
      {required VoidCallback onComplete}) async {
    todoCategory.isCompleted = true;
    await DBTodoCategory.boxSave(todoCategory);
    onComplete.call();
  }

  void onGetTodoListByCategoryId(ModelTodoCategory selectedTodoCate) {
    todoList = DBTodo.boxGetObjectByKeyValue(
      key: 'todoCategoryId',
      value: selectedTodoCate.id,
    );
    update();
  }

  void onSelectTodo(ModelTodo todo) {
    selectToDo = todo;
    update();
  }

  void onAddTodo(
      {required String text,
      required ModelTodoCategory selectedTodoCate,
      required VoidCallback onComplete}) async {
    final todoForm = ModelTodo(
        id: HelperServices.uidiTimestamp(),
        title: text,
        todoCategoryId: selectedTodoCate.id,
        subtasks: [],
        tags: [],
        isPriority: false,
        timestamp: HelperServices.getTimestamp());

    await DBTodo.boxSave(todoForm);
    onGetTodoListByCategoryId(selectedTodoCate);
    onComplete.call();
  }
}
