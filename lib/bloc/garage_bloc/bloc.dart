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
    if (event is LoadVehiclesEvent) {
      yield LoadVehiclesState();
      try {
        final vehicles = await repo.getOwnedVehicles();
        yield LoadVehiclesSuccessState(vehicles);
      } catch (e) {
        yield LoadVehiclesFailState(e.toString());
      }
    }
    if (event is AddVehiclesEvent) {
      yield AddVehicleState();
      try {
        final vehicle = Vehicle(vin: event.vin, displayName: "New Car", model: "model");

        final vehicles = await repo.addVehicle(vehicle);
        
        yield AddVehiclesSuccessState(vehicles: vehicles);
        
        
      } catch (e) {
        yield AddVehiclesFailState(errorMessage: e.toString());
      }
      
    }
  }
}
