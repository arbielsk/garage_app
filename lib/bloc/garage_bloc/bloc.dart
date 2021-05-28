import 'package:bloc/bloc.dart';
import 'package:garage_app/bloc/garage_bloc/event.dart';
import 'package:garage_app/bloc/garage_bloc/state.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/repository/garage_repository.dart';

class GarageBloc extends Bloc<GarageBlocEvent, GarageBlocState> {
  late GarageRepository repo;

  GarageBloc(GarageRepository repository) : super(InitialState()) {
    this.repo = repository;
    this.add(LoadVehiclesEvent());
  }

  @override
  Stream<GarageBlocState> mapEventToState(GarageBlocEvent event) async* {
    switch (event.runtimeType) {
      case LoadVehiclesEvent:
        yield LoadVehiclesState();
        try {
          final vehicles = await repo.getOwnedVehicles();
          yield LoadVehiclesSuccessState(vehicles);
        } catch (e) {
          yield LoadVehiclesFailState(e.toString());
        }
        break;
      case AddVehicleEvent:
        yield AddVehicleState();
        try {
          final vin = (event as AddVehicleEvent).vin;
          final vehicle = Vehicle.fromMap({
            'vin': vin,
            'model': 'BMW 128ti',
            'displayName': 'Vehicle 77',
          });
          final vehicles = await repo.addVehicle(vehicle);
          yield AddVehicleSuccessState(vehicle: vehicle);
        } catch (e) {
          print(e.toString());
        }
        break;
    }
  }
}
