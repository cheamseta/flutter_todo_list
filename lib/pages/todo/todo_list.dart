import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/controllers/home_page_controller.dart';
import 'package:flutter_todo_list/controllers/start_page_controller.dart';
import 'package:flutter_todo_list/controllers/todo_list_controller.dart';
import 'package:flutter_todo_list/models/model_todo.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/pages/todo/todo_detail.dart';
import 'package:flutter_todo_list/shared/components/cells/cell_todo.dart';
import 'package:flutter_todo_list/shared/components/containers/container_dialog.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_button.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_empty.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_textfield.dart';
import 'package:get/get.dart';

class TodoList extends StatelessWidget {
  TodoListController ctrl = TodoListController.ctrl;
  TextEditingController newTodoTxtCtrl = TextEditingController();

  final VoidCallback onReload;
  final Function(ModelTodo) onSelectTodo;
  final ModelTodoCategory selectedTodoCate;

  TodoList({
    super.key,
    required this.onReload,
    required this.onSelectTodo,
    required this.selectedTodoCate,
  });

  void onViewDidLoad() {
    ctrl.onGetTodoListByCategoryId(selectedTodoCate);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoListController>(
        initState: (state) => onViewDidLoad(),
        builder: (builder) {
          List<Widget> list = [];
          list.add(graph());

          if (ctrl.todoList.isEmpty) {
            list.add(const WidgetEmpty(
              title: 'There is no todo list\nAdd One to start your day',
            ));
          }

          for (final todo in ctrl.todoList) {
            list.add(TDCellTodo(
              todo: todo,
              priorityLevel: 2,
              selected: ctrl.selectToDo,
              onCheck: () => ctrl.onCheckTodo(todo),
              onTap: () => onDetail(todo, context),
              onOptions: (option) {
                Get.back();
                switch (option) {
                  case 'Detail':
                    onDetail(todo, context);
                    break;
                  case 'Remove':
                    ctrl.onRemoveTodo(todo, onComplete: () {
                      ctrl.onGetTodoListByCategoryId(selectedTodoCate);
                    });
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
        });
  }

  void onDetail(ModelTodo todo, BuildContext context) {
    if (MediaQuery.of(context).size.width > ConstValue.responsiveMax) {
      ctrl.onSelectTodo(todo);
    } else {
      Get.dialog(
          TDContainerDialog(
            title: '',
            child: TodoDetail(
              todo: todo,
              selectedTodoCategory: selectedTodoCate,
            ),
          ),
          useSafeArea: false);
    }
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
    if (selectedTodoCate.isCompleted) {
      return const SizedBox();
    }

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
        TDButton('Add',
            isFull: true,
            isBold: true,
            iconData: Icons.add,
            onTap: () => ctrl.onAddTodo(
                text: newTodoTxtCtrl.text,
                selectedTodoCate: selectedTodoCate,
                onComplete: () {
                  newTodoTxtCtrl.text = '';
                }))
      ],
    );
  }

  Widget completeButton() {
    if (selectedTodoCate.isCompleted) {
      return const SizedBox();
    }

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
        ctrl.onCompletedTodoCategory(
          selectedTodoCate,
          onComplete: () => onReloadApp(),
        );
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
