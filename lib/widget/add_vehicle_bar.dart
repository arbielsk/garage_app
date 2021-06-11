import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/garage_bloc/bloc.dart';
import 'package:garage_app/bloc/garage_bloc/event.dart';
import 'package:garage_app/util/vin_validator.dart';

class AddVehicleBar extends StatefulWidget {
  final VoidCallback addVehicleCallback;

  AddVehicleBar({required this.addVehicleCallback});
  @override
  _AddVehicleBarState createState() => _AddVehicleBarState();
}

class _AddVehicleBarState extends State<AddVehicleBar> {
  final _color = Colors.blueGrey[50];
  static const _containerHeight = 120.0;
  static const _padding = 8.0;
  static const _text = 'Add vehicle';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();
  bool validVin = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_padding),
      height: _containerHeight,
      color: _color,
      child: Column(children: [
        Flexible(
          child: TextFormField(
            key: _formKey,
            controller: _controller,
            autovalidateMode: AutovalidateMode.always,
            style: TextStyle(color: validVin ? Colors.black : Colors.red),
            onChanged: (String value) {
              if (value.isNotEmpty) {
                setState(() {
                  validVin = validateVin(value);
                });
              }
            },
            validator: (String? value) {
              if (!validVin && _controller.text.isNotEmpty) {
                return 'Invalid vin';
              } else {
                return null;
              }
            },
          ),
        ),
        Flexible(
          child: ElevatedButton(
            onPressed: validVin
                ? () {
                    BlocProvider.of<GarageBloc>(context)
                        .add(AddVehicleEvent(_controller.text));
                    widget.addVehicleCallback();
                  }
                : null,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                _text,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
