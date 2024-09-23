import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';

class TDTabSideText extends StatelessWidget {
  final ModelTodoCategory tab;
  final Function(ModelTodoCategory) onSelect;
  final String selectedId;

  const TDTabSideText({
    super.key,
    required this.tab,
    required this.onSelect,
    required this.selectedId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onSelect.call(tab),
        child: Container(
          constraints: const BoxConstraints(minHeight: 150),
          margin: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              color: selectedId == tab.id
                  ? Theme.of(context).canvasColor
                  : Color(int.parse('0xFF${tab.color}')),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(ConstValue.roundedRadius),
                  topLeft: Radius.circular(ConstValue.roundedRadius))),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: RotatedBox(
              quarterTurns: 3,
              child: TDText.subtitle(tab.title,
                  isBold: true,
                  color: selectedId == tab.id
                      ? Theme.of(context).textTheme.bodySmall!.color
                      : Colors.black)),
        ));
  }
}
