import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/models/model_todo.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_dropdown.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';

class TDCellTodo extends StatelessWidget {
  final ModelTodo todo;
  final int priorityLevel;
  final ModelTodo? selected;
  final Function() onTap;
  final Function() onCheck;
  final Function(String) onOptions;

  const TDCellTodo({
    super.key,
    required this.todo,
    required this.onTap,
    required this.priorityLevel,
    required this.selected,
    required this.onOptions,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: selected?.id == todo.id
              ? BorderRadius.circular(ConstValue.roundedRadius)
              : null,
          color: selected?.id == todo.id
              ? const Color.fromARGB(255, 245, 222, 230)
              : null,
          border: Border(
              bottom: BorderSide(width: 1, color: Colors.grey.shade400))),
      child: ListTile(
        onTap: () => onTap.call(),
        leading: InkWell(
            onTap: onCheck,
            child: Icon(
              todo.isCompleted
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              size: 40,
              color: todo.isCompleted ? Colors.green.shade800 : Colors.grey,
            )),
        title: TDText.subtitle(todo.title, isBold: true, maxLine: 2),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.circle, size: 10, color: Colors.redAccent),
            WidgetDropdown(
                onTap: onOptions,
                title: '',
                iconData: Icons.more_vert_rounded,
                listString: ['Detail', 'Remove'])
          ],
        ),
      ),
    );
  }
}
