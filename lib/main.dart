import 'package:flutter/material.dart';
import 'package:garage_app/widget/garage_route.dart';
import 'package:garage_app/widget/vehicle_screen.dart';

import 'model/enum/ignition_status.dart';
import 'model/enum/lock_status.dart';
import 'model/enum/motor_status.dart';
import 'model/vehicle.dart';
import 'model/vehicle_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _vehicle = Vehicle(
    displayName: "Zielpuls BMW 3",
    model: "BMW M2 CS 3",
    vin: "A1234B1234C1234D3",
  );
  final _vehicleState = VehicleState(
    engineStatus: EngineStatus.ON,
    ignitionStatus: IgnitionStatus.ON,
    lockStatus: LockStatus.OPEN,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: VehicleScreen(
            vehicle: _vehicle,
            vehicleState: _vehicleState,
          ),
        ));
  }
}
