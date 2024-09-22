import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/shared/components/cells/cell_list.dart';
import 'package:flutter_todo_list/shared/components/containers/container_split.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TDContainerSplit(
      title: 'Setting',
      subtitle: 'Configure application ',
      bodyLeftSide: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: ConstValue.roundedRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CellList(
                  title: 'Change Color', trailing: const Icon(Icons.square)),
              const SizedBox(height: 10),
              CellList(title: 'Theme', trailing: const Icon(Icons.square)),
              const SizedBox(height: 10),
            ],
          )),
    );
  }
}
