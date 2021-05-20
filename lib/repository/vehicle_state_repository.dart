import 'dart:async';

import 'package:garage_app/model/vehicle_state.dart';

import '../data_provider/vehicle_state_data_provider.dart';
import '../model/vehicle_state.dart';

class VehicleStateRepository {
  
  const VehicleStateRepository();

  // REQ 1: call subscribeVehicleState
  // REQ 2: transform Map to VehicleState
  // REQ 3: make sure to handle subscriptions appropriately
  Stream<VehicleState> streamVehicleState(String vin) {
  
  }

  // REQ 1: subscribeVehicleState
  // REQ 2: wait for first result, transform to VehicleState and return
  // REQ 3: unsubscribe
  Future<VehicleState> getVehicleState(String vin) async {
    
  }

  // REQ 1: Transform vehicleState to Map and call DataProvider
  void updateVehicleState(String vin, VehicleState vehicleState) {
   
  }
}
