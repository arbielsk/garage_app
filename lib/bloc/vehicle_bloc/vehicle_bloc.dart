import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_bloc_state.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_state_events.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/vehicle_state.dart';

import '../../repository/vehicle_state_repository.dart';

class VehicleBloc extends Bloc<VehicleStateEvents, VehicleBlocState> {
  late VehicleStateRepository vehicleStateRepository;
  StreamSubscription<VehicleState>? vehicleStateStream;

  VehicleBloc(VehicleStateRepository repository, String vin)
      : super(InitialVehicleBlocState()) {
    this.vehicleStateRepository = repository;
    this.add(InitializeVehicleStateEvent(vin));
  }

  @override
  Stream<VehicleBlocState> mapEventToState(VehicleStateEvents event) async* {
    if (event is InitializeVehicleStateEvent) {
      yield LoadingVehicleBlocState();
      try {
        yield LoadedVehicleBlocState(
            await vehicleStateRepository.getVehicleState(event.vin));
        this.add(SubscribeVehicleStateEvent(event.vin));
      } catch (e) {
        yield Failed(e.toString());
      }
    }
    if (event is NewVehicleStateEvent) {
      yield LoadingVehicleBlocState();
      try {
        yield LoadedVehicleBlocState(event.newVehicleState);
      } catch (e) {
        yield Failed(e.toString());
      }
    }
    if (event is UpdateVehicleStateEvent) {
      try {
        final newVehicleState = event.currentVehicleState.copyWith(
            lockStatus:
                event.currentVehicleState.lockStatus == LockStatus.LOCKED
                    ? LockStatus.OPEN
                    : LockStatus.LOCKED);
        this.add(NewVehicleStateEvent(newVehicleState));
        vehicleStateRepository.updateVehicleState(event.vin, newVehicleState);
      } catch (e) {
        yield Failed(e.toString());
      }
    }
    if (event is SubscribeVehicleStateEvent) {
      vehicleStateStream ??=
          vehicleStateRepository.streamVehicleState(event.vin).listen((event) {
        this.add(NewVehicleStateEvent(event));
      });
    }
  }

  @override
  Future<void> close() {
    vehicleStateStream?.cancel();
    return super.close();
  }
}
