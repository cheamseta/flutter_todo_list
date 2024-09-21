// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_todo_list/theme/text_style.dart';

class TDText extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  bool isBold;
  TextAlign align;
  bool isCross;
  int maxLine;
  TextOverflow? textOverflow;

  TDText({
    super.key,
    required this.text,
    required this.textStyle,
    this.isBold = false,
    this.align = TextAlign.center,
    this.isCross = false,
    this.textOverflow,
    this.maxLine = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: textOverflow,
      maxLines: maxLine,
      textAlign: align,
      style: textStyle,
    );
  }

  static Widget title(
    String text, {
    isBold = false,
    align = TextAlign.left,
    isCross = false,
    maxLine = 3,
    TextOverflow? textOverflow,
    Color? color,
  }) {
    return _BWTextTitleWidget(
        text: text,
        isBold: isBold,
        isCross: isCross,
        align: align,
        maxLine: maxLine,
        color: color,
        textOverflow: textOverflow);
  }

  static TDText header(
    String text, {
    isBold = false,
    align = TextAlign.left,
    isCross = false,
    maxLine = 3,
    Color? color,
  }) {
    final titleStyle =
        TDTextStyle.headline(isBold: isBold, isCross: isCross, color: color);
    return TDText(
      maxLine: maxLine,
      align: align,
      textStyle: titleStyle,
      text: text,
    );
  }

  static Widget body(
    String text, {
    bool isBold = false,
    int maxLine = 20,
    TextOverflow? textOverflow,
    align = TextAlign.left,
    isCross = false,
    Color? color,
  }) {
    return _BWTextBodyWidget(
        text: text,
        isBold: isBold,
        isCross: isCross,
        align: align,
        maxLine: maxLine,
        color: color,
        textOverflow: textOverflow);
  }

  static Widget subtitle(
    String text, {
    bool isBold = false,
    int maxLine = 1,
    align = TextAlign.left,
    isCross = false,
    Color? color,
    TextOverflow? textOverflow,
  }) {
    return _BWTextSubtitleWidget(
      maxLine: maxLine,
      align: align,
      isBold: isBold,
      isCross: isCross,
      text: text,
      color: color,
      textOverflow: textOverflow,
    );
  }

  static TDText caption(
    String text, {
    bool isBold = false,
    color = Colors.black,
    TextAlign align = TextAlign.center,
    isCross = false,
    int maxLine = 10,
  }) {
    final titleStyle =
        TDTextStyle.caption(isBold: isBold, isCross: isCross, color: color);
    return TDText(
      maxLine: maxLine,
      align: align,
      textStyle: titleStyle,
      text: text,
    );
  }

  static TDText tiny(
    String text, {
    bool isBold = false,
    color = Colors.black,
    TextAlign align = TextAlign.left,
    int maxLine = 2,
    bool isCross = false,
  }) {
    final titleStyle =
        TDTextStyle.tiny(isBold: isBold, isCross: isCross, color: color);
    return TDText(
      maxLine: maxLine,
      align: align,
      textStyle: titleStyle,
      text: text,
    );
  }

  static Text tinier(String text,
      {bool isBold = false,
      color = Colors.black,
      TextAlign align = TextAlign.left,
      bool isCross = false,
      int maxLine = 1}) {
    return Text(text,
        maxLines: maxLine,
        textAlign: align,
        style:
            TDTextStyle.tinier(isBold: isBold, color: color, isCross: isCross));
  }
}

class _BWTextTitleWidget extends StatelessWidget {
  final String text;
  bool isBold;
  TextAlign align;
  bool isCross;
  int maxLine;
  TextOverflow? textOverflow;
  Color? color;

  _BWTextTitleWidget({
    required this.text,
    this.isBold = false,
    this.align = TextAlign.left,
    this.isCross = false,
    this.textOverflow,
    this.maxLine = 3,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TDText(
      maxLine: maxLine,
      align: align,
      textStyle: TDTextStyle.title(
        isBold: isBold,
        isCross: isCross,
        color: color,
        context: context,
      ),
      text: text,
    );
  }
}

class _BWTextSubtitleWidget extends StatelessWidget {
  final String text;
  bool isBold;
  TextAlign align;
  bool isCross;
  int maxLine;
  TextOverflow? textOverflow;
  Color? color;

  _BWTextSubtitleWidget({
    required this.text,
    this.isBold = false,
    this.align = TextAlign.center,
    this.isCross = false,
    this.maxLine = 3,
    this.textOverflow,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TDText(
      maxLine: maxLine,
      align: align,
      textStyle: TDTextStyle.subtitle(
        isBold: isBold,
        isCross: isCross,
        color: color,
        context: context,
      ),
      text: text,
    );
  }
}

class _BWTextBodyWidget extends StatelessWidget {
  final String text;
  bool isBold;
  TextAlign align;
  bool isCross;
  int maxLine;
  TextOverflow? textOverflow;
  Color? color;

  _BWTextBodyWidget(
      {required this.text,
      this.isBold = false,
      this.align = TextAlign.center,
      this.isCross = false,
      this.textOverflow,
      this.maxLine = 3,
      this.color});

  @override
  Widget build(BuildContext context) {
    return TDText(
      maxLine: maxLine,
      align: align,
      textStyle: TDTextStyle.body(
        isBold: isBold,
        isCross: isCross,
        color: color,
        context: context,
      ),
      text: text,
    );
  }
}
