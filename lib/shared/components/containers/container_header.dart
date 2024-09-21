import 'package:flutter/material.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';

class TDContainerHeader extends StatelessWidget {
  String title;
  String? subtitle;
  List<Widget> actions;

  TDContainerHeader({
    super.key,
    required this.title,
    required this.actions,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    Widget subtitleWidget = const SizedBox();

    if (subtitle != null) {
      subtitleWidget = TDText.body(subtitle!);
    }

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Flexible(
                child: TDText.header(title.toUpperCase(),
                    isBold: true, maxLine: 2)),
            Row(children: actions)
          ]),
          subtitleWidget,
          const Divider(),
        ]);
  }
}
