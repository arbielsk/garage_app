import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:garage_app/bloc/vehicle_state_bloc/vehicle_state_bloc_states.dart';
import 'package:garage_app/bloc/vehicle_state_bloc/vehicle_state_events.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/repository/vehicle_state_repository.dart';

class VehicleStateBloc
    extends Bloc<VehicleStateEvents, VehicleStateBlocStates> {
  final VehicleStateRepository _repository;
  StreamSubscription<VehicleState>? _streamSubscription;
  VehicleStateBloc(this._repository, String vinNumber) : super(VSInitState()) {
    this.add(VehicleStateInitializationEvent(vinNumber));
  }

  @override
  Stream<VehicleStateBlocStates> mapEventToState(
      VehicleStateEvents event) async* {
    if (event is VehicleStateInitializationEvent) {
      yield VSLoadingState();
      try {
        _streamSubscription =
            _repository.streamVehicleState(event.vin).listen((event) {
          this.add(VehicleStateSubscriptionEvent(event));
        });
      } catch (exception) {
        yield VSSubscriptionFailState(errorMessage: exception.toString());
      }
    }
    if (event is VehicleStateSubscriptionEvent) {
      try {
        if (this.state != VSLoadSuccessState(event.state)) {
          yield VSLoadSuccessState(event.state);
        }
      } catch (exception) {
        yield VSLoadFailState(exception.toString());
      }
    }
    if (event is UpdateLockStatusEvent) {
      yield VSUpdatingState();
      final updatedState = event.currentState.copyWith(
          lockStatus: event.currentState.lockStatus == LockStatus.OPEN
              ? LockStatus.LOCKED
              : LockStatus.OPEN);
      this.add(VehicleStateSubscriptionEvent(updatedState));
      _repository.updateVehicleState(event.vinNumber, updatedState);
    }
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
