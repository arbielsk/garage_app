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
    final initialVehicleState = VehicleState(
        engineStatus: EngineStatus.OFF,
        lockStatus: LockStatus.LOCKED,
        ignitionStatus: IgnitionStatus.OFF);
    final updatedVehicleState = VehicleState(
        engineStatus: EngineStatus.OFF,
        lockStatus: LockStatus.OPEN,
        ignitionStatus: IgnitionStatus.OFF);
    final String vinNumber = 'A1234B1234C1234D3';
    final errorMessage = 'Error';
    final error = Exception(errorMessage);

    setUp(() {
      repository = MockVehicleStateRepository();
      vehicleBloc = VehicleBloc(repository, vinNumber);
    });

    test('check if first state is Initial', () {
      when(repository.getVehicleState(vinNumber))
          .thenAnswer((_) async => initialVehicleState);
      expect(vehicleBloc.state, InitialVehicleBlocState());
    });

    blocTest('emit LoadingVehicleState, LoadedVehicleState after initilization',
        build: () {
          when(repository.getVehicleState(vinNumber))
              .thenAnswer((_) async => initialVehicleState);
          when(repository.streamVehicleState(vinNumber)).thenAnswer(
              (realInvocation) => StreamController<VehicleState>().stream);
          return vehicleBloc;
        },
        expect: () => [
              LoadingVehicleBlocState(),
              LoadedVehicleBlocState(initialVehicleState),
            ],
        verify: (_) {
          verify(repository.getVehicleState(vinNumber)).called(1);
        });

    blocTest('emit LoadingVehicleState and then Failed state',
        build: () {
          when(repository.getVehicleState(vinNumber)).thenThrow(error);
          return vehicleBloc;
        },
        expect: () => [
              LoadingVehicleBlocState(),
              Failed(error.toString()),
            ],
        verify: (_) {
          verify(repository.getVehicleState(vinNumber)).called(1);
        });

    blocTest('emit LoadedVehicleState then updateVehicleState',
        build: () {
          when(repository.getVehicleState(vinNumber))
              .thenAnswer((_) async => initialVehicleState);
          when(repository.streamVehicleState(vinNumber)).thenAnswer(
              (realInvocation) => StreamController<VehicleState>().stream);
          return vehicleBloc;
        },
        act: (VehicleBloc bloc) =>
            bloc.add(UpdateVehicleStateEvent(vinNumber, initialVehicleState)),
        expect: () => [
              LoadingVehicleBlocState(),
              LoadedVehicleBlocState(initialVehicleState),
              LoadingVehicleBlocState(),
              LoadedVehicleBlocState(updatedVehicleState),
            ],
        verify: (_) {
          verify(repository.getVehicleState(vinNumber)).called(1);
          verify(repository.updateVehicleState(vinNumber, updatedVehicleState))
              .called(1);
        });
  });
}
