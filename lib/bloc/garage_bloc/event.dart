abstract class GarageBlocEvent {}

class LoadVehiclesEvent extends GarageBlocEvent {}

class AddVehicleEvent extends GarageBlocEvent {
  final String vinNumber;

  AddVehicleEvent(this.vinNumber);
}
