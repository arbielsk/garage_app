// REQ 1: GarageDataProvider should initially have 5 persistent vehicles (Mocks)
// REQ 2: Vehicles are persistent while the app runs
// REQ 3: Vehicles can be added
abstract class GarageDataProvider {
  // REQ 1: Retrieves a List of all owned vehicles as Map (JSON)
  List<Map<String, dynamic>> getOwnedVehicles();
  // REQ 1: Adds a vehicle to all owned vehicles
  // REQ 2: Returns false if error, true if successful
  // REQ 3: if vin already exists, this should return false
  bool addVehicle(Map<String, dynamic> vehicle);
}
