import 'package:flutter/material.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_dropdown.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';

class TDCellSubtask extends StatelessWidget {
  final String title;
  final Function() onCheck;
  final Function(String) onOptions;

  const TDCellSubtask({
    super.key,
    required this.title,
    required this.onOptions,
    required this.onCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 5, top: 5),
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: InkWell(
            onTap: onCheck,
            child: const Icon(Icons.check_box_outline_blank_rounded,
                size: 40, color: Colors.grey)),
        title: TDText.subtitle(title, isBold: true, maxLine: 2),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            WidgetDropdown(
                onTap: onOptions,
                title: '',
                iconData: Icons.more_vert_rounded,
                listString: const ['Remove'])
          ],
        ),
      ),
    );
  }
}
