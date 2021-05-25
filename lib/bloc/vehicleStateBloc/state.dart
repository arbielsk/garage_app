import 'package:garage_app/model/vehicle_state.dart';

abstract class VehicleStateBlocState {}

class BaseVehicleStateBlocState extends VehicleStateBlocState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InitialState;
  }
}

class InitialState extends BaseVehicleStateBlocState {}

class LoadVehicleStateState extends BaseVehicleStateBlocState {}

class LoadVehicleStateSuccessState extends BaseVehicleStateBlocState {
  final VehicleState vehicleState;
  LoadVehicleStateSuccessState(this.vehicleState);
}

class LoadVehicleStateFailState extends BaseVehicleStateBlocState {
  final String errorMessage;
  LoadVehicleStateFailState(this.errorMessage);
}

class UpdateVehicleStateState extends BaseVehicleStateBlocState {}

class UpdateVehicleStateSuccessState extends BaseVehicleStateBlocState {
  final VehicleState vehicleState;
  UpdateVehicleStateSuccessState(this.vehicleState);
}

class UpdateVehicleStateFailState extends BaseVehicleStateBlocState {
  final String errorMessage;
  UpdateVehicleStateFailState(this.errorMessage);
}
