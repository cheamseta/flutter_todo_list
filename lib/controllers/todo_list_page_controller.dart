import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/model_progress.dart';
import 'package:flutter_todo_list/models/model_todo.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/services/db_todo.dart';
import 'package:flutter_todo_list/services/db_todo_category.dart';
import 'package:get/get.dart';

class TodoListPageController extends GetxController {
  static TodoListPageController ctrl = Get.put(TodoListPageController());

  ModelTodo? selectToDo;
  late ModelTodoCategory selectedTodoCate;

  List<ModelTodo> todoList = [];

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

  void onGetTodoListByCategoryId() {
    todoList = DBTodo.boxGetObjectByKeyValue(
      key: 'todoCategoryId',
      value: selectedTodoCate.id,
    );
  }

  void onGetTodoCategoryById(String id) {
    final result = DBTodoCategory.boxGetObjectById(id: id);

    if (result == null) {
      return;
    }

    selectedTodoCate = result;
  }

  void onRemoveTodoCategory(ModelTodoCategory todoCate,
      {required VoidCallback onComplete}) async {
    await DBTodoCategory.boxDeleteOne(todoCate);
    onComplete.call();
  }

  void onCheckTodo(ModelTodo todo) async {
    todo.isCompleted = !todo.isCompleted;
    update();

    await DBTodo.boxSave(todo);
  }

  void onSelectTodo(ModelTodo todo) {
    selectToDo = todo;
    update();
  }

  void onRemoveTodo(ModelTodo todo) async {
    if (selectToDo == todo) {
      selectToDo = null;
    }

    await DBTodo.boxDeleteOne(todo);
    onGetTodoListByCategoryId();
    update();
  }

  void onCompletedTodoCategory(ModelTodoCategory todoCategory,
      {required VoidCallback onComplete}) async {
    todoCategory.isCompleted = true;
    await DBTodoCategory.boxSave(todoCategory);
    onComplete.call();
  }

  void onAddTodo(ModelTodo todo) async {
    await DBTodo.boxSave(todo);
    onGetTodoListByCategoryId();
    update();
  }
}
