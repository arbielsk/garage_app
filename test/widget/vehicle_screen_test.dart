import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/widget/vehicle_route.dart';
import 'package:garage_app/widget/vehicle_screen.dart';

import '../test_util/material_widget_wrapper.dart';

void main() {
  final _vehicle = Vehicle(
    displayName: "Zielpuls BMW 3",
    model: "BMW M2 CS 3",
    vin: "A1234B1234C1234D3",
  );
  final vehicleScreenTitle = 'Vehicle';
  final appBarColor = Colors.blueGrey;
  final _vehicleScreen = MaterialWidgetWrapper(child: VehicleRoute(_vehicle));

  group('Vehicle Screen Tests', () {
    testWidgets('AppBar is existing', (WidgetTester tester) async {
      await tester.pumpWidget(_vehicleScreen);
      await tester.pumpAndSettle();
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('AppBar text', (WidgetTester tester) async {
      await tester.pumpWidget(_vehicleScreen);
      await tester.pumpAndSettle();
      final appBar = find.text(vehicleScreenTitle);
      expect(appBar, findsOneWidget);
    });

    testWidgets('AppBar color', (WidgetTester tester) async {
      await tester.pumpWidget(_vehicleScreen);
      await tester.pumpAndSettle();
      expect(tester.firstWidget<AppBar>(find.byType(AppBar)).backgroundColor,
          appBarColor);
    });

    testWidgets('Column is in widget tree ', (WidgetTester tester) async {
      await tester.pumpWidget(_vehicleScreen);
      await tester.pumpAndSettle();
      expect(find.byKey(VehicleScreen.columnKey), findsOneWidget);
    });

    testWidgets('ElevatedButton insidec Column ', (WidgetTester tester) async {
      await tester.pumpWidget(_vehicleScreen);
      await tester.pumpAndSettle();
      final column = find.byKey(VehicleScreen.columnKey);
      final elevatedButton =
          find.descendant(of: column, matching: find.byType(ElevatedButton));
      expect(elevatedButton, findsOneWidget);
    });

    testWidgets('ElevatedButton is centered horizontally',
        (WidgetTester tester) async {
      await tester.pumpWidget(_vehicleScreen);
      await tester.pumpAndSettle();
      final column = find.byKey(VehicleScreen.columnKey);
      final elevatedButton =
          find.descendant(of: column, matching: find.byType(ElevatedButton));
      final parentCenter = tester.getCenter(column);
      final elevatedButtonTopRight = tester.getTopRight(elevatedButton).dx;
      final elevatedButtonTopLeft = tester.getTopLeft(elevatedButton).dx;
      expect(elevatedButtonTopRight > parentCenter.dx, true);
      expect(elevatedButtonTopLeft < parentCenter.dx, true);
      expect(
          parentCenter.dx - elevatedButtonTopLeft ==
              elevatedButtonTopRight - parentCenter.dx,
          true);
    });
  });
}
