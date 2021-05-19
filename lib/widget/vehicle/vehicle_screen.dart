import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_bloc.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_bloc_state.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/repository/vehicle_state_repository.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';
import 'package:garage_app/widget/vehicle_state_list_item.dart';

class VehicleScreen extends StatelessWidget {
  static const _title = 'Vehicle';
  static const _appBarBackgroundColor = Colors.blueGrey;

  final VehicleState vehicleState;
  final Vehicle vehicle;
  VehicleScreen({
    Key? key,
    required this.vehicleState,
    required this.vehicle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: _appBarBackgroundColor,
            title: Text(_title),
          ),
          body: BlocBuilder<VehicleBloc, VehicleStateBloc>(
            builder: (BuildContext context, state) {
              return state.when(
                initial: () => Center(child: CircularProgressIndicator()),
                load: () => Center(child: CircularProgressIndicator()),
                loaded: (vehicleState) {
                  return Column(
                    children: [
                      VehicleListItem(
                        vehicle: vehicle,
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: VehicleStateListItem(
                                stateVal:
                                    vehicleState.ignitionStatus.toString()),
                          ),
                          VehicleStateListItem(
                              stateVal: vehicleState.lockStatus.toString()),
                          VehicleStateListItem(
                              stateVal: vehicleState.engineStatus.toString()),
                        ],
                      ),
                    ],
                  );
                },
                failed: (error) => Center(child: Text(error)),
              );
            },
          )),
    );
  }
}
