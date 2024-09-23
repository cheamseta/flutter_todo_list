import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/main.dart';
import 'package:flutter_todo_list/shared/components/cells/cell_list.dart';
import 'package:flutter_todo_list/shared/components/containers/container_split.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_dropdown.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';
import 'package:get/get.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

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
              CellList(title: 'Change Color', trailing: colorChangeDropdown()),
              const SizedBox(height: 10),
              CellList(title: 'Theme', trailing: themeChangeDropdown()),
              const SizedBox(height: 10),
            ],
          )),
    );
  }

  Widget colorChangeDropdown() {
    return WidgetDropdown(
      title: '',
      listString: const ['Green', 'Blue', 'Pink', 'Red'],
      onTap: (e) {
        Get.back();
        switch (e) {
          case 'Green':
            currentTheme.onChangeColor(Colors.greenAccent);
            break;
          case 'Blue':
            currentTheme.onChangeColor(Colors.blueAccent);
            break;
          case 'Pink':
            currentTheme.onChangeColor(Colors.pinkAccent);
            break;
          case 'Red':
            currentTheme.onChangeColor(Colors.redAccent);
            break;
          default:
        }
      },
    );
  }

  Widget themeChangeDropdown() {
    return WidgetDropdown(
      title: '',
      listString: const ['Dark', 'Light'],
      onTap: (e) {
        Get.back();
        switch (e) {
          case 'Dark':
            currentTheme.onSwitch();
            break;
          case 'Light':
            currentTheme.onSwitch();
            break;
          default:
        }
      },
    );
  }
}
