import 'package:flutter/material.dart';
import 'package:flutter_todo_list/pages/start_page.dart';
import 'package:flutter_todo_list/theme/app_theme.dart';
import 'package:get/get.dart';

AppTheme currentTheme = AppTheme();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter ToDo List',
      theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: currentTheme.currentColor()),
          useMaterial3: true),
      darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: currentTheme.currentColor(),
            brightness: Brightness.dark,
          ),
          useMaterial3: true),
      themeMode: currentTheme.currentTheme(),
      home: const StartPage(),
    );
  }
}
