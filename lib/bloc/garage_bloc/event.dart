abstract class GarageBlocEvent {}

class LoadVehiclesEvent extends GarageBlocEvent {}

class AddVehicleEvent extends GarageBlocEvent {
  final String vin;

  AddVehicleEvent({
    required this.vin,
  });
}
