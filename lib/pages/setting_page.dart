import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/shared/components/container_widget.dart';
import 'package:flutter_todo_list/shared/components/text_widget.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      title: "Setting",
      subtitle: "Configure application ",
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: ConstValue.roundedRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              tile(title: "Change Color", trailing: const Icon(Icons.square)),
              const SizedBox(height: 10),
              tile(title: "Theme", trailing: const Icon(Icons.square)),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              tile(title: "Backup", trailing: const Icon(Icons.square)),
              const SizedBox(height: 10),
              tile(title: "Restore", trailing: const Icon(Icons.square)),
            ],
          )),
    );
  }

  Widget tile({required String title, required Widget trailing}) {
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
