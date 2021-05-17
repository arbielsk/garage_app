import 'package:flutter/material.dart';
import 'package:garage_app/model/enum/ignition_status.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/enum/motor_status.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';

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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Container(
            color: Colors.green,
            child: Center(
              child: VehicleListItem(
                vehicle: _vehicle,
              ),
            ),
          ),
        ));
  }
}
