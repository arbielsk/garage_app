import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/model/enum/ignition_status.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/enum/motor_status.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';
import 'package:garage_app/widget/vehicle_screen.dart';
import 'package:garage_app/widget/vehicle_state_list_item.dart';

import 'util/material_widget_wrapper.dart';

void main() {
  final _vehicle = Vehicle(
    displayName: "Zielpuls BMW 3",
    model: "BMW M2 CS 3",
    vin: "A1234B1234C1234D3",
  );
  final _vehicleState = VehicleState(
    engineStatus: EngineStatus.ON,
    ignitionStatus: IgnitionStatus.ON,
    lockStatus: LockStatus.OPEN,
  );

  final _vehicleScreen = VehicleScreen(
    vehicle: _vehicle,
    vehicleState: _vehicleState,
  );
  final _vehicleListItem = VehicleListItem(vehicle: _vehicle);
  final _vehicleStateListItem =
      VehicleStateListItem(stateVal: _vehicleState.engineStatus.toString());
  final _wrappedVehicleScreen = MaterialWidgetWrapper(
    child: _vehicleScreen,
  );

  group('AppBar', () {
    testWidgets('exist', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();
      final appbar = find.byType(AppBar);
      expect(appbar, findsOneWidget);
    });
    testWidgets('has correct title', (WidgetTester tester) async {
      final expectedAppBarTitle = "Vehicle";
      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();
      final appBar = tester.firstWidget<AppBar>(find.byType(AppBar));
      final appBarTitle = (appBar.title as Text).data;
      expect(appBarTitle, expectedAppBarTitle);
    });
    testWidgets('title is centered', (WidgetTester tester) async {
      final _expectedCenteredTitle = true;

      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();

      final appBar = find.byType(AppBar);

      final appBarTitle = tester.firstWidget<AppBar>(appBar).centerTitle;

      expect(appBarTitle, _expectedCenteredTitle);
    });
    testWidgets('backgroundColor is Colors.blueGrey[50]',
        (WidgetTester tester) async {
      final _expectedBackgroundColor = Colors.blueGrey[50];

      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();

      final appBar = find.byType(AppBar);

      final appBarBackgroundColor =
          tester.firstWidget<AppBar>(appBar).backgroundColor;

      expect(appBarBackgroundColor, _expectedBackgroundColor);
    });
  });

  group('Body', () {
    testWidgets('VehicleListItem is first', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();

      final column = find.byType(Column);

      final findChildrens = find
          .descendant(of: column, matching: find.byType(Widget))
          .allCandidates
          .first
          .widget;

      expect(findChildrens.runtimeType, _vehicleListItem.runtimeType);
    });
    testWidgets('ListView is second', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();
      final column = tester.firstWidget<Column>(find.byType(Column));
      final secondChild = column.children[1];
      final listView = (secondChild as Expanded).child;
      expect(listView.runtimeType, ListView);
    });

    testWidgets('contains VehicleStateListItem', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();

      final listView = find.byType(ListView);
      final findChildren = find.descendant(
          of: listView,
          matching: find.byType(VehicleStateListItem, skipOffstage: false));
      print(findChildren.toString());
      expect(findChildren, findsOneWidget);
    });
  });
}
