import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:garage_app/bloc/vehicle_bloc/vehicle_bloc.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_bloc_state.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_state_events.dart';
import 'package:garage_app/model/enum/ignition_status.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/enum/motor_status.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/repository/vehicle_state_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'vehicle_state_bloc_test.mocks.dart';

@GenerateMocks([VehicleStateRepository])
void main() {
  group('VehicleStateBloc', () {
    late VehicleBloc vehicleBloc;
    late VehicleStateRepository repository;
    final vehicleVin = 'A1234B1234C1234D3';
    final initialVehicleState = VehicleState(
        engineStatus: EngineStatus.OFF,
        lockStatus: LockStatus.LOCKED,
        ignitionStatus: IgnitionStatus.OFF);
    final updatedVehicleState = VehicleState(
        engineStatus: EngineStatus.OFF,
        lockStatus: LockStatus.OPEN,
        ignitionStatus: IgnitionStatus.OFF);
    final errorMessage = 'Error';
    final error = Exception(errorMessage);

    setUp(() {
      repository = MockVehicleStateRepository();
      vehicleBloc = VehicleBloc(repository, vehicleVin);
    });

    test('check if first state is Initial', () {
      when(repository.getVehicleState(vehicleVin))
          .thenAnswer((_) async => initialVehicleState);
      expect(vehicleBloc.state, InitialVehicleBlocState());
    });

    blocTest('emit LoadingVehicleState, LoadedVehicleState after initilization',
        build: () {
          when(repository.getVehicleState(vehicleVin))
              .thenAnswer((_) async => initialVehicleState);
          when(repository.streamVehicleState(vehicleVin)).thenAnswer(
              (realInvocation) => StreamController<VehicleState>().stream);
          return vehicleBloc;
        },
        expect: () => [
              LoadingVehicleBlocState(),
              LoadedVehicleBlocState(initialVehicleState),
            ],
        verify: (_) {
          verify(repository.getVehicleState(vehicleVin)).called(1);
        });

    blocTest('emit LoadingVehicleState and then Failed state',
        build: () {
          when(repository.getVehicleState(vehicleVin)).thenThrow(error);
          return vehicleBloc;
        },
        expect: () => [
              LoadingVehicleBlocState(),
              Failed(error.toString()),
            ],
        verify: (_) {
          verify(repository.getVehicleState(vehicleVin)).called(1);
        });

    blocTest('emit LoadedVehicleState then updateVehicleState',
        build: () {
          when(repository.getVehicleState(vehicleVin))
              .thenAnswer((_) async => initialVehicleState);
          when(repository.streamVehicleState(vehicleVin)).thenAnswer(
              (realInvocation) => StreamController<VehicleState>().stream);
          return vehicleBloc;
        },
        act: (VehicleBloc bloc) =>
            bloc.add(UpdateVehicleStateEvent(vehicleVin, initialVehicleState)),
        expect: () => [
              LoadingVehicleBlocState(),
              LoadedVehicleBlocState(initialVehicleState),
              LoadingVehicleBlocState(),
              LoadedVehicleBlocState(updatedVehicleState),
            ],
        verify: (_) {
          verify(repository.getVehicleState(vehicleVin)).called(1);
          verify(repository.updateVehicleState(vehicleVin, updatedVehicleState))
              .called(1);
        });
  });
}
