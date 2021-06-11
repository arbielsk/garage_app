import 'package:garage_app/model/vehicle_state.dart';

abstract class VehicleStateEvents {}

class VehicleStateInitializationEvent extends VehicleStateEvents {
  final String vin;

  VehicleStateInitializationEvent(this.vin);
}

class VehicleStateSubscriptionEvent extends VehicleStateEvents {
  final VehicleState state;

  VehicleStateSubscriptionEvent(this.state);
}

class UpdateLockStatusEvent extends VehicleStateEvents {
  final VehicleState currentState;
  final String vinNumber;

  UpdateLockStatusEvent(this.vinNumber, this.currentState);
}
