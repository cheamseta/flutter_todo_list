import 'package:flutter/material.dart';
import 'package:flutter_todo_list/controllers/home_page_controller.dart';
import 'package:flutter_todo_list/controllers/start_page_controller.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/shared/components/cells/cell_todo_category.dart';
import 'package:flutter_todo_list/shared/components/containers/container.dart';
import 'package:flutter_todo_list/shared/components/dialogs/dialog_todo_category_form.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_dropdown.dart';
import 'package:flutter_todo_list/shared/helpers/helper_services.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePageController ctrl = HomePageController.ctrl;
  StartPageController startCtrl = StartPageController.ctrl;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageController>(
        builder: (builder) => TDContainer(
              title: 'ToDo List',
              subtitle: 'Forget something important ? Add to do list',
              actions: [sideOptions()],
              child: body(),
            ));
  }

  Widget sideOptions() {
    return WidgetDropdown(
      title: '',
      listString: const ['Show Todo List', 'Show Completed List'],
      onTap: (option) {
        Get.back();
        switch (option) {
          case 'Show Complete':
            break;
          default:
        }
      },
    );
  }

  LayoutBuilder body() {
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      final crossCount =
          HelperServices.helperGridCrossCountBySize(constraints.maxWidth);
      return gridViewBody(crossCount);
    });
  }

  Widget gridViewBody(int crossCount) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: ctrl.todoCategoriesPending.length + 1,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: crossCount),
          itemBuilder: (builder, index) {
            if (index == ctrl.todoCategoriesPending.length) {
              return TDCellTodoCategory.addTodoCategoryCell(
                onTap: () => onCreateNewTodoCategory(),
              );
            }

            ModelTodoCategory todoCategory = ctrl.todoCategoriesPending[index];
            return TDCellTodoCategory(
                todoCategory: todoCategory,
                onTap: (todo) {
                  startCtrl.onSelectedTab(todo.id);
                });
          }),
    );
  }

  void onCreateNewTodoCategory() {
    Get.dialog(
      TDDialogTodoCategoryForm(onComplete: () {
        ctrl.onReload();
        startCtrl.onReload();
      }),
      useSafeArea: false,
    );
  }
}
