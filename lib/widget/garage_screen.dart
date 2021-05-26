import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/garage_bloc/bloc.dart';
import 'package:garage_app/bloc/garage_bloc/state.dart';
import 'package:garage_app/main.dart';
import 'package:garage_app/widget/add_vehicle_footer.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';
import 'package:garage_app/widget/vehicle_route.dart';

class GarageScreen extends StatelessWidget {
  static const _color = Colors.blueGrey;
  static const _text = 'Garage';
  static GlobalKey globalStackKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        title: Text(_text),
      ),
      body: BlocBuilder<GarageBloc, GarageBlocState>(
        builder: (context, state) {
          print(state);
          if (state is InitialState ||
              state is LoadVehiclesState ||
              state is AddVehicleState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoadVehiclesSuccessState) {
            return Stack(key: globalStackKey, children: [
              ListView.builder(
                  itemCount: state.vehicles.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VehicleRoute(state.vehicles[index]),
                        ),
                      ),
                      child: VehicleListItem(
                        vehicle: state.vehicles.elementAt(index),
                      ),
                    );
                  }),
              Align(
                alignment: Alignment.bottomCenter,
                child: AddVehicleFooter(),
              ),
            ]);
          }

          if (state is LoadVehiclesFailState) {
            return Container(
                color: Colors.red,
                child: Center(
                  child: Text(state.errorMessage.toString()),
                ));
          }

          if (state is AddVehicleSuccessState) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              mainScaffoldMessengerKey.currentState!.showSnackBar(
                new SnackBar(
                  content: Text(
                    'Vehicle with vin ${state.vin} has been successfully added',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            });
          }
          if (state is AddVehicleFailState) {
            WidgetsBinding.instance!.addPostFrameCallback((_) {
              mainScaffoldMessengerKey.currentState!.showSnackBar(
                new SnackBar(
                  content: Text(
                    'Vehicle with vin ${state.vin} could not be added',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            });
          }
          return Container();
        },
      ),
    );
  }
}
