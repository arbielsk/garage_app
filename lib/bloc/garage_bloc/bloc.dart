import 'package:bloc/bloc.dart';
import 'package:garage_app/bloc/garage_bloc/event.dart';
import 'package:garage_app/bloc/garage_bloc/state.dart';
import 'package:garage_app/repository/garage_repository.dart';

import '../../model/vehicle.dart';
import 'event.dart';
import 'state.dart';

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
    if (event is AddVehicleEvent) {
      yield AddVehicleState();
      try {
        final vehicles = await repo.addVehicle(new Vehicle(
            vin: event.vinNumber,
            displayName: 'Random BMW',
            model: 'Random BMW model'));
        yield AddVehicleSuccessState(vinNumber: event.vinNumber);
        await Future.delayed(Duration(seconds: 1));
        yield LoadVehiclesSuccessState(vehicles);
      } catch (exception) {
        yield AddVehicleFailState(vinNumber: event.vinNumber);
        await Future.delayed(Duration(seconds: 1));
        final vehicles = await repo.getOwnedVehicles();
        yield LoadVehiclesSuccessState(vehicles);
      }
    }
  }
}
