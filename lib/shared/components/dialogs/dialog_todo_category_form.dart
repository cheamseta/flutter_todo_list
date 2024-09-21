import 'package:flutter/material.dart';
import 'package:flutter_todo_list/controllers/todo_category_form_controller.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/shared/components/containers/container_dialog.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_button.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_textfield.dart';
import 'package:flutter_todo_list/shared/helpers/helper_services.dart';
import 'package:get/get.dart';

class TDDialogTodoCategoryForm extends StatelessWidget {
  TodoCategoryFormController ctrl = TodoCategoryFormController.ctrl;

  final TextEditingController titleTECtrl = TextEditingController();
  final VoidCallback onComplete;

  ModelTodoCategory? todoForm;

  TDDialogTodoCategoryForm(
      {super.key, required this.onComplete, this.todoForm});

  void onViewDidLoad() {
    todoForm ??= ModelTodoCategory(
      id: HelperServices.uidiTimestamp(),
      isCompleted: false,
      title: '',
      color: HelperServices.getRandomInt(0, HelperServices.colorList().length),
      timestamp: HelperServices.getTimestamp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoCategoryFormController>(
        initState: (state) => onViewDidLoad(),
        builder: (builder) => TDContainerDialog(
            title: todoForm == null ? 'Create New Todo' : 'Modify Todo',
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TDTextfield(title: 'Title', controller: titleTECtrl),
                const SizedBox(height: 10),
                TDText.subtitle('Choose Color'),
                colorWidget(),
                const SizedBox(height: 10),
                TDButton('Insert',
                    isFull: true, isBold: true, onTap: () => onSave())
              ],
            ))));
  }

  void onSave() {
    if (todoForm == null) {
      return;
    }

    todoForm!.title = titleTECtrl.text;

    ctrl.onSaveTodoCategory(
      todoForm!,
      onComplete: () {
        Get.back();
        onComplete.call();
      },
      onError: () {},
    );
  }

  Widget colorWidget() {
    List<Widget> list = [];

    for (String color in HelperServices.colorList()) {
      list.add(InkWell(
          onTap: () {
            todoForm!.color = color;
            ctrl.update();
          },
          child: Container(
              margin: const EdgeInsets.all(5),
              decoration: todoForm!.color == color
                  ? BoxDecoration(
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(50))
                  : null,
              child: Icon(Icons.circle,
                  color: HelperServices.serviceColorFromHex(color),
                  size: 50))));
    }
    return Wrap(children: list);
  }
}
