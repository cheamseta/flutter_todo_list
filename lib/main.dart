import 'package:flutter/material.dart';
import 'package:flutter_todo_list/app_init.dart';
import 'package:flutter_todo_list/pages/start_page.dart';
import 'package:flutter_todo_list/theme/app_theme.dart';
import 'package:get/get.dart';

AppTheme currentTheme = AppTheme();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInit.init();
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
      theme: lightTheme(),
      darkTheme: darkTheme(),
      themeMode: currentTheme.currentTheme(),
      home: const StartPage(),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: currentTheme.currentColor(),
        ),
        useMaterial3: true);
  }

  ThemeData darkTheme() {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: currentTheme.currentColor(),
          brightness: Brightness.dark,
        ),
        useMaterial3: true);
  }
}
