import 'package:garage_app/data_provider/garage_data_provider.dart';
import 'package:garage_app/model/vehicle.dart';

class GarageRepository {
  final GarageDataProvider _dataProvider;

  GarageRepository(this._dataProvider);

  Future<List<Vehicle>> getOwnedVehicles() async {
    final List<Map<String, dynamic>> vehiclesMaps =
        await _dataProvider.getOwnedVehicles();

    final List<Vehicle> vehicles = vehiclesMaps
        .map(
          (vehicleMap) => Vehicle.fromMap(vehicleMap),
        )
        .toList();

    return vehicles;
  }

  // REQ 1: addVehicle from GarageDataProvider.
  // REQ 2: getOwnedVehicles from GarageDataProvider and transform to Vehicle
  // REQ 3: if dataProvider.addVehicle returns false, throw a VehicleCannotBeAddedException
  Future<List<Vehicle>> addVehicle(Vehicle vehicle) async {
    throw UnimplementedError();
  }
}
