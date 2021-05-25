import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/bloc/garage_bloc/bloc.dart';
import 'package:garage_app/bloc/garage_bloc/event.dart';
import 'package:garage_app/bloc/garage_bloc/state.dart';
import 'package:garage_app/data_provider/local_garage_data_provider.dart';
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
    late LocalGarageDataProvider provider;

    final emptyVehicles = List<Vehicle>.empty();
    final errorMessage = 'Error';
    final error = Exception(errorMessage);
    final addedVehicle = Vehicle(
      vin: 'NEW VIN',
      model: 'ADDED',
      displayName: 'New Added',
    );

    setUp(() {
      repo = MockGarageRepository();
      provider = LocalGarageDataProvider();
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

    blocTest(
      'emits AddVehicleState, AddVehiclesSuccessState after pushing AddVehiclesEvent with a vin',
      build: () {
           var newList = [...emptyVehicles,addedVehicle];
           when( provider.addVehicle(addedVehicle.toMap())).thenAnswer((_) async => true);
        return bloc;
      },
      skip: 2,
      seed: () => AddVehiclesSuccessState(vehicles: emptyVehicles) as GarageBlocState,
      act: (GarageBloc bloc) => bloc.add(AddVehiclesEvent(addedVehicle.vin)),
      expect: () => [
        AddVehicleState(),
        AddVehiclesSuccessState(vehicles: emptyVehicles),
      ],
      verify: (_) {
        verify(repo.addVehicle(addedVehicle)).called(1);
        verify(repo.getOwnedVehicles()).called(1);
        
      },
    );
  });
}
