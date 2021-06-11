import 'package:garage_app/data_provider/vehicle_state_data_provider.dart';
import 'package:garage_app/model/vehicle_state.dart';

class VehicleStateRepository {
  final VehicleStateDataProvider _provider;

  VehicleStateRepository(this._provider);

  Stream<VehicleState> streamVehicleState(String vin) {
    return _provider
        .subscribeVehicleState(vin)
        .map((event) => VehicleState.fromMap(event));
  }

  Future<VehicleState> getVehicleState(String vin) async {
    return VehicleState.fromMap(
        await _provider.subscribeVehicleState(vin).first);
  }

  void updateVehicleState(String vin, VehicleState vehicleState) {
    _provider.updateVehicleState(vin, vehicleState.toMap());
  }
}
