import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/vehicle_state_bloc/vehicle_state_bloc.dart';
import 'package:garage_app/data_provider/local_vehicle_state_data_provider.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/repository/vehicle_state_repository.dart';
import 'package:garage_app/widget/vehicle_screen.dart';

class VehicleRoute extends StatelessWidget {
  final Vehicle vehicle;

  VehicleRoute(this.vehicle);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final dataProvider = LocalVehicleStateDataProvider();
        final repo = VehicleStateRepository(dataProvider);
        return VehicleStateBloc(repo, vehicle.vin);
      },
      child: VehicleScreen(vehicle: vehicle),
    );
  }
}
