import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/garage_bloc/bloc.dart';
import 'package:garage_app/bloc/garage_bloc/event.dart';
import 'package:garage_app/bloc/garage_bloc/state.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';

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
                    return VehicleListItem(
                      vehicle: state.vehicles.elementAt(index),
                    );
                  }),
              Positioned(
                bottom: 0,
                child: AddVehicleContainer(),
              ),
            ]);
          }

          if (state is AddVehiclesSuccessState) {
            return Stack(children: [
              ListView.builder(
                  itemCount: state.vehicles.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return VehicleListItem(
                      vehicle: state.vehicles.elementAt(index),
                    );
                  }),
              Positioned(
                bottom: 0,
                child: AddVehicleContainer(),
              ),
            ]);
          }

          if (state is LoadVehiclesFailState) {
            return Container(
                color: Colors.red,
                child: Center(
                  child: Text(state.errorMessage),
                ));
          }

          if (state is AddVehiclesFailState) {
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

class AddVehicleContainer extends StatefulWidget {
  const AddVehicleContainer({
    Key? key,
  }) : super(key: key);

  @override
  _AddVehicleContainerState createState() => _AddVehicleContainerState();
}

class _AddVehicleContainerState extends State<AddVehicleContainer> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 120.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.blueGrey[50],
      child: Column(
        children: [
          TextField(
            textAlign: TextAlign.center,
            controller: controller,
          ),
          ElevatedButton(
              child: Text("Add vehicle"),
              onPressed: () {
                BlocProvider.of<GarageBloc>(context)
                    .add(AddVehiclesEvent(controller.text));
              })
        ],
      ),
    );
  }
}
