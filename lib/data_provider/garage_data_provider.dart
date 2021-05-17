abstract class GarageDataProvider {
  List<Map<String, dynamic>> getOwnedVehicles();
  bool addVehicle(Map<String, dynamic> vehicle);
}
