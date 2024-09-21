import 'package:flutter/material.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';

class CellTextContainer extends StatelessWidget {
  final String title;
  Color? color;
  Color? textColor;
  IconData? icon;
  EdgeInsetsGeometry? innerPadd;
  VoidCallback? onTap;

  bool isLarge;
  EdgeInsetsGeometry padd;

  CellTextContainer(
      {super.key,
      required this.title,
      this.padd = EdgeInsets.zero,
      this.isLarge = false,
      this.icon,
      this.textColor,
      this.color,
      this.onTap,
      this.innerPadd});

  @override
  Widget build(BuildContext context) {
    Widget child = TDText.caption(title, isBold: true, align: TextAlign.left);

    if (isLarge) {
      child = TDText.subtitle(title, isBold: true, align: TextAlign.left);
    }

    if (icon != null) {
      child = Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon,
            size: 20,
            color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color),
        const SizedBox(width: 5),
        child
      ]);
    }

    return InkWell(
        onTap: onTap,
        child: Padding(
            padding: padd,
            child: Material(
                borderRadius: BorderRadius.circular(8),
                color: color ?? Theme.of(context).colorScheme.onPrimary,
                child: Padding(
                  padding: innerPadd ??
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
                  child: child,
                ))));
  }
}
