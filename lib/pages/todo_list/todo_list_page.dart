import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/controllers/home_page_controller.dart';
import 'package:flutter_todo_list/controllers/start_page_controller.dart';
import 'package:flutter_todo_list/controllers/todo_list_page_controller.dart';
import 'package:flutter_todo_list/models/model_todo.dart';
import 'package:flutter_todo_list/shared/components/dialogs/dialog_todo_detail.dart';
import 'package:flutter_todo_list/shared/components/containers/container_dialog.dart';
import 'package:flutter_todo_list/shared/components/containers/container_split.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_button.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_dropdown.dart';
import 'package:flutter_todo_list/shared/components/cells/cell_todo.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_empty.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_textfield.dart';
import 'package:flutter_todo_list/shared/helpers/helper_services.dart';
import 'package:get/get.dart';

class TodoListPage extends StatelessWidget {
  TodoListPageController ctrl = TodoListPageController.ctrl;
  TextEditingController newTodoTxtCtrl = TextEditingController();
  final String todoID;

  TodoListPage({super.key, required this.todoID});

  void onViewDidLoad() {
    ctrl.onGetTodoCategoryById(todoID);
    ctrl.onGetTodoListByCategoryId();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoListPageController>(
        initState: (state) => onViewDidLoad(),
        builder: (builder) {
          return TDContainerSplit(
            title: '${ctrl.selectedTodoCate.title} 😃',
            actions: [sideOptions()],
            subtitle: 'This is important, need to make sure done all',
            bodyLeftSide: leftWidget(),
            bodyRightSide: rightWidget(),
            isSmallShowLeftSideOnly: true,
          );
        });
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

    return DialogTodoDetail(
        key: Key(ctrl.selectToDo!.id), todo: ctrl.selectToDo!);
  }

  Widget leftWidget() {
    List<Widget> list = [];
    list.add(graph());

    if (ctrl.todoList.isEmpty) {
      list.add(WidgetEmpty(
          title: 'There is no todo list\nAdd One to start your day'));
    }

    for (final todo in ctrl.todoList) {
      list.add(TDCellTodo(
        todo: todo,
        priorityLevel: 2,
        selected: ctrl.selectToDo,
        onCheck: () => ctrl.onCheckTodo(todo),
        onTap: () {
          ctrl.onSelectTodo(todo);
          Get.dialog(TDContainerDialog(
            title: '',
            child: DialogTodoDetail(todo: todo),
          ));
        },
        onOptions: (option) {
          Get.back();
          switch (option) {
            case 'Remove':
              ctrl.onRemoveTodo(todo);
              break;
            default:
          }
        },
      ));
    }

    list.add(newTodo());
    list.add(completeButton());

    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: ConstValue.offset),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: list,
        ));
  }

  Widget graph() {
    return Container(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerRight,
              child: TDText.subtitle(
                  ctrl.progressCalculation.percentage == 1
                      ? '🥳🎉 ${ctrl.progressCalculation.displayString}'
                      : ctrl.progressCalculation.displayString,
                  isBold: true,
                  align: TextAlign.right,
                  color: ctrl.progressCalculation.percentage == 1
                      ? const Color.fromARGB(255, 62, 154, 65)
                      : Colors.black)),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: LinearProgressIndicator(
                  minHeight: 10,
                  value: ctrl.progressCalculation.percentage,
                  color: ctrl.progressCalculation.percentage == 1
                      ? const Color.fromARGB(255, 62, 154, 65)
                      : Colors.black,
                  backgroundColor: Colors.grey.shade200,
                )),
          ),
        ],
      ),
    );
  }

  Widget newTodo() {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(ConstValue.roundedRadius)),
            child: TDTextfield.textfield(
              newTodoTxtCtrl,
              'Add New Todo List',
              isMultiLine: true,
            )),
        const SizedBox(height: 10),
        TDButton('Add', isFull: true, isBold: true, iconData: Icons.add,
            onTap: () {
          final todoForm = ModelTodo(
              id: HelperServices.uidiTimestamp(),
              title: newTodoTxtCtrl.text,
              todoCategoryId: ctrl.selectedTodoCate!.id,
              timestamp: HelperServices.getTimestamp());
          ctrl.onAddTodo(todoForm);
          newTodoTxtCtrl.text = '';
        })
      ],
    );
  }

  Widget completeButton() {
    if (ctrl.progressCalculation.percentage != 1) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: TDButton('Complete This',
          backgroundColor: Colors.green,
          isFull: true,
          isBold: true,
          iconData: Icons.check, onTap: () {
        ctrl.onCompletedTodoCategory(ctrl.selectedTodoCate,
            onComplete: () => onReloadApp());
      }),
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
