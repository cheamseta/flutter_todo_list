import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/controllers/based_controller.dart';
import 'package:get/get.dart';

class StartPageController extends BasedController {
  static StartPageController get ctrl => Get.put(StartPageController());
  String selectedTab = ConstValue.homeTabKey;

  void onReload() {
    onInitData();
    update();
  }

  void onSelectedTab(String id) {
    selectedTab = id;
    ctrl.update();
  }
}
