import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/controllers/start_page_controller.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/pages/home_page.dart';
import 'package:flutter_todo_list/pages/setting_page.dart';
import 'package:flutter_todo_list/pages/todo_list/todo_list_page.dart';
import 'package:flutter_todo_list/shared/components/tabs/tab_side_icon.dart';
import 'package:flutter_todo_list/shared/components/tabs/tab_side_text.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _StartPageState();
  }
}

class _StartPageState extends State<StartPage> {
  StartPageController ctrl = StartPageController.ctrl;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StartPageController>(builder: (builder) => scaffold());
  }

  Widget scaffold() {
    return Scaffold(
      body: Row(children: [
        todoListTabCategory(),
        body(),
      ]),
    );
  }

  Widget body() {
    switch (ctrl.selectedTab) {
      case 'home':
        return Flexible(child: HomePage());
      case 'setting':
        return Flexible(child: SettingPage());
      default:
        return Flexible(
            child: TodoListPage(
          key: Key(ctrl.selectedTab),
          todoID: ctrl.selectedTab,
        ));
    }
  }

  Widget todoListTabCategory() {
    List<Widget> list = [];

    list.add(Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: TDTabSideIcon(
          tabIcon: Icons.home,
          selectedId: ctrl.selectedTab,
          theId: ConstValue.homeTabKey,
          alignment: Alignment.bottomCenter,
          onSelect: (index) => ctrl.onSelectedTab(ConstValue.homeTabKey),
        )));

    for (final tab in ctrl.todoCategoriesPending) {
      list.add(tabCell(tab));
    }

    return Container(
        width: 45,
        color: Colors.grey.shade500,
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: Column(children: list),
            )),
            TDTabSideIcon(
              tabIcon: Icons.settings,
              selectedId: ctrl.selectedTab,
              theId: ConstValue.settingTabKey,
              alignment: Alignment.topCenter,
              onSelect: (index) => ctrl.onSelectedTab(ConstValue.settingTabKey),
            ),
          ],
        ));
  }

  Widget tabCell(ModelTodoCategory tab) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: TDTabSideText(
          tab: tab,
          selectedId: ctrl.selectedTab,
          onSelect: (select) => ctrl.onSelectedTab(tab.id)),
    );
  }
}
