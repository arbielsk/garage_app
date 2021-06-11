import 'dart:convert';

import 'package:garage_app/model/enum/ignition_status.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/enum/motor_status.dart';

class VehicleState {
  final IgnitionStatus? ignitionStatus;
  final LockStatus? lockStatus;
  final EngineStatus? engineStatus;

  VehicleState({
    this.ignitionStatus,
    this.lockStatus,
    this.engineStatus,
  });

  VehicleState copyWith({
    IgnitionStatus? ignitionStatus,
    LockStatus? lockStatus,
    EngineStatus? motorStatus,
  }) {
    return VehicleState(
      ignitionStatus: ignitionStatus ?? this.ignitionStatus,
      lockStatus: lockStatus ?? this.lockStatus,
      engineStatus: motorStatus ?? this.engineStatus,
    );
  }

  Map<String, String> toMap() {
    return {
      'ignitionStatus': ignitionStatus.toString(),
      'lockStatus': lockStatus.toString(),
      'engineStatus': engineStatus.toString(),
    };
  }

  factory VehicleState.fromMap(Map<String, dynamic> map) {
    return VehicleState(
      ignitionStatus: IgnitionStatus.values
          .firstWhere((e) => e.toString() == map['ignitionStatus']),
      lockStatus: LockStatus.values
          .firstWhere((e) => e.toString() == map['lockStatus']),
      engineStatus: EngineStatus.values
          .firstWhere((e) => e.toString() == map['engineStatus']),
    );
  }

  String toJson() => json.encode(toMap());

  factory VehicleState.fromJson(String source) =>
      VehicleState.fromMap(json.decode(source));

  @override
  String toString() =>
      'VehicleStatus(ignitionStatus: $ignitionStatus, lockStatus: $lockStatus, motorStatus: $engineStatus)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VehicleState &&
        other.ignitionStatus == ignitionStatus &&
        other.lockStatus == lockStatus &&
        other.engineStatus == engineStatus;
  }

  @override
  int get hashCode =>
      ignitionStatus.hashCode ^ lockStatus.hashCode ^ engineStatus.hashCode;
}
