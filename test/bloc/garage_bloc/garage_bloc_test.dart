import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/bloc/garage_bloc/bloc.dart';
import 'package:garage_app/bloc/garage_bloc/event.dart';
import 'package:garage_app/bloc/garage_bloc/state.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/repository/garage_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'garage_bloc_test.mocks.dart';

@GenerateMocks([GarageRepository])
void main() {
  group('GarageBloc', () {
    late GarageBloc bloc;
    late GarageRepository repo;
    final emptyVehicles = List<Vehicle>.empty();
    final errorMessage = 'Error';
    final error = Exception(errorMessage);

    setUp(() {
      repo = MockGarageRepository();
      bloc = GarageBloc(repo);
    });

    GarageBloc _initializeBloc() {
      when(repo.getOwnedVehicles()).thenAnswer((_) async => emptyVehicles);
      return bloc;
    }

    test('is initialized with InitialState', () {
      expect(bloc.state, InitialState());
    });

    blocTest(
      'emits LoadVehiclesState, LoadVehicleSuccessState when receiving results from repository',
      build: _initializeBloc,
      act: (GarageBloc bloc) => bloc.add(LoadVehiclesEvent()),
      expect: () => [
        LoadVehiclesState(),
        LoadVehiclesSuccessState(emptyVehicles),
      ],
      verify: (_) {
        verify(repo.getOwnedVehicles()).called(1);
      },
    );

    blocTest(
      'emits LoadVehiclesState, LoadVehicleFailState when receiving exception from repository',
      build: () {
        when(repo.getOwnedVehicles()).thenThrow(error);
        return bloc;
      },
      act: (GarageBloc bloc) => bloc.add(LoadVehiclesEvent()),
      expect: () => [
        LoadVehiclesState(),
        LoadVehiclesFailState(
          error.toString(),
        ),
      ],
      verify: (_) {
        verify(repo.getOwnedVehicles()).called(1);
      },
    );

    // blocTest(
    //   'emits LoadVehiclesState, LoadVehicleSuccessState when receiving results from repository',
    //   build: _initializeBloc,
    //   seed: GarageBlocState () => LoadVehiclesFailState('some error message'),
    //   act: (GarageBloc bloc) => bloc.add(LoadVehiclesEvent()),
    //   expect: () => [
    //     LoadVehiclesState(),
    //     LoadVehiclesSuccessState(emptyVehicles),
    //   ],
    //   verify: (_) {
    //     verify(repo.getOwnedVehicles()).called(1);
    //   },
    // );
  });
}
