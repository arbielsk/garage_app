import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_bloc.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_bloc_state.dart';
import 'package:garage_app/bloc/vehicle_bloc/vehicle_state_events.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';
import 'package:garage_app/widget/vehicle_state_list_item.dart';

class VehicleScreen extends StatelessWidget {
  static const _title = 'Vehicle';
  static const _appBarBackgroundColor = Colors.blueGrey;
  static const _opentText = 'Unlock';
  static const _lockText = 'Lock';

  final Vehicle vehicle;
  VehicleScreen({
    Key? key,
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
          body: BlocBuilder<VehicleBloc, VehicleBlocState>(
            builder: (context, state) {
              if (state is LoadingVehicleBlocState ||
                  state is InitialVehicleBlocState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is LoadedVehicleBlocState) {
                return Column(
                  children: [
                    VehicleListItem(
                      vehicle: vehicle,
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        VehicleStateListItem(
                            stateVal: state.vehicleState.lockStatus.toString()),
                        VehicleStateListItem(
                            stateVal:
                                state.vehicleState.ignitionStatus.toString()),
                        VehicleStateListItem(
                            stateVal:
                                state.vehicleState.engineStatus.toString()),
                      ],
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(8.0))),
                        onPressed: () {
                          BlocProvider.of<VehicleBloc>(context)
                            ..add(UpdateVehicleStateEvent(
                                vehicle.vin,
                                VehicleState(
                                    engineStatus:
                                        state.vehicleState.engineStatus,
                                    ignitionStatus:
                                        state.vehicleState.ignitionStatus,
                                    lockStatus: state.vehicleState.lockStatus ==
                                            LockStatus.LOCKED
                                        ? LockStatus.OPEN
                                        : LockStatus.LOCKED)));
                        },
                        child: Text(
                          state.vehicleState.lockStatus == LockStatus.OPEN
                              ? _lockText
                              : _opentText,
                          style: Theme.of(context).textTheme.subtitle2,
                        ))
                  ],
                );
              }
              return Container(
                color: Colors.red,
                child: Center(
                  child: Text('error'),
                ),
              );
            },
          )),
    );
  }
}
