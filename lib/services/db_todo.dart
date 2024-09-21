import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/models/model_todo.dart';
import 'package:hive/hive.dart';

class DBTodo {
  static Box boxTodo = Hive.box(ConstValue.toDoBoxKey);

  static String boxKey(ModelTodo todo) {
    return todo.id;
  }

  static int boxTotal() {
    return boxTodo.values.length;
  }

  static List boxGetAll({int? skip, int? limit}) {
    if (skip == null && limit == null) {
      return boxTodo.values.toList();
    }

    try {
      final list = boxTodo.values.skip(skip ?? 0).take(limit ?? 0).toList();
      return list;
    } catch (e) {
      return [];
    }
  }

  static List? boxGetByKeyValue({required String key, required String value}) {
    try {
      final list = boxTodo.values.where((e) {
        if (e[key] == null) {
          return false;
        }

        return e[key] == value;
      });
      return list.toList();
    } catch (e) {
      return null;
    }
  }

  static dynamic boxGetById({required String id}) {
    try {
      final list = boxTodo.values.where((e) {
        if (e['id'] == null) {
          return false;
        }

        return e['id'] == id;
      });
      return list.isNotEmpty ? list.first : null;
    } catch (e) {
      return null;
    }
  }

  static ModelTodo? boxGetObjectById({required String id}) {
    final todo = boxGetById(id: id);
    if (todo == null) {
      return null;
    }
    return ModelTodo.fromJson(todo);
  }

  static List<ModelTodo> boxGetAllObject({int? skip, int? limit}) {
    final list = boxGetAll(skip: skip, limit: limit);
    return list.map((e) => ModelTodo.fromJson(e)).toList();
  }

  static List<ModelTodo> boxGetObjectByKeyValue({
    required String key,
    required String value,
  }) {
    final list = boxGetByKeyValue(key: key, value: value);

    if (list == null) {
      return [];
    }

    return list.map((e) => ModelTodo.fromJson(e)).toList();
  }

  static Future<void> removeAll() {
    return boxTodo.deleteAll(boxTodo.keys);
  }

  static Future<void> boxSave(ModelTodo todo) async {
    return await boxTodo.put(
      boxKey(todo),
      todo.toMap(),
    );
  }

  static Future<void> boxDeleteOne(ModelTodo todo) async {
    return await boxTodo.delete(todo.id);
  }

  static Future<void> boxDeleteOneAtIndex(int index) async {
    return await boxTodo.deleteAt(index);
  }
}
