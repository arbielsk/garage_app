import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/widget/vehicle_route.dart';

import '../test_util/material_widget_wrapper.dart';

void main() {
  final _vehicle = Vehicle(
    displayName: "Zielpuls BMW 3",
    model: "BMW M2 CS 3",
    vin: "A1234B1234C1234D3",
  );
  final _vehicleScreen = VehicleRoute(_vehicle);
  final _vehicleScreenWrapper = MaterialWidgetWrapper(child: _vehicleScreen);

  Future<void> _initializeWidget(WidgetTester tester) async {
    await tester.pumpWidget(_vehicleScreenWrapper);
    await tester.pumpAndSettle();
  }

  group('AppBar Tests', () {
    testWidgets('Appbar exists', (WidgetTester tester) async {
      await _initializeWidget(tester);
      final appBar = find.byType(AppBar);
      expect(appBar, findsOneWidget);
    });

    testWidgets('Appbar color is bluegray', (WidgetTester tester) async {
      final color = Colors.blueGrey;
      await _initializeWidget(tester);
      final appBarfinder = find.byType(AppBar);
      final firstAppBar = tester.firstWidget<AppBar>(appBarfinder);
      expect(firstAppBar.backgroundColor, color);
    });
  });

  group('Column children tests', () {
    testWidgets('Column exists', (WidgetTester tester) async {
      await _initializeWidget(tester);
      final columnFinder = find.byType(Column).first;
      expect(columnFinder, findsOneWidget);
    });

    testWidgets('Column has only one Lisview child',
        (WidgetTester tester) async {
      await _initializeWidget(tester);
      final columnFinder = find.byType(Column).first;
      final listviewFinder =
          find.descendant(of: columnFinder, matching: find.byType(ListView));
      expect(listviewFinder, findsOneWidget);
    });

    testWidgets('ElevatedButton exists inside the Column',
        (WidgetTester tester) async {
      await _initializeWidget(tester);
      final columnFinder = find.byType(Column).first;
      final elevatedButtonFinder = find.descendant(
          of: columnFinder, matching: find.byType(ElevatedButton));
      expect(elevatedButtonFinder, findsOneWidget);
    });

    testWidgets('ElevatedButton is horizontally centered inside Column',
        (WidgetTester tester) async {
      await _initializeWidget(tester);
      final columnFinder = find.byType(Column).first;
      final firstColumn = tester.firstWidget<Column>(columnFinder);
      expect(firstColumn.crossAxisAlignment, CrossAxisAlignment.center);
    });

    testWidgets('Check ElevatedButton padding', (WidgetTester tester) async {
      await _initializeWidget(tester);
      final _padding = 8.0;
      final elevatedButtonFinder = find.byType(ElevatedButton);
      final descendantOfElevatedButton = find.descendant(
          of: elevatedButtonFinder, matching: find.byType(Text));
      final elevatedButton = tester.getSize(elevatedButtonFinder);
      final text = tester.getSize(descendantOfElevatedButton);
      expect(text.height, elevatedButton.height - 2 * _padding);
      expect(text.width, elevatedButton.width - 2 * _padding);
    });
  });
}
