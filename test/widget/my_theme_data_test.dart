import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_util/material_widget_wrapper.dart';

void main() {
  final _widget = MaterialWidgetWrapper(child: Container());

  group('Color tests', () {
    testWidgets('Test ThemeData primarySwatch is Colors.blue',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final primaryColor = tester
          .firstWidget<MaterialApp>(find.byType(MaterialApp))
          .theme!
          .primaryColor;
      expect(primaryColor, Colors.blue);
    });

    testWidgets('Test AppBar color', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final appBarColor = tester
          .firstWidget<MaterialApp>(find.byType(MaterialApp))
          .theme!
          .appBarTheme
          .backgroundColor;
      expect(appBarColor, Colors.blueGrey);
    });
  });
}
