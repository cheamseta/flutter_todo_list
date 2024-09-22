import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/controllers/home_page_controller.dart';
import 'package:flutter_todo_list/controllers/start_page_controller.dart';
import 'package:flutter_todo_list/controllers/todo_page_controller.dart';
import 'package:flutter_todo_list/pages/todo/todo_detail.dart';
import 'package:flutter_todo_list/pages/todo/todo_list.dart';
import 'package:flutter_todo_list/shared/components/containers/container_split.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_dropdown.dart';
import 'package:get/get.dart';

class TodoPage extends StatelessWidget {
  final String todoID;
  TodoPageController ctrl = TodoPageController.ctrl;

  TodoPage({super.key, required this.todoID});

  void onViewDidLoad() {
    ctrl.onGetTodoCategoryById(todoID);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoPageController>(
        initState: (state) => onViewDidLoad(),
        builder: (builder) => TDContainerSplit(
              title: '${ctrl.selectedTodoCate.title} 😃',
              actions: [sideOptions()],
              subtitle: 'This is important, need to make sure done all',
              bodyLeftSide: leftWidget(),
              bodyRightSide: rightWidget(),
              isSmallShowLeftSideOnly: true,
            ));
  }

  Widget sideOptions() {
    return WidgetDropdown(
      title: 'Options',
      listString: const ['Remove'],
      onTap: (option) {
        Get.back();
        switch (option) {
          case 'Remove':
            ctrl.onRemoveTodoCategory(ctrl.selectedTodoCate,
                onComplete: () => onReloadApp());
            break;
          default:
        }
      },
    );
  }

  Widget rightWidget() {
    if (ctrl.selectToDo == null) {
      return const SizedBox();
    }

    return TodoDetail(
      key: Key(ctrl.selectToDo!.id),
      todo: ctrl.selectToDo!,
      selectedTodoCategory: ctrl.selectedTodoCate,
    );
  }

  Widget leftWidget() {
    return TodoList(
      onReload: onReloadApp,
      selectedTodoCate: ctrl.selectedTodoCate,
      onSelectTodo: (todo) {},
    );
  }

  void onReloadApp() {
    final startCtrl = StartPageController.ctrl;
    final homeCtrl = HomePageController.ctrl;

    startCtrl.onSelectedTab(ConstValue.homeTabKey);
    startCtrl.onReload();
    homeCtrl.onReload();
  }
}
