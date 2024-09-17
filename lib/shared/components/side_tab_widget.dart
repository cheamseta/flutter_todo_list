import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/shared/components/text_widget.dart';

class SideTabWidget extends StatelessWidget {
  final Map tab;
  final Function(Map) onSelect;
  final String selectedId;

  const SideTabWidget({
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
              color: selectedId == tab['id']
                  ? Theme.of(context).canvasColor
                  : Color(0xFFFF9000),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(ConstValue.roundedRadius),
                  topLeft: Radius.circular(ConstValue.roundedRadius))),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: RotatedBox(
              quarterTurns: 3,
              child: TDText.subtitle(tab['title'], isBold: true)),
        ));
  }
}
