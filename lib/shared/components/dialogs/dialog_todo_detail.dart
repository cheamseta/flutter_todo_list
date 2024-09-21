import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/controllers/todo_detail_controller.dart';
import 'package:flutter_todo_list/models/model_todo.dart';
import 'package:flutter_todo_list/shared/components/cells/cell_subtask.dart';
import 'package:flutter_todo_list/shared/components/cells/cell_text_container.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_button.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_textfield.dart';
import 'package:flutter_todo_list/shared/helpers/helper_services.dart';
import 'package:get/get.dart';

class DialogTodoDetail extends StatelessWidget {
  TodoDetailController ctrl = TodoDetailController.ctrl;
  TextEditingController newSubtaskCtrl = TextEditingController();
  final ModelTodo todo;

  DialogTodoDetail({super.key, required this.todo});

  void onInit() {
    ctrl.selectdTodo = todo;
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
                    const SizedBox(height: 20),
                    TDTextfield(title: 'Note', isMulti: true),
                    const SizedBox(height: 20),
                    TDText.body('Subtasks', isBold: true),
                    TDCellSubtask(
                        title: 'Task 1', onOptions: (p) {}, onCheck: () {}),
                    TDCellSubtask(
                        title: 'Task 2', onOptions: (p) {}, onCheck: () {}),
                    TDCellSubtask(
                        title: 'Task 3', onOptions: (p) {}, onCheck: () {}),
                    newSubtask(),
                    const SizedBox(height: 2000),
                    // remindListWidget(),
                    // addRemindList()
                  ]));
        });
  }

  Widget newSubtask() {
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
          newSubtaskCtrl.text = '';
        })
      ],
    );
  }

  Widget subheaderReminder() {
    List<Widget> list = [
      CellTextContainer(title: 'Reminder', icon: Icons.timelapse, onTap: () {}),
      const SizedBox(width: 5)
    ];

    // for (String tag in todoCtrl.selectedTodo!.tags) {
    //   list.add(InkWell(
    //       onTap: () => onAddRemindTag(),
    //       child: HelperContainer.containerPillText(tag,
    //           color: ColorTheme.COLOR_LIGHT_PINK,
    //           padd: EdgeInsets.only(top: 5))));

    //   list.add(SizedBox(width: 5));
    // }

    list.add(
      CellTextContainer(title: 'Add Tags', icon: Icons.tag, onTap: () {}),
    );

    list.add(const SizedBox(width: 5));

    return Wrap(children: list);
  }
}

// import 'package:ez_receipt/constants/key_const.dart';
// import 'package:ez_receipt/constants/key_icon.dart';
// import 'package:ez_receipt/controllers/offline_pos/offline_tod_controller.dart';
// import 'package:ez_receipt/models/todo_model.dart';
// import 'package:ez_receipt/services/local_notification_service.dart';
// import 'package:ez_receipt/shared/bweird_components/button_iconify_widget.dart';
// import 'package:ez_receipt/shared/bweird_components/text_button_iconify_widget.dart';
// import 'package:ez_receipt/shared/bweird_components/text_style.dart';
// import 'package:ez_receipt/shared/bweird_components/text_widget.dart';
// import 'package:ez_receipt/shared/bweird_components/textfield_widget.dart';
// import 'package:ez_receipt/shared/helper/helper_container.dart';
// import 'package:ez_receipt/shared/helper/helper_dialog.dart';
// import 'package:ez_receipt/shared/helper/helper_services.dart';
// import 'package:ez_receipt/shared/helper/helper_widget.dart';
// import 'package:ez_receipt/widgets/empty_widget.dart';
// import 'package:ez_receipt/widgets/theme.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconify_flutter/iconify_flutter.dart';
// import 'package:timezone/timezone.dart' as tz;
// // import 'package:timezone/data/latest_all.dart' as tz;

// class OfflineTodoDetailWidget extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _OfflineTodoDetailWidget();
//   }
// }

