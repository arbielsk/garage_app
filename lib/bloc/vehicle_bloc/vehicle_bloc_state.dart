//InitState with a vin number
//LoadingState - Loading the vehicles statuses
//LoadedState - The vehicle statuses are loaded
//FailedState - Connection Fail or some other problem

import 'dart:convert';

import '../../model/vehicle_state.dart';

abstract class VehicleBlocState {}

class InitialVehicleBlocState extends VehicleBlocState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InitialVehicleBlocState;
  }
}

class LoadingVehicleBlocState extends VehicleBlocState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadingVehicleBlocState;
  }
}

class LoadedVehicleBlocState extends VehicleBlocState {
  final VehicleState vehicleState;
  LoadedVehicleBlocState(
    this.vehicleState,
  );

  LoadedVehicleBlocState copyWith({
    VehicleState? vehicleState,
  }) {
    return LoadedVehicleBlocState(
      vehicleState ?? this.vehicleState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vehicleState': vehicleState.toMap(),
    };
  }

  factory LoadedVehicleBlocState.fromMap(Map<String, dynamic> map) {
    return LoadedVehicleBlocState(
      VehicleState.fromMap(map['vehicleState']),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoadedVehicleBlocState.fromJson(String source) =>
      LoadedVehicleBlocState.fromMap(json.decode(source));

  @override
  String toString() => 'Loaded(vehicleState: $vehicleState)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadedVehicleBlocState &&
        other.vehicleState == vehicleState;
  }

  @override
  int get hashCode => vehicleState.hashCode;
}

class Failed extends VehicleBlocState {
  final String errorMessage;

  Failed(
    this.errorMessage,
  );

  Failed copyWith({
    String? errorMessage,
  }) {
    return Failed(
      errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'errorMessage': errorMessage,
    };
  }

  factory Failed.fromMap(Map<String, dynamic> map) {
    return Failed(
      map['errorMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Failed.fromJson(String source) => Failed.fromMap(json.decode(source));

  @override
  String toString() => 'Failed(errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failed && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}
