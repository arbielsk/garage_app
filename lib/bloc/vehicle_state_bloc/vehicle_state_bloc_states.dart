import 'dart:convert';

import 'package:garage_app/model/vehicle_state.dart';

abstract class VehicleStateBlocStates {}

class VSInitState extends VehicleStateBlocStates {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VSInitState;
  }
}

class VSLoadingState extends VehicleStateBlocStates {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is VSLoadingState;
  }
}

class VSLoadSuccessState extends VehicleStateBlocStates {
  final VehicleState currentVehicleState;

  VSLoadSuccessState(
    this.currentVehicleState,
  );

  VSLoadSuccessState copyWith({
    VehicleState? currentVehicleState,
  }) {
    return VSLoadSuccessState(
      currentVehicleState ?? this.currentVehicleState,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'currentVehicleState': currentVehicleState.toMap(),
    };
  }

  factory VSLoadSuccessState.fromMap(Map<String, dynamic> map) {
    return VSLoadSuccessState(
      VehicleState.fromMap(map['currentVehicleState']),
    );
  }

  String toJson() => json.encode(toMap());

  factory VSLoadSuccessState.fromJson(String source) =>
      VSLoadSuccessState.fromMap(json.decode(source));

  @override
  String toString() =>
      'VSLoadSuccessState(currentVehicleState: $currentVehicleState)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VSLoadSuccessState &&
        other.currentVehicleState == currentVehicleState;
  }

  @override
  int get hashCode => currentVehicleState.hashCode;
}

class VSLoadFailState extends VehicleStateBlocStates {
  final String errorMessage;

  VSLoadFailState(
    this.errorMessage,
  );

  VSLoadFailState copyWith({
    String? errorMessage,
  }) {
    return VSLoadFailState(
      errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'errorMessage': errorMessage,
    };
  }

  factory VSLoadFailState.fromMap(Map<String, dynamic> map) {
    return VSLoadFailState(
      map['errorMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VSLoadFailState.fromJson(String source) =>
      VSLoadFailState.fromMap(json.decode(source));

  @override
  String toString() => 'VSLoadFailState(errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VSLoadFailState && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

class VSSubscriptionFailState extends VehicleStateBlocStates {
  final String errorMessage;
  VSSubscriptionFailState({
    required this.errorMessage,
  });

  VSSubscriptionFailState copyWith({
    String? errorMessage,
  }) {
    return VSSubscriptionFailState(
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'errorMessage': errorMessage,
    };
  }

  factory VSSubscriptionFailState.fromMap(Map<String, dynamic> map) {
    return VSSubscriptionFailState(
      errorMessage: map['errorMessage'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VSSubscriptionFailState.fromJson(String source) =>
      VSSubscriptionFailState.fromMap(json.decode(source));

  @override
  String toString() => 'VSSubscriptionFailState(errorMessage: $errorMessage)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VSSubscriptionFailState &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

class VSUpdatingState extends VehicleStateBlocStates {
  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VSUpdatingState;
  }
}
