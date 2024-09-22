import 'package:flutter/material.dart';
import 'package:flutter_todo_list/models/model_subtask.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_dropdown.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';

class TDCellSubtask extends StatelessWidget {
  final ModelSubtask subtask;
  final Function() onCheck;
  final Function(String) onOptions;

  const TDCellSubtask(
      {super.key,
      required this.subtask,
      required this.onOptions,
      required this.onCheck});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: InkWell(
            onTap: onCheck,
            child: Icon(
              subtask.isCompleted
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              size: 40,
              color: subtask.isCompleted ? Colors.green.shade800 : Colors.grey,
            )),
        title: TDText.subtitle(subtask.title, isBold: true, maxLine: 2),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetDropdown(
                onTap: onOptions,
                title: '',
                iconData: Icons.more_vert_rounded,
                listString: const ['Remove'])
          ],
        ),
      ),
    );
  }
}
