import 'package:flutter/material.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/model/vehicle_state.dart';

class VehicleScreen extends StatelessWidget {
  VehicleState vehicleState;
  Vehicle vehicle;

  VehicleScreen({
    Key? key,
    required this.vehicleState,
    required this.vehicle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
