import 'package:garage_app/data_provider/local_vehicle_state_data_provider.dart';
import 'package:garage_app/model/vehicle_state.dart';

class VehicleStateRepository {
  final LocalVehicleStateDataProvider _dataProvider;

  VehicleStateRepository(this._dataProvider);

  // REQ 3: make sure to handle subscriptions appropriately
  Stream<VehicleState> streamVehicleState(String vin) {
    return _dataProvider
        .subscribeVehicleState(vin)
        .map((vehicleState) => VehicleState.fromMap(vehicleState));
  }

  // REQ 3: unsubscribe
  Future<VehicleState> getVehicleState(String vin) async {
    return VehicleState.fromMap(
        await _dataProvider.subscribeVehicleState(vin).first);
  }

  // REQ 1: Transform vehicleState to Map and call DataProvider
  void updateVehicleState(String vin, VehicleState vehicleState) {
    _dataProvider.updateVehicleState(
        vin, vehicleState.toMap() as Map<String, String>);
  }
}
