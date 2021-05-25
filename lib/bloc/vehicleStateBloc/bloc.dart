import 'package:bloc/bloc.dart';
import 'package:garage_app/bloc/vehicleStateBloc/event.dart';
import 'package:garage_app/bloc/vehicleStateBloc/state.dart';
import 'package:garage_app/repository/vehicle_state_repository.dart';

class VehicleStateBloc
    extends Bloc<VehicleStateBlocEvent, VehicleStateBlocState> {
  late VehicleStateRepository repo;

  VehicleStateBloc(VehicleStateRepository repo) : super(InitialState()) {
    this.repo = repo;
  }

  @override
  Stream<VehicleStateBlocState> mapEventToState(
      VehicleStateBlocEvent event) async* {
    if (event is LoadVehicleStateEvent) {
      yield LoadVehicleStateState();
      try {
        final vehicleState = await repo.getVehicleState(event.vin);
        yield LoadVehicleStateSuccessState(vehicleState);
      } catch (e) {
        yield LoadVehicleStateFailState(e.toString());
      }
    }

    if (event is UpdateVehicleStateEvent) {
      yield UpdateVehicleStateState();
      try {
        repo.updateVehicleState(event.vin, event.vehicleState);
        yield UpdateVehicleStateSuccessState(event.vehicleState);
      } catch (e) {
        yield UpdateVehicleStateFailState(e.toString());
      }
    }
  }
}
