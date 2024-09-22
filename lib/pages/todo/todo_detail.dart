import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/controllers/todo_detail_controller.dart';
import 'package:flutter_todo_list/models/model_subtask.dart';
import 'package:flutter_todo_list/models/model_todo.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/shared/components/cells/cell_subtask.dart';
import 'package:flutter_todo_list/shared/components/cells/cell_text_container.dart';
import 'package:flutter_todo_list/shared/components/dialogs/dialog_prompt.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_button.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_empty.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_textfield.dart';
import 'package:flutter_todo_list/shared/helpers/helper_services.dart';
import 'package:get/get.dart';

class TodoDetail extends StatelessWidget {
  final ModelTodo todo;
  final ModelTodoCategory selectedTodoCategory;

  TextEditingController descTxtCtrl = TextEditingController();
  TextEditingController newSubtaskCtrl = TextEditingController();
  TodoDetailController ctrl = TodoDetailController.ctrl;

  bool isEditNote = false;

  TodoDetail({
    super.key,
    required this.todo,
    required this.selectedTodoCategory,
  });

  void onInit() {
    ctrl.selectdTodo = todo;
    descTxtCtrl.text = todo.subtitle;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoDetailController>(
        initState: (state) => onInit(),
        builder: (builder) {
          return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: ConstValue.offset),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TDText.title(ctrl.selectdTodo.title, isBold: true),
                    const SizedBox(height: 5),
                    TDText.body(HelperServices.dateToday()),
                    const SizedBox(height: 10),
                    subheaderReminder(),
                    const SizedBox(height: 30),
                    note(),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    subtaskList(),
                    newSubtask(),
                    const SizedBox(height: 20),
                  ]));
        });
  }

  Widget note() {
    if (isEditNote == false) {
      return GestureDetector(
          onTap: () {
            isEditNote = !isEditNote;
            ctrl.update();
          },
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Icon(
              Icons.edit,
              size: 15,
            ),
            const SizedBox(width: 10),
            Flexible(
                child: TDText.body(
                    todo.subtitle == ''
                        ? 'There is no description'
                        : todo.subtitle,
                    maxLine: 20))
          ]));
    }

    return Column(
      children: [
        TDTextfield(
          title: 'Description',
          isMulti: true,
          controller: descTxtCtrl,
        ),
        const SizedBox(height: 10),
        TDButton('Save',
            isFull: true,
            onTap: () => ctrl.onSaveSubtitl(
                  todo: todo,
                  text: descTxtCtrl.text,
                  onComplete: () {
                    isEditNote = false;
                    ctrl.update();
                  },
                ))
      ],
    );
  }

  Widget subtaskList() {
    if (ctrl.selectdTodo.subtasks.isEmpty) {
      return WidgetEmpty(title: 'Add subtasks for more useful');
    }

    List<Widget> list = [
      TDText.body('Subtasks', isBold: true),
      const SizedBox(height: 10)
    ];

    for (var task in ctrl.selectdTodo.subtasks) {
      list.add(TDCellSubtask(
        subtask: task,
        onOptions: (p) {
          Get.back();
          switch (p) {
            case 'Remove':
              ctrl.onRemoveSubtask(
                subtask: task,
                todo: todo,
              );
              break;
            default:
          }
        },
        onCheck: () => ctrl.onCheckSubtask(
          subtask: task,
          todo: todo,
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget newSubtask() {
    if (selectedTodoCategory.isCompleted) {
      return const SizedBox();
    }

    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(ConstValue.roundedRadius)),
            child: TDTextfield.textfield(
              newSubtaskCtrl,
              'Add Subtask',
              isMultiLine: true,
            )),
        const SizedBox(height: 10),
        TDButton('Add Subtask', isFull: true, iconData: Icons.add, onTap: () {
          final subtask = ModelSubtask(
            id: HelperServices.uidiTimestamp(),
            title: newSubtaskCtrl.text,
            isCompleted: false,
          );
          ctrl.onAddSubtask(
              subtask: subtask,
              onComplete: () {
                newSubtaskCtrl.text = '';
              });
        })
      ],
    );
  }

  Widget subheaderReminder() {
    List<Widget> list = [
      CellTextContainer(
          title: 'Reminder',
          padd: const EdgeInsets.only(right: 5, bottom: 5),
          icon: Icons.timelapse,
          onTap: () {}),
      const SizedBox(width: 5)
    ];

    for (String tag in todo.tags) {
      list.add(InkWell(
        onTap: () {},
        child: CellTextContainer(
            title: tag,
            icon: Icons.tag,
            padd: const EdgeInsets.only(right: 5, bottom: 5),
            onTap: () {
              ctrl.onRemoveTags(
                tag: tag,
                todo: todo,
              );
            }),
      ));
    }

    list.add(
      CellTextContainer(
          title: 'Add Tags',
          icon: Icons.tag,
          onTap: () {
            DialogPrompt.onShow(
                title: 'Add New Tags',
                onCallback: (tag) {
                  ctrl.onSaveTags(
                    tag: tag,
                    todo: todo,
                  );
                });
          }),
    );

    list.add(const SizedBox(width: 5));

    return Wrap(children: list);
  }
}
