import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/data_provider/vehicle_state_data_provider.dart';
import 'package:garage_app/model/enum/ignition_status.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/enum/motor_status.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/repository/vehicle_state_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'vehicle_state_repository_test.mocks.dart';

@GenerateMocks([VehicleStateDataProvider])
void main() {
  late VehicleStateRepository repo;
  late VehicleStateDataProvider provider;

  final selectedVehicle = Vehicle(
      vin: 'ASDF1ASDF2ASDF341', displayName: 'BMW 128ti', model: 'Vehicle 1');
  final initialVehicleState = {
    'ignitionStatus': IgnitionStatus.OFF.toString(),
    'lockStatus': LockStatus.LOCKED.toString(),
    'engineStatus': EngineStatus.OFF.toString(),
  };
  final initialVehicleState2 = {
    'ignitionStatus': IgnitionStatus.OFF.toString(),
    'lockStatus': LockStatus.OPEN.toString(),
    'engineStatus': EngineStatus.OFF.toString(),
  };

  setUp(() {
    provider = MockVehicleStateDataProvider();
    repo = VehicleStateRepository(provider);
  });
  group('VehicleStateRepository tests', () {
    test('Stream returns an instance of VehicleState', () {
      when(provider.subscribeVehicleState(selectedVehicle.vin)).thenAnswer(
          (_) =>
              Stream<Map<String, String>>.fromIterable([initialVehicleState]));
      repo.streamVehicleState(selectedVehicle.vin).listen(expectAsync1((event) {
        expect(event, isA<VehicleState>());
      }));
    });

    test(
        'VehicleStateRepository streamVehicleState emits two different VehicleState',
        () {
      when(provider.subscribeVehicleState(selectedVehicle.vin)).thenAnswer(
          (_) => Stream<Map<String, String>>.fromIterable(
              [initialVehicleState, initialVehicleState2]));
      expect(
          repo.streamVehicleState(selectedVehicle.vin),
          emitsInOrder([
            VehicleState.fromMap(initialVehicleState),
            VehicleState.fromMap(initialVehicleState2)
          ]));
    });

    test('getVehicleState return the first state of the selected vehicle',
        () async {
      when(provider.subscribeVehicleState(selectedVehicle.vin)).thenAnswer(
          (_) =>
              Stream<Map<String, String>>.fromIterable([initialVehicleState]));
      final result = await repo.getVehicleState(selectedVehicle.vin);
      expect(result, VehicleState.fromMap(initialVehicleState));
    });
  });
}
