import 'package:flutter_todo_list/models/model_todo.dart';
import 'package:get/get.dart';

class TodoDetailController extends GetxController {
  static TodoDetailController ctrl = Get.put(TodoDetailController());
  late ModelTodo selectdTodo;
}
