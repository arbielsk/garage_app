import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/garage_bloc/bloc.dart';
import 'package:garage_app/bloc/garage_bloc/state.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/widget/vehicle/vehicle_screen_route.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';
import 'package:garage_app/widget/vehicle/vehicle_screen.dart';

class GarageScreen extends StatelessWidget {
  static const _color = Colors.blueGrey;
  static const _text = 'Garage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text(_text),
      ),
      body: BlocBuilder<GarageBloc, GarageBlocState>(
        builder: (context, state) {
          if (state is InitialState || state is LoadVehiclesState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LoadVehiclesSuccessState) {
            return Stack(children: [
              ListView.builder(
                  itemCount: state.vehicles.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return VehicleScreenRoute(
                            vehicle: state.vehicles[index]);
                      })),
                      child: VehicleListItem(vehicle: state.vehicles[index]),
                    );
                  })
            ]);
          }

          if (state is LoadVehiclesFailState) {
            return Container(
                color: Colors.red,
                child: Center(
                  child: Text(state.errorMessage),
                ));
          }
          return Container();
        },
      ),
    );
  }
}
