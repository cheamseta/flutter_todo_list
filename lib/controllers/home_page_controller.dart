import 'package:flutter_todo_list/controllers/based_controller.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:get/get.dart';

class HomePageController extends BasedController {
  static HomePageController ctrl = Get.put(HomePageController());
  late List<ModelTodoCategory> selectedTodoListCategories;

  void onSelectPending() {
    selectedTodoListCategories = ctrl.todoCategoriesPending;
    update();
  }

  void onSelectCompleted() {
    selectedTodoListCategories = ctrl.todoCategoriesCompleted;
    update();
  }

  void onReload() {
    onInitData();
    onSelectPending();
    update();
  }
}
