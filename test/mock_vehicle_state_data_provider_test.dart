import 'dart:async';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/data_provider/mock_vehicle_state_data_provider.dart';

main() {
  late MockVehicleStateDataProvider provider;
  final vin = 'ASDF1ASDF2ASDF341';
  final vehicleState = {
    'ignitionStatus': 'OFF',
    'lockStatus': 'LOCKED',
    'engineStatus': 'OFF',
  };
  final newVehicleState = {
    'ignitionStatus': 'OFF',
    'lockStatus': 'OPEN',
    'engineStatus': 'OFF'
  };
  setUp(() {
    provider = MockVehicleStateDataProvider();
  });

  group('subscribeVehicleState', () {
    test('should return Stream<Map<String, String>>', () async {
      expect(provider.subscribeVehicleState(vin).runtimeType,
          Stream.value(vehicleState).runtimeType);
    });

    test('should emit vehicleStates', () async {
      expect(
          provider.subscribeVehicleState(vin),
          emitsInOrder(
            [vehicleState, vehicleState, vehicleState],
          ));
    });

    test('should subscribe to existing stream', () async {
      final stream1 = provider.subscribeVehicleState(vin);
      final stream2 = provider.subscribeVehicleState(vin);
      expect(stream1, stream2);
    });
  });

  group('updateVehicleState', () {
    test('should emit updated vehicleState', () async {
      Future.delayed(
        Duration(seconds: 1),
        () => provider.updateVehicleState(
          vin,
          newVehicleState,
        ),
      );

      expect(
        provider.subscribeVehicleState(vin),
        emitsInOrder(
          [
            vehicleState,
            newVehicleState,
            newVehicleState,
          ],
        ),
      );
    });

    test('should update state persistently', () async {
      final stream1 = provider.subscribeVehicleState(vin);

      Future.delayed(
        Duration(seconds: 1),
        () => provider.updateVehicleState(
          vin,
          newVehicleState,
        ),
      );

      expect(
        stream1,
        emitsInOrder(
          [
            vehicleState,
            newVehicleState,
          ],
        ),
      );

      await Future.delayed(
        Duration(seconds: 2),
      );

      final stream2 = provider.subscribeVehicleState(vin);

      expect(
        stream2,
        emitsInOrder([
          newVehicleState,
        ]),
      );
    });

    test('should set state also if there is no subscription', () async {
      provider.updateVehicleState(
        vin,
        newVehicleState,
      );

      expect(
        provider.subscribeVehicleState(vin),
        emitsInOrder(
          [
            newVehicleState,
            newVehicleState,
          ],
        ),
      );
    });
  });
}
