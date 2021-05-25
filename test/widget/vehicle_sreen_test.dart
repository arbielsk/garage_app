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

import '../test_util/material_widget_wrapper.dart';



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
    vehicleState: _vehicleState,
    vehicle: _vehicle,
  );
  final _wrappedVehicleScreen = MaterialWidgetWrapper(
    child: _vehicleScreen,
  );
  group('Vehicle Screen', () {
    testWidgets('can instantiate with vehicle', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();
    });
  });
  group('AppBar', () {
    testWidgets('is present', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();
      expect(
        find.byType(AppBar),
        findsOneWidget,
      );
    });
    testWidgets('title is "Vehicle"', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();
      final findAppBar = tester.firstWidget<AppBar>(find.byType(AppBar));
      expect(
        (findAppBar.title as Text).data,
        'Vehicle',
      );
    });

    testWidgets('backgrounColor is Colors.blueGrey', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();
      final findAppBar = tester.firstWidget<AppBar>(find.byType(AppBar));

      expect(findAppBar.backgroundColor, Colors.blueGrey);
    });
  });

  group('Body', () {
    testWidgets('VehicleListItem is first item of Body', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();

      final findColumn = tester.firstWidget<Column>(find.byType(Column));
      final firstElement = findColumn.children[0];

      expect(firstElement.runtimeType, VehicleListItem);
 
    });

    testWidgets('ListView as second item of body', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();

      final findColumn = tester.firstWidget<Column>(find.byType(Column));

      final firstElement = findColumn.children[1];
  
      expect(firstElement.runtimeType, ListView);
 
    });

    testWidgets('contains new Widget of type VehicleStateListItem', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleScreen);
      await tester.pumpAndSettle();

      final findVehicleStateListItem = find.byType(VehicleStateListItem);
      final amountOfVehicleStateListItems = find.descendant(of: find.byType(ListView), matching: findVehicleStateListItem);
      
      expect(amountOfVehicleStateListItems, findsNWidgets(3));
 
    });
  });

  
}
