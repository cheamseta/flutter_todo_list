import 'package:flutter_todo_list/controllers/based_controller.dart';
import 'package:get/get.dart';

class HomePageController extends BasedController {
  static HomePageController ctrl = Get.put(HomePageController());

  void onReload() {
    onInitData();
    update();
  }
}
