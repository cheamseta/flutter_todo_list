import 'package:get/get.dart';

class StartPageController extends GetxController {
  static StartPageController get ctrl => Get.put(StartPageController());

  String selectedTab = "";

  List<Map> tabList = [
    {
      "id": "39383883",
      "title": "Todo List",
      "color": "00000",
    },
    {
      "id": "343434",
      "title": "Shopping",
      "color": "00000",
    },
    {
      "id": "575556",
      "title": "Important",
      "color": "00000",
    }
  ];

  void onViewDidLoad() {
    selectedTab = ctrl.tabList.first['id'];
  }

  void onSelectedTab(Map tab) {
    selectedTab = tab['id'];
    ctrl.update();
  }

  @override
  void onReady() {
    onViewDidLoad();
    super.onReady();
  }
}
