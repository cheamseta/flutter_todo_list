import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/models/model_subtask.dart';
import 'package:flutter_todo_list/models/model_todo.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/services/db_todo.dart';
import 'package:flutter_todo_list/services/db_todo_category.dart';
import 'package:flutter_todo_list/shared/helpers/helper_services.dart';
import 'package:hive/hive.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final todoCate = ModelTodoCategory(
      id: HelperServices.uidiTimestamp(),
      title: 'test title',
      color: 'fffff',
      emoji: '',
      timestamp: HelperServices.getTimestamp(),
      isCompleted: false);

  final todo = ModelTodo(
      id: HelperServices.uidiTimestamp(),
      title: 'task 1',
      todoCategoryId: todoCate.id,
      timestamp: HelperServices.getTimestamp(),
      subtasks: [],
      isPriority: false,
      isCompleted: false,
      tags: []);

  Future<void> setupDB() async {
    final tempDirectory = await Directory.systemTemp.createTemp();
    Hive.init(tempDirectory.path);
    await Hive.openBox(ConstValue.toDoCategoryBoxKey);
    await Hive.openBox(ConstValue.toDoBoxKey);
  }

  group('Test Configuration', () {
    test('Round Radius', () {
      expect(ConstValue.roundedRadius, 15);
    });

    test('Padding', () {
      expect(ConstValue.offset, 15);
    });
  });

  group('Database Initialization', () {
    test('Key Verification', () {
      expect(ConstValue.toDoCategoryBoxKey, 'toDoCategoryBoxKey');
      expect(ConstValue.toDoBoxKey, 'ToDoBoxKey');
    });
  });

  group('TodoCate Model', () {
    test('Key Verification', () {
      expect(todoCate.title, todoCate.toMap()['title']);
      expect(todoCate.id, todoCate.toMap()['id']);
      expect(todoCate.color, todoCate.toMap()['color']);
      expect(todoCate.emoji, todoCate.toMap()['emoji']);
      expect(todoCate.timestamp, todoCate.toMap()['timestamp']);
      expect(todoCate.isCompleted, todoCate.toMap()['isCompleted']);
    });

    test('Type Verification', () {
      expect(todoCate.title.runtimeType, String);
      expect(todoCate.id.runtimeType, String);
      expect(todoCate.color.runtimeType, String);
      expect(todoCate.emoji.runtimeType, String);
      expect(todoCate.timestamp.runtimeType, int);
      expect(todoCate.isCompleted.runtimeType, bool);
    });
  });

  group('Todo Model', () {
    test('Key Verification', () {
      expect(todo.title, todo.toMap()['title']);
      expect(todo.id, todo.toMap()['id']);
      expect(todo.todoCategoryId, todo.toMap()['todoCategoryId']);
      expect(todo.subtasks, todo.toMap()['subtasks']);
      expect(todo.timestamp, todo.toMap()['timestamp']);
      expect(todo.isCompleted, todo.toMap()['isCompleted']);
      expect(todo.isPriority, todo.toMap()['isPriority']);
      expect(todo.tags, todo.toMap()['tags']);
    });

    test('Type Verification', () {
      expect(todo.title.runtimeType, String);
      expect(todo.id.runtimeType, String);
      expect(todo.subtasks.runtimeType, List<ModelSubtask>);
      expect(todo.isPriority.runtimeType, bool);
      expect(todo.timestamp.runtimeType, int);
      expect(todo.isCompleted.runtimeType, bool);
    });
  });

  group('DB TodoCategory', () {
    test('insert', () async {
      await setupDB();
      await DBTodoCategory.boxSave(todoCate);
      final result = DBTodoCategory.boxGetAll(isCompleted: false);
      expect(result.length, 1);
    });

    test('edit', () async {
      await setupDB();
      todoCate.title = 'new edit test';
      await DBTodoCategory.boxSave(todoCate);
      final result = DBTodoCategory.boxGetAll(isCompleted: false);
      expect(result.length, 1);
      expect(result.first['title'], 'new edit test');
    });

    test('remove', () async {
      await setupDB();
      await DBTodoCategory.boxDeleteOne(todoCate);
      final result = DBTodoCategory.boxGetAll(isCompleted: false);
      expect(result.length, 0);
    });
  });

  group('DB Todo', () {
    test('insert', () async {
      await setupDB();
      await DBTodo.boxSave(todo);
      final result = DBTodo.boxGetAll();
      expect(result.length, 1);
    });

    test('edit', () async {
      await setupDB();
      todo.title = 'new edit test';
      await DBTodo.boxSave(todo);
      final result = DBTodo.boxGetAll();
      expect(result.length, 1);
      expect(result.first['title'], 'new edit test');
    });

    test('remove', () async {
      await setupDB();
      await DBTodo.boxDeleteOne(todo);
      final result = DBTodo.boxGetAll();
      expect(result.length, 0);
    });
  });
}
