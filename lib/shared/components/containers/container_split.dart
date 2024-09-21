import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/shared/components/containers/container_header.dart';

class TDContainerSplit extends StatelessWidget {
  final String title;
  final Widget bodyLeftSide;
  Widget? bodyRightSide;
  String? subtitle;
  List<Widget>? actions;
  bool isSmallShowLeftSideOnly;

  TDContainerSplit(
      {super.key,
      required this.title,
      required this.bodyLeftSide,
      this.bodyRightSide,
      this.subtitle,
      this.actions,
      this.isSmallShowLeftSideOnly = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Container(
            color: Theme.of(context).canvasColor,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TDContainerHeader(
                    title: title, subtitle: subtitle, actions: actions ?? []),
                Expanded(child: body())
              ],
            )));
  }

  LayoutBuilder body() {
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      if (constraints.maxWidth > ConstValue.responsiveMid) {
        return landscape();
      } else {
        if (isSmallShowLeftSideOnly) {
          return bodyLeftSide;
        }

        return portrait();
      }
    });
  }

  Widget portrait() {
    return Column(children: [bodyLeftSide, bodyRightSide ?? const SizedBox()]);
  }

  Widget landscape() {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flexible(flex: 1, child: bodyLeftSide),
          const VerticalDivider(),
          Flexible(flex: 1, child: bodyRightSide ?? const SizedBox())
        ]);
  }
}
