import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/bloc/garage_bloc/bloc.dart';
import 'package:garage_app/bloc/garage_bloc/event.dart';
import 'package:garage_app/bloc/garage_bloc/state.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/repository/garage_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;

import 'garage_bloc_test.mocks.dart';

@GenerateMocks([GarageRepository])
void main() {
  group('GarageBloc', () {
    late GarageBloc bloc;
    late GarageRepository repo;
    final emptyVehicles = List<Vehicle>.empty();
    final errorMessage = 'Error';
    final error = Exception(errorMessage);
    final vehicle = Vehicle.fromMap({
      'vin': 'ASDF1ASDF2ASDF123',
      'model': 'BMW 128ti',
      'displayName': 'Vehicle 77',
    });

    setUp(() {
      repo = MockGarageRepository();
      bloc = GarageBloc(repo);
    });

    GarageBloc _initializeBloc() {
      mockito
          .when(repo.getOwnedVehicles())
          .thenAnswer((_) async => emptyVehicles);
      return bloc;
    }

    test('is initialized with InitialState', () {
      expect(bloc.state, InitialState());
    });

    blocTest(
      'emits LoadVehiclesState, LoadVehicleSuccessState when initialized',
      build: _initializeBloc,
      expect: () => [
        LoadVehiclesState(),
        LoadVehiclesSuccessState(emptyVehicles),
      ],
      verify: (_) {
        mockito.verify(repo.getOwnedVehicles()).called(1);
      },
    );

    blocTest(
      'emits LoadVehiclesState, LoadVehicleSuccessState when receiving results from repository',
      build: _initializeBloc,
      act: (GarageBloc bloc) => bloc.add(LoadVehiclesEvent()),
      expect: () => [
        LoadVehiclesState(),
        LoadVehiclesSuccessState(emptyVehicles),
        LoadVehiclesState(),
        LoadVehiclesSuccessState(emptyVehicles),
      ],
      verify: (_) {
        mockito.verify(repo.getOwnedVehicles()).called(2);
      },
    );

    blocTest(
      'emits LoadVehiclesState, LoadVehicleFailState when receiving exception from repository',
      build: () {
        mockito.when(repo.getOwnedVehicles()).thenThrow(error);
        return bloc;
      },
      skip: 2,
      act: (GarageBloc bloc) => bloc.add(LoadVehiclesEvent()),
      expect: () => [
        LoadVehiclesState(),
        LoadVehiclesFailState(
          error.toString(),
        ),
      ],
      verify: (_) {
        mockito.verify(repo.getOwnedVehicles()).called(2);
      },
    );

    blocTest(
      'emits LoadVehiclesState, LoadVehicleSuccessState when receiving results from repository',
      build: _initializeBloc,
      skip: 2,
      seed: () =>
          LoadVehiclesFailState('some error message') as GarageBlocState,
      act: (GarageBloc bloc) => bloc.add(LoadVehiclesEvent()),
      expect: () => [
        LoadVehiclesState(),
        LoadVehiclesSuccessState(emptyVehicles),
      ],
      verify: (_) {
        mockito.verify(repo.getOwnedVehicles()).called(2);
      },
    );

    blocTest(
      'emits LoadVehiclesState, LoadVehicleSuccessState when receiving results from repository',
      build: _initializeBloc,
      skip: 2,
      seed: () => LoadVehiclesSuccessState(emptyVehicles) as GarageBlocState,
      act: (GarageBloc bloc) => bloc.add(LoadVehiclesEvent()),
      expect: () => [
        LoadVehiclesState(),
        LoadVehiclesSuccessState(emptyVehicles),
      ],
      verify: (_) {
        mockito.verify(repo.getOwnedVehicles()).called(2);
      },
    );

    blocTest(
      'emits AddVehicleState when receiving an AddVehicleEvent',
      build: () {
        final result = [vehicle];
        mockito.when(repo.addVehicle(vehicle)).thenAnswer((_) async => result);
        return _initializeBloc();
      },
      skip: 2,
      seed: () => LoadVehiclesSuccessState(emptyVehicles) as GarageBlocState,
      act: (GarageBloc bloc) => bloc.add(AddVehicleEvent(vin: vehicle.vin)),
      expect: () => [
        AddVehicleState(),
        AddVehicleSuccessState(vehicle: vehicle),
      ],
      verify: (_) => mockito.verify(repo.addVehicle(vehicle)).called(1),
    );
  });
}
