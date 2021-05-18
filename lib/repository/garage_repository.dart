import 'package:garage_app/model/vehicle.dart';

class GarageRepository {
  // REQ 1: consume getOwnedVehicles from GarageDataProvider and transform to Vehicle
  Future<List<Vehicle>> getOwnedVehicles() async {
    throw UnimplementedError();
  }

  // REQ 1: addVehicle from GarageDataProvider.
  // REQ 2: getOwnedVehicles from GarageDataProvider and transform to Vehicle
  // REQ 3: if dataProvider.addVehicle returns false, throw a VehicleCannotBeAddedException
  Future<List<Vehicle>> addVehicle(Vehicle vehicle) async {
    throw UnimplementedError();
  }
}
