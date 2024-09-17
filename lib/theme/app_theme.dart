import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  static bool _isDark = true;
  static Color _color = Colors.deepPurple;

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Color currentColor() {
    return _color;
  }

  void onSwitch() {
    _isDark = !_isDark;
    notifyListeners();
  }

  void onChangeColor(Color newColor) {
    _color = newColor;
    notifyListeners();
  }
}
