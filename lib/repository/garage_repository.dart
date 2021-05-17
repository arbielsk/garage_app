import 'package:garage_app/model/vehicle.dart';

abstract class GarageRepository {
  // REQ 1: consume getOwnedVehicles from GarageDataProvider and transform to Vehicle
  List<Vehicle> getOwnedVehicles();
  // REQ 1: addVehicle from GarageDataProvider.
  // REQ 2: getOwnedVehicles from GarageDataProvider and transform to Vehicle
  List<Vehicle> addVehicle(Vehicle vehicle);
}
