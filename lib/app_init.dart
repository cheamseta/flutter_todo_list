import 'package:flutter_todo_list/constant/const.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class AppInit {
  static Future<bool> init() async {
    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      Hive.init(appDocDir.path);

      await Hive.openBox(ConstValue.toDoCategoryBoxKey);
      await Hive.openBox(ConstValue.toDoBoxKey);

      return true;
    } catch (e) {
      return false;
    }
  }
}
