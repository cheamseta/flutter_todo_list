import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
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
  late ModelTodoCategory todoForm;

  TDDialogTodoCategoryForm({super.key, required this.onComplete});

  void onViewDidLoad() {
    todoForm = ModelTodoCategory(
      id: HelperServices.uidiTimestamp(),
      isCompleted: false,
      title: '',
      emoji: '🥰',
      color: HelperServices.getRandomInt(0, HelperServices.colorList().length),
      timestamp: HelperServices.getTimestamp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoCategoryFormController>(
        initState: (state) => onViewDidLoad(),
        builder: (builder) => TDContainerDialog(
            title: 'Create New Todo',
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TDTextfield(title: 'Title', controller: titleTECtrl),
                const SizedBox(height: 20),
                TDText.subtitle('Choose Emjoi'),
                const SizedBox(height: 10),
                emojiList(),
                const SizedBox(height: 20),
                TDText.subtitle('Choose Color'),
                const SizedBox(height: 10),
                colorWidget(),
                const SizedBox(height: 10),
                TDButton('Insert',
                    isFull: true, isBold: true, onTap: () => onSave())
              ],
            ))));
  }

  Widget emojiList() {
    List<String> emojis = ConstValue.emojiList.split(' ');

    List<Widget> list = [];

    for (var emo in emojis) {
      list.add(InkWell(
          onTap: () {
            todoForm.emoji = emo;
            ctrl.update();
          },
          child: Container(
            margin: const EdgeInsets.only(right: 5),
            decoration: BoxDecoration(
                color: todoForm.emoji == emo ? Colors.grey : Colors.white,
                borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TDText.header(emo, maxLine: 1),
          )));
    }

    return SingleChildScrollView(
        scrollDirection: Axis.horizontal, child: Row(children: list));
  }

  void onSave() {
    if (titleTECtrl.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter text before continue',
      );
      return;
    }

    todoForm.title = titleTECtrl.text;

    ctrl.onSaveTodoCategory(
      todoForm,
      onComplete: () {
        Get.back();
        onComplete.call();
      },
      onError: () {
        Get.snackbar(
          'Error',
          'Please try again',
        );
      },
    );
  }

  Widget colorWidget() {
    List<Widget> list = [];

    for (String color in HelperServices.colorList()) {
      list.add(InkWell(
          onTap: () {
            todoForm.color = color;
            ctrl.update();
          },
          child: Container(
              margin: const EdgeInsets.all(5),
              decoration: todoForm.color == color
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
