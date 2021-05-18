import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:garage_app/model/vehicle.dart';

abstract class GarageBlocState {}

class InitialState extends GarageBlocState {}

class LoadVehiclesState extends GarageBlocState {}

class LoadVehiclesFailState extends GarageBlocState {
  final String errorMessage;
  LoadVehiclesFailState(
    this.errorMessage,
  );

  LoadVehiclesFailState copyWith({
    String? errorMessage,
  }) {
    return LoadVehiclesFailState(
      errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'errorMessage': errorMessage,
    };
  }

  factory LoadVehiclesFailState.fromMap(Map<String, dynamic> map) {
    return LoadVehiclesFailState(
      map['errorMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoadVehiclesFailState.fromJson(String source) =>
      LoadVehiclesFailState.fromMap(json.decode(source));

  @override
  String toString() => 'LoadVehiclesFailState(errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadVehiclesFailState && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

class LoadVehiclesSuccessState extends GarageBlocState {
  final List<Vehicle> vehicles;
  LoadVehiclesSuccessState(
    this.vehicles,
  );

  LoadVehiclesSuccessState copyWith({
    List<Vehicle>? vehicles,
  }) {
    return LoadVehiclesSuccessState(
      vehicles ?? this.vehicles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vehicles': vehicles?.map((x) => x.toMap())?.toList(),
    };
  }

  factory LoadVehiclesSuccessState.fromMap(Map<String, dynamic> map) {
    return LoadVehiclesSuccessState(
      List<Vehicle>.from(map['vehicles']?.map((x) => Vehicle.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory LoadVehiclesSuccessState.fromJson(String source) =>
      LoadVehiclesSuccessState.fromMap(json.decode(source));

  @override
  String toString() => 'LoadVehiclesSuccessState(vehicles: $vehicles)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadVehiclesSuccessState &&
        listEquals(other.vehicles, vehicles);
  }

  @override
  int get hashCode => vehicles.hashCode;
}
