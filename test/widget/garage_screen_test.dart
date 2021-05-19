import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/widget/front_layer.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';

import '../../lib/widget/garage_route.dart';
import '../test_util/material_widget_wrapper.dart';

void main() {
  final _widget = MaterialWidgetWrapper(child: GarageRoute());
  group('AppBar', () {
    testWidgets('Appbar text', (WidgetTester tester) async {
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
  });

  group('Stack', () {
    testWidgets(('Stack exists'), (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final findStackWidget = find.byWidget(_widget);
      final stack = find.descendant(
          of: findStackWidget, matching: find.byType(Stack).first);
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
  });

  group('front layer', () {
    final _frontLayer = MaterialWidgetWrapper(child: FrontLayer());
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

    testWidgets('TextField exists', (WidgetTester tester) async {
      await tester.pumpWidget(_frontLayer);
      await tester.pumpAndSettle();
      final container = find.byType(Container);
      final textField = find.descendant(
          of: container, matching: find.byType(TextField).first);
      expect(textField, findsOneWidget);
    });

    testWidgets('ElevatedButton text', (WidgetTester tester) async {
      final _text = 'Add vehicle';
      final _padding = 8.0;
      await tester.pumpWidget(_frontLayer);
      await tester.pumpAndSettle();
      final frontLayer = find.byType(FrontLayer);

      final elevatedButton = find.descendant(
          of: frontLayer, matching: find.byType(ElevatedButton));

      final elevatedButtonText =
          find.descendant(of: elevatedButton, matching: find.byType(Text));

      expect(tester.firstWidget<Text>(elevatedButtonText).data, _text);

      final elevatedButtonSize = tester.getSize(elevatedButton);

      final textContainer =
          find.descendant(of: elevatedButton, matching: find.byType(Text));
      final containerSize = tester.getSize(textContainer);
      expect(containerSize.width, elevatedButtonSize.width - _padding * 2);
    });

    testWidgets('Test onTap', (WidgetTester tester) async {
      await tester.pumpWidget(_widget);
      await tester.pumpAndSettle();
      final gestureDetector = find.byType(GestureDetector);
      //expect(tester.tap(gestureDetector), );
    });
  });
}
