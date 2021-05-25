abstract class GarageBlocEvent {}

class LoadVehiclesEvent extends GarageBlocEvent {}

class AddVehicleToGarageEvent extends GarageBlocEvent {
  final String vin;

  AddVehicleToGarageEvent(this.vin);
}
