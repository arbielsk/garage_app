import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/data_provider/garage_data_provider.dart';
import 'package:garage_app/data_provider/local_garage_data_provider.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/repository/garage_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:matcher/matcher.dart';

import '../../lib/exceptions/vehicle_cannot_be_added_exception.dart';
import 'garage_repository_test.mocks.dart';

@GenerateMocks([GarageDataProvider])
void main() {
  group('garage repository', () {
    test('can be initialized with GarageDataProvider', () {
      GarageRepository(LocalGarageDataProvider());
    });
  });

  group('get owned vehicles', () {
    late GarageRepository garageRepo;
    late GarageDataProvider provider;
    List<Map<String, dynamic>> vehicleMaps = [
      {
        'vin': 'ASDF1ASDF2ASDF341',
        'model': 'BMW 128ti',
        'displayName': 'Vehicle 1',
      },
      {
        'vin': 'ASDF1ASDF2ASDF341',
        'model': 'BMW 128ti',
        'displayName': 'Vehicle 1',
      },
      {
        'vin': 'ASDF1ASDF2ASDF341',
        'model': 'BMW 128ti',
        'displayName': 'Vehicle 1',
      },
      {
        'vin': 'ASDF1ASDF2ASDF341',
        'model': 'BMW 128ti',
        'displayName': 'Vehicle 1',
      },
      {
        'vin': 'ASDF1ASDF2ASDF341',
        'model': 'BMW 128ti',
        'displayName': 'Vehicle 1',
      }
    ];
    setUp(() {
      provider = MockGarageDataProvider();
      garageRepo = GarageRepository(provider);
    });
    test('returns a list of vehicles', () async {
      when(provider.getOwnedVehicles()).thenAnswer(
            (_) async => vehicleMaps,
      );

      expect((await garageRepo.getOwnedVehicles()).length, 5);
      (await garageRepo.getOwnedVehicles()).forEach((element) {
        // can be transformed into domain object
        expect(element.runtimeType, Vehicle);
      });
    });
  });

  group('Add vehicles', () {
    late GarageRepository garageRepo;
    late GarageDataProvider provider;
    final _vehicle = Vehicle(
      displayName: "Zielpuls BMW 3",
      model: "BMW M2 CS 3",
      vin: "A1234B1234C1234D3",
    );
    setUp(() {
      provider = MockGarageDataProvider();
      garageRepo = GarageRepository(provider);
    });
    test('add vehicle for GarageDataProvider returns true', () async {
      when(provider.addVehicle(_vehicle.toMap()))
          .thenAnswer((realInvocation) async => true);

      when(provider.getOwnedVehicles()).thenAnswer(
            (_) async => [_vehicle.toMap()],
      );

      expect((await garageRepo.addVehicle(_vehicle)).length, 1);
    });

    test('addVehicle from GarageDataProvider returns false', () async {
      when(provider.addVehicle(_vehicle.toMap()))
          .thenAnswer((_) async => false);
      expect(() async => await garageRepo.addVehicle(_vehicle),
          throwsA(const TypeMatcher<VehicleCannotBeAddedException>()));
    });
  });
}
