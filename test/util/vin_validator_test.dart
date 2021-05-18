import 'package:flutter_test/flutter_test.dart';
import 'package:garage_app/util/vin_validator.dart';

void main() {
  group('validateVin', () {
    test('should return false if vin has more than 17 characters', () {
      final longVin = "A1234B1234C1234567";
      expect(validateVin(longVin), false);
    });

    test('should return false if vin has less than 17 characters', () {
      final shortVin = "A1234B1234C12345";
      expect(validateVin(shortVin), false);
    });

    test('should return true if vin is valid', () {
      final validVin = "A1234B1234C123456";
      expect(validateVin(validVin), true);
    });

    test('should return false if vin contains non-alphanumeric character', () {
      final invalidVin = "A1234B1234C12345%";
      expect(validateVin(invalidVin), false);
    });
  });
}
