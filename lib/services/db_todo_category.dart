import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:hive/hive.dart';

class DBTodoCategory {
  static Box boxTodoCategory = Hive.box(ConstValue.toDoCategoryBoxKey);

  static String boxKey(ModelTodoCategory todoCategory) {
    return todoCategory.id;
  }

  static int boxTotal() {
    return boxTodoCategory.values.length;
  }

  static List boxGetAll({
    int? skip,
    int? limit,
    required bool isCompleted,
  }) {
    if (skip == null && limit == null) {
      return boxTodoCategory.values.where((todo) {
        if (todo['isCompleted'] == null) {
          return false;
        }

        return todo['isCompleted'] == isCompleted;
      }).toList();
    }

    try {
      final list = boxTodoCategory.values
          .where((todo) {
            if (todo['isCompleted'] == null) {
              return false;
            }

            return todo['isCompleted'] == isCompleted;
          })
          .skip(skip ?? 0)
          .take(limit ?? 0)
          .toList();
      return list;
    } catch (e) {
      return [];
    }
  }

  static dynamic boxGetByKeyValue(
      {required String key, required String value}) {
    try {
      final list = boxTodoCategory.values.where((e) {
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
      final list = boxTodoCategory.values.where((e) {
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

  static ModelTodoCategory? boxGetObjectById({required String id}) {
    final todo = boxGetById(id: id);
    if (todo == null) {
      return null;
    }
    return ModelTodoCategory.fromJson(todo);
  }

  static List<ModelTodoCategory> boxGetObjectByKeyValue(
      {required String key, required String value}) {
    final list = boxGetByKeyValue(key: key, value: value);
    return list.map((e) => ModelTodoCategory.fromJson(e)).toList();
  }

  static List<ModelTodoCategory> boxGetAllObject({
    int? skip,
    int? limit,
    required bool isCompleted,
  }) {
    final list = boxGetAll(skip: skip, limit: limit, isCompleted: isCompleted);
    return list.map((e) => ModelTodoCategory.fromJson(e)).toList();
  }

  static Future<void> removeAll() {
    return boxTodoCategory.deleteAll(boxTodoCategory.keys);
  }

  static Future<void> boxSave(ModelTodoCategory todoCategory) async {
    return await boxTodoCategory.put(
      boxKey(todoCategory),
      todoCategory.toMap(),
    );
  }

  static Future<void> boxDeleteOne(ModelTodoCategory todoCategory) async {
    return await boxTodoCategory.delete(todoCategory.id);
  }

  static Future<void> boxDeleteOneAtIndex(int index) async {
    return await boxTodoCategory.deleteAt(index);
  }
}
