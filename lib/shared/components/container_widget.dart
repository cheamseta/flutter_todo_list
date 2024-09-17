import 'package:flutter/material.dart';
import 'package:flutter_todo_list/shared/components/text_widget.dart';

class ContainerWidget extends StatelessWidget {
  final String title;
  final Widget body;
  String? subtitle;
  List<Widget>? actions;

  ContainerWidget({
    super.key,
    required this.title,
    required this.body,
    this.subtitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    Widget subtitleWidget = const SizedBox();

    if (subtitle != null) {
      subtitleWidget = TDText.body(subtitle!);
    }

    return SafeArea(
        child: Container(
            color: Theme.of(context).canvasColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TDText.header(title.toUpperCase(), isBold: true),
                      Row(children: actions ?? [])
                    ]),
                subtitleWidget,
                const Divider(),
                Expanded(child: body)
              ],
            )));
  }
}
