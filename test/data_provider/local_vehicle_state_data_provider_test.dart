import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/data_provider/local_vehicle_state_data_provider.dart';
import 'package:garage_app/model/enum/ignition_status.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/enum/motor_status.dart';

main() {
  late LocalVehicleStateDataProvider provider;
  final vin = 'ASDF1ASDF2ASDF341';
  final vehicleState = {
    'ignitionStatus': IgnitionStatus.OFF.toString(),
    'lockStatus': LockStatus.LOCKED.toString(),
    'engineStatus': EngineStatus.OFF.toString(),
  };
  final newVehicleState = {
    'ignitionStatus': IgnitionStatus.OFF.toString(),
    'lockStatus': LockStatus.OPEN.toString(),
    'engineStatus': EngineStatus.OFF.toString(),
  };
  setUp(() {
    provider = LocalVehicleStateDataProvider();
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
