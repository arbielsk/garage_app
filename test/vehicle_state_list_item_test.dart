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
  final _vehicleState = VehicleState(
    engineStatus: EngineStatus.ON,
    ignitionStatus: IgnitionStatus.ON,
    lockStatus: LockStatus.OPEN,
  );

  final _vehicleStateListItem =
      VehicleStateListItem(stateVal: _vehicleState.engineStatus.toString());
  final _wrappedVehicleStateListItem =
      MaterialWidgetWrapper(child: _vehicleStateListItem);

  group('VehicleStateListItem', () {
    testWidgets('should have a padding of 16.0', (WidgetTester tester) async {
      final padding = 16.0;

      await tester.pumpWidget(_wrappedVehicleStateListItem);
      await tester.pumpAndSettle();

      final findVehicleStateListItem = find.byWidget(_vehicleStateListItem);
      final vehicleStateListItemSize = tester.getSize(findVehicleStateListItem);

      final findParent = find.descendant(
          of: findVehicleStateListItem, matching: find.byType(Text));
      final parentSize = tester.getSize(findParent);

      expect(parentSize.height, vehicleStateListItemSize.height - 2 * padding);
      expect(parentSize.width, vehicleStateListItemSize.width - 2 * padding);
    });
    testWidgets('text should be one vehicleState member',
        (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleStateListItem);
      await tester.pumpAndSettle();

      final findText = find.text(_vehicleState.engineStatus.toString());

      expect(findText, findsOneWidget);
    });

    testWidgets('text should be center', (WidgetTester tester) async {
      final _expectedTextAlign = TextAlign.center;
      await tester.pumpWidget(_wrappedVehicleStateListItem);
      await tester.pumpAndSettle();

      final findText = find.text(_vehicleState.engineStatus.toString());
      final actualWidget = tester.firstWidget<Text>(findText);

      expect(actualWidget.textAlign, _expectedTextAlign);
    });

    testWidgets('should use subtitle1 style', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleStateListItem);
      await tester.pumpAndSettle();

      final findText = find.text(_vehicleState.engineStatus.toString());
      final actualWidget = tester.firstWidget<Text>(findText);

      final materialApp = tester.firstWidget<MaterialApp>(
        find.byType(MaterialApp),
      );
      final textTheme = materialApp.theme?.textTheme.subtitle1;
      expect(actualWidget.style!.color, textTheme!.color);
      expect(actualWidget.style!.fontSize, textTheme.fontSize);
      expect(actualWidget.style!.fontFamily, textTheme.fontFamily);
      expect(actualWidget.style!.fontWeight, textTheme.fontWeight);
    });
  });
}
