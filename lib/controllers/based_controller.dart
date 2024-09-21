import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/services/db_todo_category.dart';
import 'package:get/get.dart';

class BasedController extends GetxController {
  static BasedController ctrl = Get.put(BasedController());

  List<ModelTodoCategory> todoCategoriesPending = [];
  List<ModelTodoCategory> todoCategoriesCompleted = [];

  void onInitData() {
    todoCategoriesPending = DBTodoCategory.boxGetAllObject(isCompleted: false);
    todoCategoriesCompleted = DBTodoCategory.boxGetAllObject(isCompleted: true);
  }

  @override
  void onInit() {
    onInitData();
    super.onInit();
  }
}
