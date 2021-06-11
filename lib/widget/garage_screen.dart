import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/garage_bloc/bloc.dart';
import 'package:garage_app/bloc/garage_bloc/state.dart';
import 'package:garage_app/main.dart';
import 'package:garage_app/widget/add_vehicle_bar.dart';
import 'package:garage_app/widget/custom_appbar.dart';
import 'package:garage_app/widget/custom_gesturedetector_widget.dart';
import 'package:garage_app/widget/vehicle_list_item.dart';
import 'package:garage_app/widget/vehicle_route.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GarageScreen extends StatefulWidget {
  static GlobalKey stackKey = GlobalKey();

  @override
  _GarageScreenState createState() => _GarageScreenState();
}

class _GarageScreenState extends State<GarageScreen> {
  bool _isBarVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isGestureDetectorAvailable: _isBarVisible,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.garageText),
        ),
        onTap: _changeVisibility,
      ),
      body: BlocBuilder<GarageBloc, GarageBlocState>(
        builder: (context, state) {
          if (state is InitialState ||
              state is LoadVehiclesState ||
              state is AddVehicleState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is LoadVehiclesSuccessState) {
            return Stack(key: GarageScreen.stackKey, children: [
              CustomGestureDetectorWidget(
                  child: ListView.builder(
                      itemCount: state.vehicles.length,
                      itemBuilder: (BuildContext ctx, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _isBarVisible = false;
                            });
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    VehicleRoute(state.vehicles[index])));
                          },
                          child: VehicleListItem(
                            vehicle: state.vehicles.elementAt(index),
                          ),
                        );
                      }),
                  isGestureDetectorAvailable: _isBarVisible,
                  onTap: _changeVisibility),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    duration: Duration(seconds: 1),
                    height: !_isBarVisible ? 0 : 120,
                    child:
                        AddVehicleBar(addVehicleCallback: _changeVisibility)),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: IgnorePointer(
                    ignoring: _isBarVisible,
                    child: AnimatedOpacity(
                      opacity: _isBarVisible ? 0 : 1,
                      duration: Duration(seconds: 1),
                      child: Padding(
                        padding: EdgeInsets.only(right: 25, bottom: 25),
                        child: FloatingActionButton(
                          onPressed: _changeVisibility,
                          child: Icon(
                            Icons.add_box_outlined,
                          ),
                        ),
                      ),
                    ),
                  )),
            ]);
          }

          if (state is LoadVehiclesFailState) {
            _showSnackBar(
                message: 'Something went wrong: ${state.errorMessage}',
                color: Colors.grey);
          }

          if (state is AddVehicleFailState) {
            _showSnackBar(
                color: Colors.red,
                message:
                    'Vehicle with vin ${state.vinNumber} could not be added.');
          }

          if (state is AddVehicleSuccessState) {
            _showSnackBar(
                color: Colors.green,
                message:
                    'Vehicle with vin ${state.vinNumber} has been successfully added');
          }

          return Container();
        },
      ),
    );
  }

  void _changeVisibility() {
    setState(() {
      _isBarVisible = !_isBarVisible;
    });
  }

  void _showSnackBar({required Color color, required String message}) async {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      globalScaffoldMessenger.currentState!.showSnackBar(
        new SnackBar(
          backgroundColor: color,
          content: Text(message),
        ),
      );
    });
  }
}