// class _OfflineTodoDetailWidget extends State<OfflineTodoDetailWidget> {
//   final todoCtrl = Get.put(OfflineTodoController());
//   final remindInputTxt = TextEditingController();
//   final noteTxt = TextEditingController();
//   final noteNode = FocusNode();

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<OfflineTodoController>(builder: (builder) {
//       if (todoCtrl.selectedTodo == null) {
//         return Center(child: EmptyWidget(title: ''));
//       }
//       noteTxt.text = todoCtrl.selectedTodo!.note;
//       return SingleChildScrollView(
//           padding: EdgeInsets.all(15),
//           child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 TextWidget.title(todoCtrl.selectedTodo!.title, isBold: true),
//                 SizedBox(height: 5),
//                 TextWidget.body(HelperServices.dateToday()),
//                 SizedBox(height: 10),
//                 subheaderReminder(),
//                 SizedBox(height: 20),
//                 TextWidget.body('Note'.toUpperCase(), isBold: true),
//                 Divider(),
//                 TextField(
//                   maxLines: null,
//                   style: TStyle.body(),
//                   controller: noteTxt,
//                   focusNode: noteNode,
//                   onTap: () {
//                     setState(() {});
//                   },
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintStyle: TStyle.body(color: ColorTheme.COLOR_GREY),
//                       hintText: "Write a note here ...."),
//                 ),
//                 if (noteNode.hasFocus)
//                   BWButton1(
//                     title: 'SAVE',
//                     icon: KeyIcon.SAVE,
//                     onTap: () {
//                       todoCtrl.selectedTodo!.note = noteTxt.text;
//                       todoCtrl.onSaveDetail();

//                       FocusManager.instance.primaryFocus?.unfocus();
//                     },
//                   ),
//                 SizedBox(height: 20),
//                 remindListWidget(),
//                 addRemindList()
//               ]));
//     });
//   }

//   Widget subheaderReminder() {
//     List<Widget> list = [];

//     list.add(InkWell(
//         onTap: () => onAddNotifyReminder(),
//         child: HelperContainer.containerPillText(
//             todoCtrl.selectedTodo!.reminderTimestamp != 0
//                 ? 'Reminder : ${HelperServices.convertToDateTimeByTimestamp(todoCtrl.selectedTodo!.reminderTimestamp, isOneLine: true)}'
//                 : 'Reminder',
//             icon: KeyIcon.CLOCK,
//             color: ColorTheme.COLOR_LIGHT_YELLOW,
//             padd: EdgeInsets.only(top: 5))));
//     list.add(SizedBox(width: 5));

//     for (String tag in todoCtrl.selectedTodo!.tags) {
//       list.add(InkWell(
//           onTap: () => onAddRemindTag(),
//           child: HelperContainer.containerPillText(tag,
//               color: ColorTheme.COLOR_LIGHT_PINK,
//               padd: EdgeInsets.only(top: 5))));

//       list.add(SizedBox(width: 5));
//     }

//     list.add(InkWell(
//         onTap: () => onAddRemindTag(),
//         child: HelperContainer.containerPillText('Add Tag',
//             icon: KeyIcon.ADD,
//             color: ColorTheme.COLOR_GREY,
//             padd: EdgeInsets.only(top: 5))));

//     list.add(SizedBox(width: 5));

//     list.add(InkWell(
//         onTap: () => onRemoveToDo(),
//         child: HelperContainer.containerPillText('Remove To-Do',
//             icon: KeyIcon.REMOVE,
//             textColor: ColorTheme.COLOR_LIGHT,
//             color: ColorTheme.COLOR_DANGER,
//             padd: EdgeInsets.only(top: 5))));

//     return Wrap(children: list);
//   }

//   void onRemoveToDo() {
//     HelperDialog.onConfirmDialog('Remove To-Do', isConfirmCallback: () {
//       todoCtrl.onRemoveToDo();
//       if (HelperServices.screenWidth() < KeyConst.LAYOUT_MAX) {
//         Get.back();
//       }
//     });
//   }

//   void onAddRemindTag() {
//     final tagTxt = TextEditingController();
//     HelperDialog.onConfirmContainerDialog(
//         'Add Tag',
//         BWTextfieldWidget(
//             title: 'Tag Name',
//             placeholder: 'Fill out tag',
//             controller: tagTxt), isConfirmCallback: () {
//       if (tagTxt.text.trim().isEmpty) {
//         HelperDialog.onErrorDialog('Please fill out tag name properly');
//         return;
//       }

//       todoCtrl.selectedTodo!.tags.add(tagTxt.text.trim());
//       todoCtrl.onSaveDetail();
//       todoCtrl.update();
//     });
//   }

//   void onAddNotifyReminder() async {
//     HelperWidget.widgetCalendar((datetime) async {
//       await LocalNotificationService()
//           .onCancelSchedule(todoCtrl.selectedTodo!.reminderTimestamp);

//       todoCtrl.selectedTodo!.reminderTimestamp =
//           HelperServices.getTimestamp(date: datetime);
//       todoCtrl.onSaveDetail();
//       todoCtrl.update();

//       final scheduledDate = tz.TZDateTime.from(datetime, tz.local);
//       await LocalNotificationService().onSchedultPushLocal(
//           todoCtrl.selectedTodo!.reminderTimestamp, scheduledDate);
//     }, isShowTimePicker: true);
//   }

//   Widget remindListWidget() {
//     List<Widget> list = [];

//     if (todoCtrl.selectedTodo!.remindList.isNotEmpty) {
//       list.add(TextWidget.body('Remind List'.toUpperCase(), isBold: true));
//       list.add(Divider());
//       list.add(SizedBox(height: 10));
//     }

//     for (RemindModel remind in todoCtrl.selectedTodo!.remindList) {
//       list.add(HelperContainer.containerRoundWidget(
//           ListTile(
//             contentPadding: EdgeInsets.zero,
//             leading: InkWell(
//                 onTap: () {
//                   remind.isCompleted = !remind.isCompleted;
//                   todoCtrl.onSaveDetail();
//                   todoCtrl.update();
//                 },
//                 child: remind.isCompleted
//                     ? Icon(Icons.check_box_outlined)
//                     : Icon(Icons.square_outlined)),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 remindTag(remind.tag),
//                 SizedBox(width: 10),
//                 remindListOption(remind),
//               ],
//             ),
//             title: TextWidget.body(remind.title,
//                 isCross: remind.isCompleted ? true : false),
//           ),
//           margin: EdgeInsets.only(bottom: 10)));
//     }

//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: list);
//   }

//   Widget addRemindList() {
//     return HelperContainer.containerRoundWidget(
//         Row(
//           children: [
//             Expanded(
//                 child: BWTextfieldWidget.textfield(
//               remindInputTxt,
//               "Add To List",
//             )),
//             BWTextButton1(
//               title: 'Add',
//               icon: KeyIcon.ADD,
//               onTap: () {
//                 RemindModel remind = RemindModel(
//                     title: remindInputTxt.text, tag: '', isCompleted: false);
//                 todoCtrl.selectedTodo!.remindList.add(remind);
//                 todoCtrl.onSaveDetail();
//                 todoCtrl.update();

//                 remindInputTxt.text = '';
//               },
//             ),
//           ],
//         ),
//         color: ColorTheme.COLOR_LIGHTER_GREY);
//   }

//   Widget remindTag(String tag) {
//     return tag == '' ? SizedBox() : HelperContainer.containerPillText(tag);
//   }

//   Widget remindListOption(RemindModel reminder) {
//     return HelperWidget.widgetPopupMenuButtonBuilder(
//         title: '',
//         child: Padding(
//           padding: const EdgeInsets.only(right: 10),
//           child: Iconify(KeyIcon.MENU, size: 26),
//         ),
//         listString: [
//           "Noted",
//           "Purchased",
//           "On Hold",
//           "✚ Write Tag",
//           "-",
//           "Clear Tag",
//           "Remove Reminder"
//         ],
//         onTap: (v) {
//           Get.back();
//           if (v == '✚ Write Tag') {
//             final tagTxt = TextEditingController();
//             HelperDialog.onConfirmContainerDialog("Write Tag",
//                 BWTextfieldWidget(title: 'Fill out tag', controller: tagTxt),
//                 isConfirmCallback: () {
//               reminder.tag = tagTxt.text;
//               todoCtrl.onSaveDetail();
//               todoCtrl.update();
//             });
//           } else if (v == 'Remove Reminder') {
//             todoCtrl.selectedTodo!.remindList.remove(reminder);
//           } else if (v == 'Clear Tag') {
//             reminder.tag = '';
//           } else {
//             reminder.tag = v;
//           }

//           todoCtrl.onSaveDetail();
//           todoCtrl.update();
//         });
//   }
// }
