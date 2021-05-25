import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:garage_app/model/vehicle.dart';

abstract class GarageBlocState {}

class InitialState extends GarageBlocState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InitialState;
  }
}

class LoadVehiclesState extends GarageBlocState {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadVehiclesState;
  }
}

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
      'vehicles': vehicles.map((x) => x.toMap()).toList(),
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

class AddVehicleState extends GarageBlocState {
  final String vin;

  AddVehicleState(
    this.vin,
  );

  AddVehicleState copyWith({
    String? vin,
  }) {
    return AddVehicleState(
      vin ?? this.vin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vin': vin,
    };
  }

  factory AddVehicleState.fromMap(Map<String, dynamic> map) {
    return AddVehicleState(
      map['vin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddVehicleState.fromJson(String source) =>
      AddVehicleState.fromMap(json.decode(source));

  @override
  String toString() => 'AddVehicleState(vin: $vin)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddVehicleState && other.vin == vin;
  }

  @override
  int get hashCode => vin.hashCode;
}

class AddVehicleSuccessState extends GarageBlocState {
  final String vin;
  AddVehicleSuccessState({
    required this.vin,
  });

  AddVehicleSuccessState copyWith({
    String? vin,
  }) {
    return AddVehicleSuccessState(
      vin: vin ?? this.vin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vin': vin,
    };
  }

  factory AddVehicleSuccessState.fromMap(Map<String, dynamic> map) {
    return AddVehicleSuccessState(
      vin: map['vin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddVehicleSuccessState.fromJson(String source) =>
      AddVehicleSuccessState.fromMap(json.decode(source));

  @override
  String toString() => 'AddVehicleSuccessState(vin: $vin)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddVehicleSuccessState && other.vin == vin;
  }

  @override
  int get hashCode => vin.hashCode;
}

class AddVehicleFailState extends GarageBlocState {
  final String vin;
  AddVehicleFailState({
    required this.vin,
  });

  AddVehicleFailState copyWith({
    String? vin,
  }) {
    return AddVehicleFailState(
      vin: vin ?? this.vin,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'vin': vin,
    };
  }

  factory AddVehicleFailState.fromMap(Map<String, dynamic> map) {
    return AddVehicleFailState(
      vin: map['vin'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddVehicleFailState.fromJson(String source) =>
      AddVehicleFailState.fromMap(json.decode(source));

  @override
  String toString() => 'AddVehicleFailState(vin: $vin)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddVehicleFailState && other.vin == vin;
  }

  @override
  int get hashCode => vin.hashCode;
}
