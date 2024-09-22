import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';

class CellList extends StatelessWidget {
  final String title;
  final Widget trailing;

  CellList({
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.grey),
            borderRadius: BorderRadius.circular(ConstValue.roundedRadius)),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [TDText.body(title), trailing],
        ));
  }
}
