import 'dart:math';
import 'dart:ui';
import 'package:intl/intl.dart' as dd;
import 'package:flutter_todo_list/constant/const.dart';
import 'package:intl/intl.dart';

class HelperServices {
  static int helperGridCrossCountBySize(double maxWidth) {
    int crossCount = 2;
    if (maxWidth > ConstValue.responsiveMax) {
      crossCount = 7;
    } else if (maxWidth < ConstValue.responsiveMax &&
        maxWidth > ConstValue.responsiveMid) {
      crossCount = 5;
    } else if (maxWidth < ConstValue.responsiveMid &&
        maxWidth > ConstValue.responsiveLow) {
      crossCount = 3;
    }
    return crossCount;
  }

  static String convertToDateTimeByTimestamp(int timeStamp,
      {isOneLine = false}) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat(isOneLine ? 'dd/MM/yyyy' : 'dd/MM/yyyy')
        .format(dateToTimeStamp);
  }

  static String dateToday() {
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return dd.DateFormat('dd-MM-yyyy').format(date);
  }

  static Color serviceColorFromHex(String hexString) {
    return Color(int.parse('0xFF$hexString'));
  }

  static int getTimestamp({DateTime? date}) {
    if (date == null) {
      return DateTime.now().millisecondsSinceEpoch ~/ 1000;
    } else {
      return date.millisecondsSinceEpoch ~/ 1000;
    }
  }

  static String uidiTimestamp() {
    String timestampString =
        DateTime.now().millisecondsSinceEpoch.round().toString();
    return timestampString.substring(
        timestampString.length - 9, timestampString.length);
  }

  static String getRandomInt(int min, int max) {
    final random = Random();
    final sum = min + random.nextInt(max - min + 1);
    return sum.toString();
  }

  static List<String> colorList() {
    return [
      'f5c297',
      'f7e2bc',
      'f7d4bc',
      'f7debc',
      'f7e6bc',
      'f2f7bc',
      'def7bc',
      'c3f7bc',
      'b9f7bc',
      'aff7bc',
      'a0f7bc',
      '6ef7bc',
      '6ef7d5',
      'b3f5e2',
      'b3f4f5',
      'b3def5',
      'b3d0f5',
      'b3bff5',
      'b6b3f5',
      'c8b3f5',
      'deb3f5',
      'eeb3f5',
      'f5b3ed',
      'f5b3ec',
      'f5b3d7',
    ];
  }
}
