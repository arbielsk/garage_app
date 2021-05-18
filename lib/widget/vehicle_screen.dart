import 'package:flutter/material.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';
import 'package:garage_app/widget/vehicle_state_list_item.dart';

class VehicleScreen extends StatelessWidget {
  VehicleState vehicleState;
  Vehicle vehicle;

  VehicleScreen({Key? key, required this.vehicleState, required this.vehicle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(VehicleScreenConstants.title),
            centerTitle: true,
            backgroundColor: VehicleScreenConstants.appBarColor),
        body: Column(
          children: [
            VehicleListItem(vehicle: vehicle),
            Expanded(
              child: ListView.builder(
                itemCount: vehicleState.toMap().length,
                itemBuilder: (BuildContext context, int index) {
                  var vehicleStateMap = vehicleState.toMap();
                  return VehicleStateListItem(
                      stateVal: vehicleStateMap.values.elementAt(index));
                },
              ),
            )
          ],
        ));
  }
}

class VehicleScreenConstants {
  static const title = 'Vehicle';
  static const appBarColor = Colors.blueGrey;
}
