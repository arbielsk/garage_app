import 'package:garage_app/data_provider/garage_data_provider.dart';

class MockGarageDataProvider implements GarageDataProvider {
  final Map<String, Map<String, dynamic>> vehicles = {};

  static const _vinKey = 'vin';
  static const _modelKey = 'model';
  static const _displayNameKey = 'displayName';

  MockGarageDataProvider() {
    _initializeWithMockVehicles();
  }

  void _initializeWithMockVehicles() {
    final vehicle1 = {
      _vinKey: 'ASDF1ASDF2ASDF341',
      _modelKey: 'BMW 128ti',
      _displayNameKey: 'Vehicle 1',
    };
    final vehicle2 = {
      _vinKey: 'ASDF1ASDF2ASDF342',
      _modelKey: 'BMW M2 CS',
      _displayNameKey: 'Vehicle 2',
    };
    final vehicle3 = {
      _vinKey: 'ASDF1ASDF2ASDF343',
      _modelKey: 'BMW M3',
      _displayNameKey: 'Vehicle 3',
    };
    final vehicle4 = {
      _vinKey: 'ASDF1ASDF2ASDF344',
      _modelKey: 'BMW M4 Competition',
      _displayNameKey: 'Vehicle 4',
    };
    final vehicle5 = {
      _vinKey: 'ASDF1ASDF2ASDF348',
      _modelKey: 'BMW M8',
      _displayNameKey: 'Vehicle 5',
    };
    this.vehicles.putIfAbsent(vehicle1[_vinKey]!, () => vehicle1);
    this.vehicles.putIfAbsent(vehicle2[_vinKey]!, () => vehicle2);
    this.vehicles.putIfAbsent(vehicle3[_vinKey]!, () => vehicle3);
    this.vehicles.putIfAbsent(vehicle4[_vinKey]!, () => vehicle4);
    this.vehicles.putIfAbsent(vehicle5[_vinKey]!, () => vehicle5);
  }

  @override
  Future<bool> addVehicle(Map<String, dynamic> vehicle) async {
    await Future.delayed(Duration(seconds: 1));
    if (!vehicle.keys.contains(_vinKey) || vehicle[_vinKey] == null)
      return false;
    if (!vehicle.keys.contains(_modelKey) || vehicle[_modelKey] == null)
      return false;
    if (!vehicle.keys.contains(_displayNameKey) ||
        vehicle[_displayNameKey] == null) return false;
    if (vehicles.containsKey(vehicle[_vinKey])) return false;
    vehicles.putIfAbsent(vehicle[_vinKey], () => vehicle);
    return true;
  }

  @override
  Future<List<Map<String, dynamic>>> getOwnedVehicles() async {
    await Future.delayed(Duration(seconds: 1));
    return vehicles.values.toList();
  }
}
