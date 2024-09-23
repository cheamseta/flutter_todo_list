import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';

class WidgetEmpty extends StatelessWidget {
  final String title;

  const WidgetEmpty({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/leaf.png', width: 200, height: 200),
              const SizedBox(height: 5),
              TDText.subtitle(title, align: TextAlign.center, maxLine: 3),
            ],
          )),
    );
  }
}
