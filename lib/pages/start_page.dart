import 'package:flutter/material.dart';
import 'package:flutter_todo_list/controllers/start_page_controller.dart';
import 'package:flutter_todo_list/pages/setting_page.dart';
import 'package:flutter_todo_list/shared/components/side_tab_widget.dart';
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
    return GetBuilder<StartPageController>(
        initState: (state) => ctrl.onViewDidLoad,
        builder: (builder) =>
            Scaffold(body: Row(children: [todoListTabCategory(), body()])));
  }

  Widget body() {
    return Flexible(child: SettingPage());
  }

  Widget todoListTabCategory() {
    List<Widget> list = [];

    for (final tab in ctrl.tabList) {
      list.add(Padding(
        padding: const EdgeInsets.only(bottom: 5),
        child: SideTabWidget(
            tab: tab,
            selectedId: ctrl.selectedTab,
            onSelect: (select) => ctrl.onSelectedTab(tab)),
      ));
    }

    return Container(
        width: 45,
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(children: list),
            const SizedBox()
            // SideTabWidget(tab: ),
          ],
        ));
  }
}
