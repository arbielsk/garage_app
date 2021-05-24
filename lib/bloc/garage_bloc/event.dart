abstract class GarageBlocEvent {}

class LoadVehiclesEvent extends GarageBlocEvent {}

class AddVehiclesEvent extends GarageBlocEvent {
  final String vin;

  AddVehiclesEvent(this.vin);
}
