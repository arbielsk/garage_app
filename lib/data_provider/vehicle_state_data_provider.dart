abstract class VehicleStateDataProvider {
  Stream<Map<String, String>> subscribeVehicleState(String vin);
  void updateVehicleState(String vin, Map<String, String> newState);
}
