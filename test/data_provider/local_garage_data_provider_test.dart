import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/data_provider/local_garage_data_provider.dart';
import 'package:garage_app/model/vehicle.dart';

main() {
  late LocalGarageDataProvider provider;
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
    provider = LocalGarageDataProvider();
  });
  group('getOwnedVehicles', () {
    test('should initially return 5 mock vehicles', () async {
      expect((await provider.getOwnedVehicles()).length, 5);
      (await provider.getOwnedVehicles()).forEach((element) {
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

    test('should be idempotent', () async {
      expect(
          await provider.getOwnedVehicles(), await provider.getOwnedVehicles());
    });
  });

  group('addVehicle', () {
    test('should add a vehicle to garage', () async {
      expect((await provider.getOwnedVehicles()).length, 5);
      expect(await provider.addVehicle(vehicle), true);
      expect((await provider.getOwnedVehicles()).length, 6);
      expect((await provider.getOwnedVehicles()).contains(vehicle), true);
    });

    test('should return false if input misses required key or value', () async {
      expect(await provider.addVehicle(vehicleWithoutDisplayName), false);
      expect(await provider.addVehicle(vehicleWithoutModel), false);
      expect(await provider.addVehicle(vehicleWithoutVin), false);
    });

    test('should not add vehicle if input misses required key or value',
        () async {
      await provider.addVehicle(vehicleWithoutDisplayName);
      await provider.addVehicle(vehicleWithoutModel);
      await provider.addVehicle(vehicleWithoutVin);

      expect((await provider.getOwnedVehicles()).length, 5);
    });

    test('should return false if vin already exists', () async {
      expect((await provider.addVehicle(existingVehicle)), false);
    });

    test('should not add vehicle if vin already exists', () async {
      await provider.addVehicle(existingVehicle);
      expect((await provider.getOwnedVehicles()).length, 5);
    });
  });
}
