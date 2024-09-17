import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todo_list/constant/const.dart';

Future<void> main() async {
  group('Test Configuration', () {
    test('Round Radius', () {
      expect(ConstValue.roundedRadius, 15);
    });

    test('Padding', () {
      expect(ConstValue.bodyVeritclaPadding, 20);
    });
  });
}
