import 'dart:async';

import 'package:garage_app/data_provider/vehicle_state_data_provider.dart';
import 'package:garage_app/model/enum/ignition_status.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/enum/motor_status.dart';

class LocalVehicleStateDataProvider implements VehicleStateDataProvider {
  final initialVehicleState = {
    'ignitionStatus': IgnitionStatus.OFF.toString(),
    'lockStatus': LockStatus.LOCKED.toString(),
    'engineStatus': EngineStatus.OFF.toString(),
  };

  static const _tickInterval = Duration(seconds: 5);

  final Map<String, Map<String, String>> vehicleStates = {};

  final Map<String, StreamController<Map<String, String>>> activeStreams = {};

  @override
  Stream<Map<String, String>> subscribeVehicleState(String vin) {
    _initializeVehicleState(vin);

    if (activeStreams.containsKey(vin)) {
      return activeStreams[vin]!.stream;
    }

    Timer? timer;
    // ignore: close_sinks
    StreamController<Map<String, String>>? controller;

    controller = StreamController<Map<String, String>>(
      onListen: () {
        timer = Timer.periodic(_tickInterval, (_) {
          _emitVehicleState(vin);
        });
        _emitVehicleState(vin);
      },
      onCancel: () {
        timer!.cancel();
        controller!.close();
        if (!controller.hasListener) {
          activeStreams.remove(vin);
        }
      },
    );

    activeStreams.putIfAbsent(vin, () => controller!);

    return controller.stream;
  }

  void _initializeVehicleState(vin) {
    if (!vehicleStates.containsKey(vin)) {
      _addInitialState(vin);
    }
  }

  void _emitVehicleState(vin) {
    if (activeStreams.containsKey(vin)) {
      activeStreams[vin]!.add(vehicleStates[vin]!);
    }
  }

  @override
  void updateVehicleState(String vin, Map<String, String> newState) {
    vehicleStates[vin] = newState;
    _emitVehicleState(vin);
  }

  void _addInitialState(String vin) {
    vehicleStates.putIfAbsent(vin, () => initialVehicleState);
  }
}
