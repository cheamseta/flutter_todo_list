import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';
import 'package:get/get.dart';

class TDContainerDialog extends StatelessWidget {
  final String title;
  final Widget child;

  const TDContainerDialog({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        body: SafeArea(
            bottom: false,
            child: Center(
                child: Container(
              width: 350,
              padding: EdgeInsets.all(ConstValue.offset),
              decoration: BoxDecoration(
                  color: Theme.of(context).canvasColor,
                  borderRadius:
                      BorderRadius.circular(ConstValue.roundedRadius)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TDText.header(title, isBold: true),
                        IconButton(
                            onPressed: () => Get.back(),
                            icon: const Icon(Icons.close))
                      ]),
                  Flexible(child: child)
                ],
              ),
            ))));
  }
}
