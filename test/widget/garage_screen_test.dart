import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/widget/garage_route.dart';
import 'package:garage_app/widget/garage_screen.dart';
import 'package:garage_app/widget/garage_screen_front_layer.dart';
import '../test_util/material_widget_wrapper.dart';

void main() {
  final _garageRoute = GarageRoute();
  final _wrappedGarageRoute = MaterialWidgetWrapper(
    child: _garageRoute,
  );
  Future<void> _initializeWidget(WidgetTester tester) async {
    await tester.pumpWidget(_wrappedGarageRoute);
    await tester.pumpAndSettle();
  }

  group('GarageScreen', () {
    testWidgets(
      "has a stack widget",
      (WidgetTester tester) async {
        await _initializeWidget(tester);
        final findGarageRoute = find.byWidget(_wrappedGarageRoute);
        final findScreen = find.descendant(
          of: findGarageRoute,
          matching: find.byType(GarageScreen),
        );
        final findScaffold =
            find.descendant(of: findScreen, matching: find.byType(Scaffold));
        final findStack = find.descendant(
            of: findScaffold, matching: find.byKey(Key("GarageScreenStack")));
        expect(findStack, findsOneWidget);
      },
    );

    testWidgets(
      "has a GarageScreenFrontLayer widget",
      (WidgetTester tester) async {
        await _initializeWidget(tester);

        final findFrontLayer = find.byType(GarageScreenFrontLayer);
        expect(findFrontLayer, findsOneWidget);
      },
    );
  });
}
