// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';

enum TDBtnSizeEnum { small, regular, large }

enum TDBtnTypeEnum { primary, secondary, danger, teritary }

class TDButton extends StatelessWidget {
  final String title;
  IconData? iconData;
  Widget? lead;
  Color? textColor;
  VoidCallback? onTap;
  Color? backgroundColor;
  Color? splashColor;
  BoxDecoration? decoration;
  bool? isFull;
  bool isBold;
  double? iconSize;
  TDBtnSizeEnum? buttonSize;
  TDBtnTypeEnum? buttonType;
  TDButton(
    this.title, {
    super.key,
    this.iconData,
    this.backgroundColor,
    this.lead,
    this.textColor,
    this.decoration,
    this.onTap,
    this.isBold = false,
    this.isFull = false,
    this.buttonSize = TDBtnSizeEnum.regular,
    this.buttonType = TDBtnTypeEnum.primary,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    if (buttonType == TDBtnTypeEnum.primary) {
      backgroundColor ??= Theme.of(context).colorScheme.primary;
      splashColor ??= Theme.of(context).colorScheme.primary.withOpacity(0.5);
      textColor ??= Theme.of(context).colorScheme.onPrimary;
    } else if (buttonType == TDBtnTypeEnum.secondary) {
      backgroundColor ??= Theme.of(context).colorScheme.secondary;
      splashColor ??= Theme.of(context).colorScheme.secondary.withOpacity(0.5);
      textColor ??= Theme.of(context).colorScheme.onPrimary;
    } else if (buttonType == TDBtnTypeEnum.danger) {
      backgroundColor ??= Colors.redAccent;
      splashColor ??= Colors.redAccent.withOpacity(0.5);
      textColor ??= Colors.white;
    } else if (buttonType == TDBtnTypeEnum.teritary) {
      backgroundColor ??= Theme.of(context).colorScheme.tertiary;
      splashColor ??= Theme.of(context).colorScheme.tertiary.withOpacity(0.5);
      textColor ??= Theme.of(context).colorScheme.onPrimary;
    }

    decoration ??= BoxDecoration(
        color: backgroundColor, borderRadius: BorderRadius.circular(15));

    if (onTap == null) {
      decoration = BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
      );

      textColor = Colors.grey.shade400;
    }

    Widget text = TDText.body(
      title,
      color: textColor,
      isBold: isBold,
      align: TextAlign.center,
    );

    if (buttonSize == TDBtnSizeEnum.small) {
      text = TDText.caption(
        title,
        color: textColor,
        isBold: isBold,
        align: TextAlign.center,
      );
    }

    if (buttonSize == TDBtnSizeEnum.large) {
      text = TDText.header(
        title,
        color: textColor,
        isBold: isBold,
        align: TextAlign.center,
      );
    }

    Widget child = text;

    if (title.trim().isEmpty) {
      child = Icon(iconData, color: textColor, size: iconSize);
    }

    if (iconData != null && title.trim().isNotEmpty) {
      child = Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(iconData, color: textColor, size: iconSize),
            ),
            text,
          ]);
    }

    return InkWell(
        splashColor: splashColor,
        borderRadius: BorderRadius.circular(15.0),
        onTap: onTap,
        child: Container(
          width: isFull == true ? double.maxFinite : null,
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            right: 20,
            left: 20,
          ),
          decoration: decoration,
          child: child,
        ));
  }

  static Widget outline(
    title, {
    VoidCallback? onTap,
    Color? backgroundColor,
    bool? isFull,
    IconData? icon,
    double? iconSize,
    TDBtnSizeEnum? buttonSize,
  }) {
    return _BWButtonOutline(title,
        backgroundColor: backgroundColor,
        textColor: backgroundColor,
        isFull: isFull,
        icon: icon,
        iconSize: iconSize,
        buttonSize: buttonSize,
        onTap: onTap);
  }

  static Widget text(
    title, {
    required VoidCallback onTap,
    bool? isFull,
    IconData? icon,
    double? iconSize,
    bool isBold = false,
    TDBtnSizeEnum? buttonSize,
  }) {
    return _BWButtonText(
      title,
      isFull: isFull,
      onTap: onTap,
      icon: icon,
      isBold: isBold,
      iconSize: iconSize,
      buttonSize: buttonSize,
    );
  }

  static Widget icon(
    IconData iconData, {
    required VoidCallback onTap,
    Color? iconColor,
    double? iconSize,
  }) {
    return _BWButtonIcon(iconData,
        onTap: onTap, iconColor: iconColor, iconSize: iconSize);
  }
}

class _BWButtonOutline extends StatelessWidget {
  final String title;
  IconData? icon;
  Widget? lead;
  Color? textColor;
  VoidCallback? onTap;
  Color? backgroundColor;
  bool? isFull;
  double? iconSize;
  TDBtnSizeEnum? buttonSize;

  _BWButtonOutline(this.title,
      {this.backgroundColor,
      this.textColor,
      this.onTap,
      this.icon,
      this.iconSize,
      this.isFull,
      this.buttonSize});

  @override
  Widget build(BuildContext context) {
    backgroundColor ??= Theme.of(context).colorScheme.primary;

    BoxDecoration boxDecore = BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1, color: backgroundColor ?? Colors.black),
        borderRadius: BorderRadius.circular(15));

    return TDButton(title,
        decoration: boxDecore,
        backgroundColor: backgroundColor,
        iconData: icon,
        lead: lead,
        textColor: backgroundColor,
        onTap: onTap,
        iconSize: iconSize,
        isFull: isFull,
        buttonSize: buttonSize);
  }
}

class _BWButtonText extends StatelessWidget {
  final String title;
  IconData? icon;
  Widget? lead;
  Color? textColor;
  VoidCallback? onTap;
  bool? isFull;
  bool isBold;
  double? iconSize;
  TDBtnSizeEnum? buttonSize;

  _BWButtonText(this.title,
      {this.onTap,
      this.icon,
      this.iconSize,
      this.isBold = false,
      this.isFull,
      this.buttonSize});

  @override
  Widget build(BuildContext context) {
    textColor ??= Theme.of(context).colorScheme.primary;
    BoxDecoration boxDecore = const BoxDecoration(color: Colors.transparent);

    return TDButton(title,
        decoration: boxDecore,
        backgroundColor: Colors.transparent,
        iconData: icon,
        lead: lead,
        textColor: textColor,
        onTap: onTap,
        iconSize: iconSize,
        isBold: isBold,
        isFull: isFull,
        buttonSize: buttonSize);
  }
}

class _BWButtonIcon extends StatelessWidget {
  final IconData icon;
  Color? iconColor;
  VoidCallback? onTap;
  double? iconSize;

  _BWButtonIcon(
    this.icon, {
    this.onTap,
    this.iconColor,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    iconColor ??= Theme.of(context).colorScheme.primary;
    return IconButton(
        onPressed: onTap, icon: Icon(icon, color: iconColor, size: iconSize));
  }
}
