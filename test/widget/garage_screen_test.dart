import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/widget/add_vehicle_bar.dart';
import 'package:garage_app/widget/custom_appbar.dart';
import 'package:garage_app/widget/garage_screen.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';
import 'package:garage_app/widget/vehicle_route.dart';

import '../../lib/widget/garage_route.dart';
import '../test_util/material_widget_wrapper.dart';

void main() {
  final _widget = MaterialWidgetWrapper(child: GarageRoute());
  group('AppBar', () {
    testWidgets('Appbar text EN', (WidgetTester tester) async {
      final text = 'Garage';
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();

      final appBar = find.text(text);
      expect(appBar, findsOneWidget);
    });

    testWidgets('Appbar color', (WidgetTester tester) async {
      final color = Colors.blueGrey;
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final appBar = find.byType(AppBar);
      expect(tester.firstWidget<AppBar>(appBar).backgroundColor, color);
    });

    testWidgets('Appbar text DE', (WidgetTester tester) async {
      final _widgetDE = MaterialWidgetWrapper(
        child: GarageRoute(),
        selectedLocale: Locale('de'),
      );
      final text = 'Garage';
      await tester.pumpWidget(_widgetDE);
      await tester.pumpAndSettle();

      final appBar = find.text(text);
      expect(appBar, findsOneWidget);
    });

    testWidgets('Appbar text RO', (WidgetTester tester) async {
      final _widgetRO = MaterialWidgetWrapper(
        child: GarageRoute(),
        selectedLocale: Locale('ro'),
      );
      final text = 'Garaj';
      await tester.pumpWidget(_widgetRO);
      await tester.pumpAndSettle();

      final appBar = find.text(text);
      expect(appBar, findsOneWidget);
    });
  });

  group('Stack', () {
    testWidgets(('Stack exists'), (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final findStackWidget = find.byWidget(_widget);
      final stack = find.descendant(
          of: findStackWidget, matching: find.byKey(GarageScreen.stackKey));
      expect(stack, findsOneWidget);
    });
  });

  group('Back layer', () {
    testWidgets('ListView exists', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final findListView = find.byWidget(_widget);
      final listView = find.descendant(
          of: findListView, matching: find.byType(ListView).first);
      expect(listView, findsOneWidget);
    });

    testWidgets('ListView has any item', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final findListView = find.byType(ListView);
      final listView = find.descendant(
          of: findListView, matching: find.byType(VehicleListItem));
      expect(listView, findsWidgets);
    });

    testWidgets('ListView size', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final findScaffold = find.byType(Scaffold).first;
      final appBar = find.byType(AppBar).first;
      final stack = find.byType(Stack).first;
      final screenSize = tester.getSize(findScaffold);
      final appBarSize = tester.getSize(appBar);
      final stackSize = tester.getSize(stack);
      expect((screenSize.height - appBarSize.height), stackSize.height);
      expect(screenSize.width, stackSize.width);
    });

    testWidgets('ListView scrollable', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final findListView = find.byType(ListView);
      final firstListView = tester.firstWidget<ListView>(findListView);
      expect(firstListView.physics, isA<AlwaysScrollableScrollPhysics>());
    });
    testWidgets('Testing if GestureDetectors exists',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final gestureDetectors = find.byType(GestureDetector);
      expect(gestureDetectors, findsWidgets);
    });

    testWidgets('Testing GestureDetector tap', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final gestureDetector = find.byType(GestureDetector).first;
      await tester.tap(gestureDetector);
      await tester.pumpAndSettle();
      expect(find.byType(VehicleRoute), findsOneWidget);
    });
  });

  group('front layer', () {
    final _frontLayer = MaterialWidgetWrapper(
        child: AddVehicleBar(
      addVehicleCallback: () {},
    ));
    testWidgets('Container height 120.0 and fill the parent',
        (WidgetTester tester) async {
      final _containerSize = 120.0;
      await tester.pumpWidget(_frontLayer);
      await tester.pumpAndSettle();
      final container = find.byType(Container).first;
      final actualContainerSize = tester.getSize(container);
      final scaffold = find.byType(Scaffold).first;
      final actualScaffold = tester.getSize(scaffold);
      expect(_containerSize, actualContainerSize.height);
      expect(actualContainerSize.width, actualScaffold.width);
    });

    testWidgets('Container color', (WidgetTester tester) async {
      final _backgroundColor = Colors.blueGrey[50];
      await tester.pumpWidget(_frontLayer);
      await tester.pumpAndSettle();
      final container = find.byType(Container).first;
      expect(tester.firstWidget<Container>(container).color, _backgroundColor);
    });

    testWidgets('Container padding is 8', (WidgetTester tester) async {
      final padding = 8.0;
      await tester.pumpWidget(_frontLayer);
      await tester.pumpAndSettle();
      final findContainer = find.byType(Container).first;
      final findContainerSize = tester.getSize(findContainer);

      final findDescendant = find.descendant(
        of: findContainer,
        matching: find.byType(Column).first,
      );

      final findDescendantSize = tester.getSize(findDescendant);
      expect(findDescendantSize.width, findContainerSize.width - padding * 2);
      expect(findDescendantSize.height, findContainerSize.height - padding * 2);
    });

    testWidgets('TextFormField exists', (WidgetTester tester) async {
      await tester.pumpWidget(_frontLayer);
      await tester.pumpAndSettle();
      final container = find.byType(Container);
      final textField = find.descendant(
          of: container, matching: find.byType(TextFormField).first);
      expect(textField, findsOneWidget);
    });

    testWidgets('ElevatedButton padding', (WidgetTester tester) async {
      final _padding = EdgeInsets.all(8.0);
      await tester.pumpWidget(_frontLayer);
      await tester.pumpAndSettle();
      final frontLayer = find.byType(AddVehicleBar);

      final elevatedButtonPadding =
          find.descendant(of: frontLayer, matching: find.byType(Padding));

      expect(
          tester.firstWidget<Padding>(elevatedButtonPadding).padding, _padding);
    });
  });

  group('AddVehicleBar tests', () {
    testWidgets('AddVehicleBar widget exits on the GarageScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      expect(find.byType(AddVehicleBar), findsOneWidget);
    });

    testWidgets('FAB widget exits on the GarageScreen',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('AddVehicleBar is invisible', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final addVehicleBarSize = tester.getSize(find.byType(AddVehicleBar));
      expect(addVehicleBarSize.height, 0);
    });

    testWidgets('AddVehicleBar is visible when tapped on button',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      final double addVehicleBarHeight = 120.0;
      final addVehicleBarSize = tester.getSize(find.byType(AddVehicleBar));
      expect(addVehicleBarSize.height, addVehicleBarHeight);
    });

    testWidgets('FAB is visible', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      expect(
          tester
              .firstWidget<AnimatedOpacity>(find.byType(AnimatedOpacity))
              .opacity,
          1);
    });

    testWidgets('Tap onto FAB, opacity will be 0', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(
          tester
              .firstWidget<AnimatedOpacity>(find.byType(AnimatedOpacity))
              .opacity,
          0);
    });

    testWidgets(
        'Tapping to the AppBar the FAB will be visible, and he AddVehicleBar should be invisible',
        (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byType(CustomAppBar));
      await tester.pumpAndSettle();
      expect(
          tester
              .firstWidget<AnimatedOpacity>(find.byType(AnimatedOpacity))
              .opacity,
          1);
      final double addVehicleBarHeight = 0;
      final addVehicleBarSize = tester.getSize(find.byType(AddVehicleBar));
      expect(addVehicleBarSize.height, addVehicleBarHeight);
    });
  });
}
