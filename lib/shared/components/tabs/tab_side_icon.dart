import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';

class TDTabSideIcon extends StatelessWidget {
  final IconData tabIcon;
  final Function(String) onSelect;
  final String theId;
  final String selectedId;
  final Alignment alignment;

  const TDTabSideIcon({
    super.key,
    required this.tabIcon,
    required this.onSelect,
    required this.theId,
    required this.alignment,
    required this.selectedId,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onSelect.call(selectedId),
        child: Container(
          constraints: const BoxConstraints(minHeight: 130),
          margin: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              color: selectedId == theId
                  ? Theme.of(context).canvasColor
                  : Colors.blueGrey,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(ConstValue.roundedRadius),
                  topLeft: Radius.circular(ConstValue.roundedRadius))),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          alignment: alignment,
          child: RotatedBox(quarterTurns: 3, child: Icon(tabIcon)),
        ));
  }
}
