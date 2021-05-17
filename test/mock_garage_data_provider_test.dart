import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/data_provider/mock_garage_data_provider.dart';
import 'package:garage_app/model/vehicle.dart';

main() {
  late MockGarageDataProvider provider;
  final vehicle = {
    'vin': 'ASDF1ASDF2ASDF310',
    'model': 'BMW Z8',
    'displayName': 'Vehicle to add',
  };
  final vehicleWithoutVin = {
    'model': 'BMW Z8',
    'displayName': 'Vehicle to add',
  };
  final vehicleWithoutModel = {
    'vin': 'ASDF1ASDF2ASDF310',
    'displayName': 'Vehicle to add',
  };
  final vehicleWithoutDisplayName = {
    'vin': 'ASDF1ASDF2ASDF310',
    'model': 'BMW Z8',
  };
  final existingVehicle = {
    'vin': 'ASDF1ASDF2ASDF341',
    'model': 'BMW Z8',
    'displayName': 'Vehicle to add',
  };

  setUp(() {
    provider = MockGarageDataProvider();
  });
  group('getOwnedVehicles', () {
    test('should initially return 5 mock vehicles', () {
      expect(provider.getOwnedVehicles().length, 5);
      provider.getOwnedVehicles().forEach((element) {
        // required keys exist
        expect(element.keys.contains('vin'), true);
        expect(element.keys.contains('model'), true);
        expect(element.keys.contains('displayName'), true);
        // required keys have values
        expect(element['vin'], isNotNull);
        expect(element['model'], isNotNull);
        expect(element['displayName'], isNotNull);
        // can be transformed into domain object
        expect(Vehicle.fromMap(element), isNotNull);
      });
    });

    test('should be idempotent', () {
      expect(provider.getOwnedVehicles(), provider.getOwnedVehicles());
    });
  });

  group('addVehicle', () {
    test('should add a vehicle to garage', () {
      expect(provider.getOwnedVehicles().length, 5);
      expect(provider.addVehicle(vehicle), true);
      expect(provider.getOwnedVehicles().length, 6);
      expect(provider.getOwnedVehicles().contains(vehicle), true);
    });

    test('should return false if input misses required key or value', () {
      expect(provider.addVehicle(vehicleWithoutDisplayName), false);
      expect(provider.addVehicle(vehicleWithoutModel), false);
      expect(provider.addVehicle(vehicleWithoutVin), false);
    });

    test('should not add vehicle if input misses required key or value', () {
      provider.addVehicle(vehicleWithoutDisplayName);
      provider.addVehicle(vehicleWithoutModel);
      provider.addVehicle(vehicleWithoutVin);

      expect(provider.getOwnedVehicles().length, 5);
    });

    test('should return false if vin already exists', () {
      expect(provider.addVehicle(existingVehicle), false);
    });

    test('should not add vehicle if vin already exists', () {
      provider.addVehicle(existingVehicle);
      expect(provider.getOwnedVehicles().length, 5);
    });
  });
}
