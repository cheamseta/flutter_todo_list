import 'package:flutter/material.dart';

class BWTextStyle {
  BWTextStyle._();

  static TextStyle body({
    required BuildContext context,
    Color? color,
    isBold = false,
    isCross = false,
  }) {
    double size = Theme.of(context).textTheme.bodySmall?.fontSize ?? 14;
    return textSyleInColorSize(color, size, isBold: isBold, isCross: isCross);
  }

  static TextStyle caption({
    Color? color,
    isBold = false,
    isCross = false,
  }) {
    return textSyleInColorSize(color, 12, isBold: isBold, isCross: isCross);
  }

  static TextStyle title({
    required BuildContext context,
    Color? color,
    isBold = false,
    isCross = false,
  }) {
    double size = Theme.of(context).textTheme.titleLarge?.fontSize ?? 20;
    return textSyleInColorSize(
      color,
      size,
      isBold: isBold,
      isCross: isCross,
    );
  }

  static TextStyle customized({
    Color? color,
    isBold = false,
    double size = 15,
  }) {
    return textSyleInColorSize(color, size, isBold: isBold);
  }

  static TextStyle headline({
    Color? color,
    isBold = false,
    isCross = false,
  }) {
    return textSyleInColorSize(color, 24, isBold: isBold, isCross: isCross);
  }

  static TextStyle subtitle({
    required BuildContext context,
    Color? color,
    isBold = false,
    isCross = false,
  }) {
    double size = Theme.of(context).textTheme.titleMedium?.fontSize ?? 18;
    return textSyleInColorSize(color, size, isBold: isBold, isCross: isCross);
  }

  static TextStyle tiny({
    Color? color,
    isBold = false,
    isCross = false,
  }) {
    return textSyleInColorSize(color, 10, isBold: isBold, isCross: isCross);
  }

  static TextStyle tinier({
    Color? color,
    isBold = false,
    isCross = false,
  }) {
    return textSyleInColorSize(color, 8, isBold: isBold, isCross: isCross);
  }

  static TextStyle textSyleInColorSize(
    Color? color,
    double fontSize, {
    bool isBold = false,
    bool isCross = false,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontWeight: isBold ? FontWeight.w800 : FontWeight.w400,
      fontSize: fontSize,
      decoration: isCross ? TextDecoration.lineThrough : null,
      letterSpacing: 0,
      height: 1.5,
      color: color,
    );
  }
}
