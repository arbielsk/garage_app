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
  late GarageBloc bloc;
  late GarageRepository repo;
  final emptyVehicles = List<Vehicle>.empty();
  final errorMessage = 'Error';
  final error = Exception(errorMessage);
  final randomVehicle = Vehicle(
      vin: 'A1234B1234C9999R9',
      displayName: 'Random BMW',
      model: 'Random Model');

  setUp(() {
    repo = MockGarageRepository();
    bloc = GarageBloc(repo);
  });

  GarageBloc _initializeBloc() {
    when(repo.getOwnedVehicles()).thenAnswer((_) async => emptyVehicles);
    return bloc;
  }

  group('GarageBloc', () {
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
      'emits LoadVehiclesState, LoadVehicleSuccessState when initialized',
      build: _initializeBloc,
      expect: () => [
        LoadVehiclesState(),
        LoadVehiclesSuccessState(emptyVehicles),
      ],
      verify: (_) {
        verify(repo.getOwnedVehicles()).called(1);
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
        verify(repo.getOwnedVehicles()).called(2);
      },
    );

    blocTest(
      'emits LoadVehiclesState, LoadVehicleFailState when receiving exception from repository',
      build: () {
        when(repo.getOwnedVehicles()).thenThrow(error);
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
        verify(repo.getOwnedVehicles()).called(2);
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
        verify(repo.getOwnedVehicles()).called(2);
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
        verify(repo.getOwnedVehicles()).called(2);
      },
    );
  });

  group('AddVehicle to GarageScreen', () {
    blocTest(
        'AddVehicleState,AddVehicleSuccessState, LoadedVehicleSuccessState',
        build: () {
          when(repo.addVehicle(randomVehicle))
              .thenAnswer((_) async => emptyVehicles);
          return _initializeBloc();
        },
        skip: 2,
        act: (GarageBloc bloc) => bloc.add(
              AddVehicleToGarageEvent(randomVehicle.vin),
            ),
        expect: () => [
              AddVehicleState(),
              AddVehicleSuccessState(vin: randomVehicle.vin),
              LoadVehiclesSuccessState(emptyVehicles)
            ],
        verify: (_) {
          verify(repo.addVehicle(randomVehicle)).called(1);
        });

    blocTest('AddVehicleState,AddVehicleFailState, LoadedVehicleSuccessState',
        build: () {
          when(repo.addVehicle(randomVehicle)).thenThrow(error);
          return _initializeBloc();
        },
        skip: 2,
        act: (GarageBloc bloc) => bloc.add(
              AddVehicleToGarageEvent(randomVehicle.vin),
            ),
        expect: () => [
              AddVehicleState(),
              AddVehicleFailState(vin: randomVehicle.vin),
              LoadVehiclesSuccessState(emptyVehicles),
            ],
        verify: (_) {
          verify(repo.addVehicle(randomVehicle)).called(1);
        });
  });
}
