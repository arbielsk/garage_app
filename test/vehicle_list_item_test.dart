import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';

import 'util/material_widget_wrapper.dart';

void main() {
  final _vehicle = Vehicle(
    displayName: "Zielpuls BMW 3",
    model: "BMW M2 CS 3",
    vin: "A1234B1234C1234D3",
  );
  final _vehicleListItem = VehicleListItem(vehicle: _vehicle);
  final _wrappedVehicleListItem = MaterialWidgetWrapper(
    child: _vehicleListItem,
  );
  final _expectedWidgetHeight = 120.0;

  group('VehicleListItem', () {
    testWidgets('can be instantiated with a vehicle',
        (WidgetTester tester) async {
      final widget = VehicleListItem(vehicle: _vehicle);
      await tester.pumpWidget(widget);
      await tester.pumpAndSettle();
    });

    testWidgets('has height 120', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleListItem);
      await tester.pumpAndSettle();

      final findVehicleListItem = find.byWidget(_vehicleListItem);
      final vehicleListItemSize = tester.getSize(findVehicleListItem);
      final vehicleListItemHeight = vehicleListItemSize.height;

      expect(vehicleListItemHeight, _expectedWidgetHeight);
    });

    testWidgets('fills the parents width', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleListItem);
      await tester.pumpAndSettle();

      // get widget width
      final findVehicleListItem = find.byWidget(_vehicleListItem);
      final vehicleListItemSize = tester.getSize(findVehicleListItem);
      final vehicleListItemWidth = vehicleListItemSize.width;

      // get parent width
      final findParent = find.ancestor(
        of: findVehicleListItem,
        matching: find.byType(Center),
      );
      final parentSize = tester.getSize(findParent);
      final parentWidth = parentSize.width;

      expect(vehicleListItemWidth, parentWidth);
    });

    testWidgets('should have a padding of 8.0', (WidgetTester tester) async {
      await tester.pumpWidget(_wrappedVehicleListItem);
      await tester.pumpAndSettle();
      
    });
  });
}
