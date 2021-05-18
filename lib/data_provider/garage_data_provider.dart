abstract class GarageDataProvider {
  Future<List<Map<String, dynamic>>> getOwnedVehicles();
  Future<bool> addVehicle(Map<String, dynamic> vehicle);
}
