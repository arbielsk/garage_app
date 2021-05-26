import 'package:garage_app/model/vehicle_state.dart';

abstract class VehicleStateEvents {}

class InitializeVehicleStateEvent extends VehicleStateEvents {
  final String vin;

  InitializeVehicleStateEvent(this.vin);
}

class NewVehicleStateEvent extends VehicleStateEvents {
  final VehicleState newVehicleState;

  NewVehicleStateEvent(this.newVehicleState);
}

class UpdateVehicleStateEvent extends VehicleStateEvents {
  final String vin;
  final VehicleState currentVehicleState;

  UpdateVehicleStateEvent(this.vin, this.currentVehicleState);
}

class SubscribeVehicleStateEvent extends VehicleStateEvents {
  final String vin;

  SubscribeVehicleStateEvent(this.vin);
}
