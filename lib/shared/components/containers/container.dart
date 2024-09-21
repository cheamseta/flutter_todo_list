import 'package:flutter/material.dart';
import 'package:flutter_todo_list/shared/components/containers/container_header.dart';

class TDContainer extends StatelessWidget {
  final String title;
  final Widget child;

  String? subtitle;
  List<Widget>? actions;

  TDContainer({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Container(
            color: Theme.of(context).canvasColor,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TDContainerHeader(
                  title: title,
                  subtitle: subtitle,
                  actions: actions ?? [],
                ),
                Expanded(child: child)
              ],
            )));
  }
}
