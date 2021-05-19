import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/garage_bloc/bloc.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_bloc.dart';
import 'package:garage_app/data_provider/local_garage_data_provider.dart';
import 'package:garage_app/data_provider/local_vehicle_state_data_provider.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/repository/garage_repository.dart';
import 'package:garage_app/repository/vehicle_state_repository.dart';
import 'package:garage_app/widget/garage_screen.dart';
import 'package:garage_app/widget/vehicle/vehicle_screen.dart';

class VehicleScreenRoute extends StatelessWidget {
  final Vehicle vehicle;

  const VehicleScreenRoute({Key? key, required this.vehicle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final dataProvider = LocalVehicleStateDataProvider();
        final repo = VehicleStateRepository(dataProvider);
        return VehicleBloc(repo, vehicle.vin);
      },
      child: VehicleScreen(vehicle: vehicle, vehicleState: VehicleState()),
    );
  }
}
