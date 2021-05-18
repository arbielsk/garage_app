import 'package:garage_app/data_provider/garage_data_provider.dart';
import 'package:garage_app/exceptions/vehicle_cannot_be_added_exception.dart';
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

  Future<List<Vehicle>> addVehicle(Vehicle vehicle) async {
    final success = await _dataProvider.addVehicle(vehicle.toMap());
    if (success) {
      return await getOwnedVehicles();
    }
    throw VehicleCannotBeAddedException();
  }
}
