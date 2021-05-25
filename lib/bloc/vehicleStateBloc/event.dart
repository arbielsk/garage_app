import 'package:garage_app/model/vehicle_state.dart';

abstract class VehicleStateBlocEvent {}

class LoadVehicleStateEvent extends VehicleStateBlocEvent {
  final String vin;
  LoadVehicleStateEvent(this.vin);
}

class UpdateVehicleStateEvent extends VehicleStateBlocEvent {
  final String vin;
  final VehicleState vehicleState;

  UpdateVehicleStateEvent(this.vin, this.vehicleState);
}
