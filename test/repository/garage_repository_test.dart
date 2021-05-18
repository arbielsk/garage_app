import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/data_provider/garage_data_provider.dart';
import 'package:garage_app/data_provider/local_garage_data_provider.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/repository/garage_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'garage_repository_test.mocks.dart';

@GenerateMocks([GarageDataProvider])
void main() {
  group('GarageRepository', () {
    test('can be initialized with GarageDataProvider', () {
      GarageRepository(LocalGarageDataProvider());
    });
  });

  group('getOwnedVehicles', () {
    late GarageRepository repo;
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
      repo = GarageRepository(provider);
    });

    test('returns a list of vehicles', () async {
      when(provider.getOwnedVehicles()).thenAnswer(
        (_) async => vehicleMaps,
      );

      expect((await repo.getOwnedVehicles()).length, 5);
      (await repo.getOwnedVehicles()).forEach((element) {
        // can be transformed into domain object
        expect(element.runtimeType, Vehicle);
      });
    });
  });
}
