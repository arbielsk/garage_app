import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/bloc/vehicle_state_bloc/vehicle_state_bloc.dart';
import 'package:garage_app/bloc/vehicle_state_bloc/vehicle_state_bloc_states.dart';
import 'package:garage_app/bloc/vehicle_state_bloc/vehicle_state_events.dart';
import 'package:garage_app/model/enum/ignition_status.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/enum/motor_status.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/repository/vehicle_state_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;

import 'vehicle_bloc_test.mocks.dart';

@GenerateMocks([VehicleStateRepository])
void main() {
  late VehicleStateBloc bloc;
  late VehicleStateRepository repo;
  const String vinNumber = 'A1234B1234C1234D3';
  final exception = Exception('error');
  final VehicleState currentVehicleState = VehicleState(
      lockStatus: LockStatus.LOCKED,
      ignitionStatus: IgnitionStatus.OFF,
      engineStatus: EngineStatus.OFF);

  final VehicleState updatedVehicleState = VehicleState(
      lockStatus: LockStatus.OPEN,
      ignitionStatus: IgnitionStatus.OFF,
      engineStatus: EngineStatus.OFF);
  setUp(() {
    repo = MockVehicleStateRepository();
    bloc = VehicleStateBloc(repo, vinNumber);
  });

  group('VehicleStateBloc tests', () {
    test('Testing initialState of VehicleStateBloc', () {
      expect(bloc.state, VSInitState());
    });

    blocTest('VehicleStateBloc initialization success',
        build: () {
          mockito.when(repo.streamVehicleState(vinNumber)).thenAnswer(
              (_) => Stream<VehicleState>.value(currentVehicleState));
          return bloc;
        },
        expect: () => [
              VSLoadingState(),
              VSLoadSuccessState(currentVehicleState),
            ],
        verify: (_) {
          mockito.verify(repo.streamVehicleState(vinNumber)).called(1);
        });

    blocTest('VehicleStateBloc initialization fail',
        build: () {
          mockito.when(repo.streamVehicleState(vinNumber)).thenThrow(exception);
          return bloc;
        },
        expect: () => [
              VSLoadingState(),
              VSSubscriptionFailState(errorMessage: exception.toString()),
            ],
        verify: (_) {
          mockito.verify(repo.streamVehicleState(vinNumber)).called(1);
        });
    blocTest('VehicleStateBloc emit only once the state bc its the same',
        build: () {
          mockito.when(repo.streamVehicleState(vinNumber)).thenAnswer((_) =>
              Stream<VehicleState>.fromIterable(
                  [currentVehicleState, currentVehicleState]));
          return bloc;
        },
        expect: () => [
              VSLoadingState(),
              VSLoadSuccessState(currentVehicleState),
            ],
        verify: (_) {
          mockito.verify(repo.streamVehicleState(vinNumber)).called(1);
        });

    blocTest('VehicleStateBloc emits the change of the VehicleState',
        build: () {
          mockito.when(repo.streamVehicleState(vinNumber)).thenAnswer((_) =>
              Stream<VehicleState>.fromIterable(
                  [currentVehicleState, updatedVehicleState]));
          return bloc;
        },
        expect: () => [
              VSLoadingState(),
              VSLoadSuccessState(currentVehicleState),
              VSLoadSuccessState(updatedVehicleState),
            ],
        verify: (_) {
          mockito.verify(repo.streamVehicleState(vinNumber)).called(1);
        });

    blocTest(
      'VehicleStateBloc update function called',
      build: () {
        mockito
            .when(repo.streamVehicleState(vinNumber))
            .thenAnswer((_) => Stream.value(updatedVehicleState));
        return bloc;
      },
      skip: 1,
      expect: () =>
          [VSUpdatingState(), VSLoadSuccessState(updatedVehicleState)],
      seed: () =>
          VSLoadSuccessState(currentVehicleState) as VehicleStateBlocStates,
      act: (VehicleStateBloc bloc) =>
          bloc.add(UpdateLockStatusEvent(vinNumber, currentVehicleState)),
    );
  });
}
