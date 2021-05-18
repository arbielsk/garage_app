import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';

import '../test_util/material_widget_wrapper.dart';

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

  Future<void> _initializeWidget(WidgetTester tester) async {
    await tester.pumpWidget(_wrappedVehicleListItem);
    await tester.pumpAndSettle();
  }

  group('VehicleListItem', () {
    testWidgets('can be instantiated with a vehicle',
        (WidgetTester tester) async {
      await _initializeWidget(tester);
      ;
      expect(find.byWidget(_vehicleListItem), findsOneWidget);
    });

    testWidgets('has height 120', (WidgetTester tester) async {
      final expectedWidgetHeight = 120.0;

      await _initializeWidget(tester);

      expect(
          tester
              .getSize(
                find.byWidget(_vehicleListItem),
              )
              .height,
          expectedWidgetHeight);
    });

    testWidgets('fills the parents width', (WidgetTester tester) async {
      await _initializeWidget(tester);
      ;

      // get widget width
      final findVehicleListItem = find.byWidget(_vehicleListItem);
      final vehicleListItemWidth = tester.getSize(findVehicleListItem).width;

      // get parent width
      final findParent = find.ancestor(
        of: findVehicleListItem,
        matching: find.byType(Center),
      );
      final parentWidth = tester.getSize(findParent).width;

      expect(vehicleListItemWidth, parentWidth);
    });

    testWidgets('should have a padding of 8.0', (WidgetTester tester) async {
      final padding = 8.0;

      await _initializeWidget(tester);
      ;

      final findVehicleListItem = find.byWidget(_vehicleListItem);
      final vehicleListItemSize = tester.getSize(findVehicleListItem);

      final findChild = find.descendant(
        of: findVehicleListItem,
        matching: find.byType(Column).first,
      );
      final childSize = tester.getSize(findChild);

      expect(childSize.height, vehicleListItemSize.height - 2 * padding);
      expect(childSize.width, vehicleListItemSize.width - 2 * padding);
    });

    testWidgets('has InkWell', (WidgetTester tester) async {
      await _initializeWidget(tester);
      ;

      final findInkWell = find.byType(InkWell);

      expect(findInkWell, findsOneWidget);
    });

    testWidgets('splashColor is Colors.yellow', (WidgetTester tester) async {
      final splashColor = Colors.yellow;

      await _initializeWidget(tester);
      ;

      final findInkWell = find.byType(InkWell);

      expect(
        tester.firstWidget<InkWell>(findInkWell).splashColor,
        splashColor,
      );
    });

    testWidgets('highlightColor is Colors.yellow', (WidgetTester tester) async {
      final highlightColor = Colors.yellow;

      await _initializeWidget(tester);
      ;

      final findInkWell = find.byType(InkWell);

      expect(
        tester.firstWidget<InkWell>(findInkWell).highlightColor,
        highlightColor,
      );
    });

    testWidgets('background color is Colors.white',
        (WidgetTester tester) async {
      final backgroundColor = Colors.white;

      await _initializeWidget(tester);
      ;

      final findVehicleListItem = find.byWidget(_vehicleListItem);
      final findContainer = find.descendant(
        of: findVehicleListItem,
        matching: find.byType(Container).first,
      );
      final container = tester.firstWidget<Container>(findContainer);

      expect(container.color, backgroundColor);
    });

    testWidgets('centers its content', (WidgetTester tester) async {
      await _initializeWidget(tester);
      ;

      final findVehicleListItem = find.byWidget(_vehicleListItem);
      final findIcon = find.byType(Icon);
      final findVin = find.text(_vehicle.vin);
      final findTopRow = find.ancestor(
        of: findIcon,
        matching: find.byType(Row),
      );

      final contentTopLeft = tester.getTopLeft(findTopRow);
      final contentBottomRight = tester.getBottomRight(findVin);
      final parentTopLeft = tester.getTopLeft(findVehicleListItem);
      final parentBottomRight = tester.getBottomRight(findVehicleListItem);

      final topMargin = parentTopLeft.dy - contentTopLeft.dy;
      final bottomMargin = contentBottomRight.dy - parentBottomRight.dy;

      expect(topMargin, bottomMargin);

      final leftMargin = parentTopLeft.dy - contentTopLeft.dy;
      final rightMargin = contentBottomRight.dy - parentBottomRight.dy;

      expect(leftMargin, rightMargin);
    });

    testWidgets('has horizontal space of 16.0 between icon and text',
        (WidgetTester tester) async {
      final horizontalSpacing = 16.0;
      await _initializeWidget(tester);
      ;

      final findIcon = find.byType(Icon);
      final findDisplayName = find.text(_vehicle.displayName);
      final findModel = find.text(_vehicle.model);

      final iconDx = tester.getTopRight(findIcon).dx;
      final displayNameDx = tester.getTopLeft(findDisplayName).dx;
      final modelDx = tester.getTopLeft(findModel).dx;

      expect(displayNameDx - iconDx, horizontalSpacing);
      expect(modelDx - iconDx, horizontalSpacing);
    });
  });

  group('Icon', () {
    testWidgets('size is 60.0', (WidgetTester tester) async {
      final expectedIconSize = 60.0;

      await _initializeWidget(tester);
      ;

      final findIcon = find.byType(Icon);
      final actualIconSize = tester.getSize(findIcon);

      expect(actualIconSize.height, expectedIconSize);
      expect(actualIconSize.width, expectedIconSize);
    });

    testWidgets('is anchor', (WidgetTester tester) async {
      final expectedIcon = Icons.anchor;

      await _initializeWidget(tester);
      ;

      final findIcon = find.byType(Icon);
      final actualIcon = tester.firstWidget<Icon>(findIcon);

      expect(actualIcon.icon, expectedIcon);
    });
  });

  group('Display Name', () {
    testWidgets('text should be vehicle.displayName',
        (WidgetTester tester) async {
      await _initializeWidget(tester);
      ;

      final findText = find.text(_vehicle.displayName);

      expect(findText, findsOneWidget);
    });

    testWidgets('should use headline4 style', (WidgetTester tester) async {
      await _initializeWidget(tester);
      ;

      final findText = find.text(_vehicle.displayName);
      final actualWidget = tester.firstWidget<Text>(findText);

      final materialApp = tester.firstWidget<MaterialApp>(
        find.byType(MaterialApp),
      );

      expect(actualWidget.style!.color,
          materialApp.theme?.textTheme.headline4!.color);
      expect(actualWidget.style!.fontSize,
          materialApp.theme?.textTheme.headline4!.fontSize);
      expect(actualWidget.style!.fontFamily,
          materialApp.theme?.textTheme.headline4!.fontFamily);
      expect(actualWidget.style!.fontWeight,
          materialApp.theme?.textTheme.headline4!.fontWeight);
    });
  });

  group('Brand Model Specifier', () {
    testWidgets('text should be vehicle.model', (WidgetTester tester) async {
      await _initializeWidget(tester);
      ;

      final findText = find.text(_vehicle.model);

      expect(findText, findsOneWidget);
    });

    testWidgets('should use headline4 style', (WidgetTester tester) async {
      await _initializeWidget(tester);
      ;

      final findText = find.text(_vehicle.model);
      final actualWidget = tester.firstWidget<Text>(findText);

      final materialApp = tester.firstWidget<MaterialApp>(
        find.byType(MaterialApp),
      );

      expect(actualWidget.style!.color,
          materialApp.theme?.textTheme.subtitle2!.color);
      expect(actualWidget.style!.fontSize,
          materialApp.theme?.textTheme.subtitle2!.fontSize);
      expect(actualWidget.style!.fontFamily,
          materialApp.theme?.textTheme.subtitle2!.fontFamily);
      expect(actualWidget.style!.fontWeight,
          materialApp.theme?.textTheme.subtitle2!.fontWeight);
    });
  });

  group('Vin label', () {
    testWidgets('text should be vehicle.vin', (WidgetTester tester) async {
      await _initializeWidget(tester);
      ;

      final findText = find.text(_vehicle.vin);

      expect(findText, findsOneWidget);
    });

    testWidgets('should use caption style', (WidgetTester tester) async {
      await _initializeWidget(tester);
      ;

      final findText = find.text(_vehicle.vin);
      final actualWidget = tester.firstWidget<Text>(findText);

      final materialApp = tester.firstWidget<MaterialApp>(
        find.byType(MaterialApp),
      );

      expect(actualWidget.style!.color,
          materialApp.theme?.textTheme.subtitle2!.color);
      expect(actualWidget.style!.fontSize,
          materialApp.theme?.textTheme.subtitle2!.fontSize);
      expect(actualWidget.style!.fontFamily,
          materialApp.theme?.textTheme.subtitle2!.fontFamily);
      expect(actualWidget.style!.fontWeight,
          materialApp.theme?.textTheme.subtitle2!.fontWeight);
    });
  });
}
