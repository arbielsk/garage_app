abstract class VehicleStateEvents {}

class LoadVehicleStateEvent extends VehicleStateEvents {
  final String vin;

  LoadVehicleStateEvent(this.vin);
}
