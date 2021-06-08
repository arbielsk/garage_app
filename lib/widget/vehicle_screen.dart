import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/garage_bloc/state.dart';
import 'package:garage_app/bloc/vehicle_state_bloc/vehicle_state_bloc.dart';
import 'package:garage_app/bloc/vehicle_state_bloc/vehicle_state_bloc_states.dart';
import 'package:garage_app/bloc/vehicle_state_bloc/vehicle_state_events.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';
import 'package:garage_app/widget/vehicle_state_list_item.dart';

class VehicleScreen extends StatelessWidget {
  static const _title = 'Vehicle';
  static GlobalKey columnKey = GlobalKey();

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
          title: Text(_title),
        ),
        body: Column(
          key: columnKey,
          children: [
            VehicleListItem(
              vehicle: vehicle,
            ),
            BlocBuilder<VehicleStateBloc, VehicleStateBlocStates>(
                builder: (context, state) {
              if (state is InitialState ||
                  state is VSLoadingState ||
                  state is VSUpdatingState) {
                return Center(
                  child: Container(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              if (state is VSLoadSuccessState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        VehicleStateListItem(
                            stateVal: state.currentVehicleState.lockStatus
                                .toString()),
                        VehicleStateListItem(
                            stateVal: state.currentVehicleState.ignitionStatus
                                .toString()),
                        VehicleStateListItem(
                            stateVal: state.currentVehicleState.engineStatus
                                .toString()),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<VehicleStateBloc>(context).add(
                            UpdateLockStatusEvent(
                                vehicle.vin, state.currentVehicleState));
                      },
                      child: Text(state.currentVehicleState.lockStatus ==
                              LockStatus.LOCKED
                          ? 'Unlock'
                          : 'Lock'),
                    ),
                  ],
                );
              }
              return Container();
            }),
          ],
        ),
      ),
    );
  }
}
