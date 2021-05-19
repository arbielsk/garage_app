import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/garage_bloc/state.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_bloc_state.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_events.dart';
import 'package:garage_app/data_provider/local_vehicle_state_data_provider.dart';
import 'package:garage_app/repository/vehicle_state_repository.dart';

class VehicleBloc extends Bloc<VehicleStateEvents, VehicleStateBloc> {
  late VehicleStateRepository vehicleStateRepository;

  VehicleBloc(this.vehicleStateRepository, String vin)
      : super(VehicleStateBloc.initial()) {
    this.add(LoadVehicleStateEvent(vin));
  }

  @override
  Stream<VehicleStateBloc> mapEventToState(VehicleStateEvents event) async* {
    if (event is LoadVehicleStateEvent) {
      yield VehicleStateBloc.load();
      try {
        final vehicleState =
            await vehicleStateRepository.getVehicleState(event.vin);
        yield VehicleStateBloc.loaded(vehicleState: vehicleState);
      } catch (e) {
        yield VehicleStateBloc.failed(error: e.toString());
      }
    }
  }
}
