import 'package:flutter/material.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';

class WidgetDropdown extends StatelessWidget {
  final String title;
  final List<String> listString;
  final Function(String) onTap;

  IconData? iconData;
  Widget? child;
  Color? color;
  Color? colorIcon;

  WidgetDropdown({
    super.key,
    this.iconData,
    this.child,
    this.color,
    this.colorIcon,
    required this.onTap,
    required this.title,
    required this.listString,
  });

  @override
  Widget build(BuildContext context) {
    List<PopupMenuEntry<Widget>> list = [];

    for (String string in listString) {
      if (string == '-') {
        list.add(const PopupMenuDivider());
      } else {
        list.add(PopupMenuItem<Widget>(
            child: Container(
          color: color,
          child: ListTile(
            key: key,
            onTap: () => onTap.call(string),
            title: TDText.subtitle(string),
          ),
        )));
      }
    }

    Widget withTitle = Material(
        color: color ?? Colors.transparent,
        child: Row(
          children: [
            TDText.body(title.toUpperCase(), isBold: true),
            const SizedBox(width: 10),
            Icon(iconData ?? Icons.menu, size: 26, color: colorIcon),
          ],
        ));

    return PopupMenuButton<Widget>(
      color: Theme.of(context).canvasColor,
      tooltip: title,
      itemBuilder: (BuildContext context) => list,
      child: child ?? withTitle,
    );
  }
}
