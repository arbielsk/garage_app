abstract class VehicleStateDataProvider {
  // REQ 1: opens a HOT observable/stream to get vehicle state updates for VIN
  // REQ 2: generate initial state for vin and store in in-memory Map
  // REQ 3: should yield an update every 5 seconds, vehicleState from in-memory
  // Map is emitted
  Stream<Map<String, String>> subscribeVehicleState(String vin);
  // REQ 1: should update the vehicleState for the vin in the in-memory Map
  // REQ 2: if state does not exist yet, set newState as first state
  void updateVehicleState(String vin, Map<String, String> newState);
}
