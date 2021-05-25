import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/data_provider/vehicle_state_data_provider.dart';
import 'package:garage_app/model/enum/ignition_status.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/enum/motor_status.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/repository/vehicle_state_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'vehicle_repository_test.mocks.dart';

@GenerateMocks([VehicleStateDataProvider])
void main() {
  final _vehicleVIN = "A1234B1234C1234D3";
  final initialVehicleState = VehicleState(
      engineStatus: EngineStatus.OFF,
      lockStatus: LockStatus.LOCKED,
      ignitionStatus: IgnitionStatus.OFF);
  final updatedVehicleState = VehicleState(
      engineStatus: EngineStatus.OFF,
      lockStatus: LockStatus.OPEN,
      ignitionStatus: IgnitionStatus.OFF);
  group('VehicleStateRepository', () {
    test('can be intialized', () {
      VehicleStateRepository(MockVehicleStateDataProvider());
    });
  });

  group('get vehicle state', () {
    late VehicleStateRepository repository;
    late VehicleStateDataProvider provider;

    setUp(() {
      provider = MockVehicleStateDataProvider();
      repository = VehicleStateRepository(provider);
    });

    test('Get intial VehicleState', () async {
      when(provider.subscribeVehicleState(_vehicleVIN))
          .thenAnswer((_) => Stream.value(initialVehicleState.toMap()));
      expect(
          (await repository.getVehicleState(_vehicleVIN)), initialVehicleState);
    });

    test('Test vehicle stream fire 3 times', () {
      when(provider.subscribeVehicleState(_vehicleVIN)).thenAnswer((_) =>
          Stream.periodic(
              Duration(seconds: 5), (_) => initialVehicleState.toMap()));
      repository.streamVehicleState(_vehicleVIN).listen(expectAsync1((event) {
            expect(event, initialVehicleState);
          }, count: 3));
    });

    test('VehicleState from InitialState to UpdatedState', () async {
      when(provider.subscribeVehicleState(_vehicleVIN)).thenAnswer((_) =>
          Stream.fromIterable(
              [initialVehicleState.toMap(), updatedVehicleState.toMap()]));
      expect(repository.streamVehicleState(_vehicleVIN),
          emitsInOrder([initialVehicleState, updatedVehicleState]));
    });
  });
}
