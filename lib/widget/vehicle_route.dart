import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_bloc.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_state_events.dart';
import 'package:garage_app/data_provider/local_vehicle_state_data_provider.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/repository/vehicle_state_repository.dart';
import 'package:garage_app/widget/vehicle_screen.dart';

class VehicleRoute extends StatelessWidget {
  VehicleRoute(this._vehicle);

  final Vehicle _vehicle;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final dataProvider = LocalVehicleStateDataProvider();
        final repository = VehicleStateRepository(dataProvider);
        return VehicleBloc(repository, _vehicle.vin);
      },
      child: VehicleScreen(vehicle: _vehicle),
    );
  }
}
