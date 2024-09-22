import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_button.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_textfield.dart';
import 'package:get/get.dart';

class DialogPrompt extends StatelessWidget {
  final String title;
  final Function(String) onCallback;

  TextEditingController ctrl = TextEditingController();

  DialogPrompt({required this.title, required this.onCallback});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        body: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ConstValue.roundedRadius)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TDTextfield(title: title, controller: ctrl),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: TDButton.outline('Cancel', onTap: () {
                    Get.back();
                  })),
                  const SizedBox(width: 10),
                  Expanded(
                      child: TDButton('confirm', onTap: () {
                    if (ctrl.text.trim().isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please enter text before continue',
                      );
                      return;
                    }

                    Get.back();
                    onCallback.call(ctrl.text);
                  })),
                ],
              )
            ],
          ),
        ));
  }

  static void onShow(
      {required String title, required Function(String) onCallback}) {
    Get.dialog(DialogPrompt(title: title, onCallback: onCallback));
  }
}
