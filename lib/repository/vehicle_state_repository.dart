import 'dart:async';

import 'package:garage_app/model/vehicle_state.dart';

import '../data_provider/vehicle_state_data_provider.dart';
import '../model/vehicle_state.dart';

class VehicleStateRepository {
  final VehicleStateDataProvider _vehicleStateDataProvider;

  const VehicleStateRepository(this._vehicleStateDataProvider);

  Stream<VehicleState> streamVehicleState(String vin) {
    return _vehicleStateDataProvider
        .subscribeVehicleState(vin)
        .map((element) => VehicleState.fromMap(element));
  }

  Future<VehicleState> getVehicleState(String vin) async {
    return VehicleState.fromMap(
        await _vehicleStateDataProvider.subscribeVehicleState(vin).first);
  }

  void updateVehicleState(String vin, VehicleState vehicleState) {
    _vehicleStateDataProvider.updateVehicleState(vin, vehicleState.toMap());
  }
}
