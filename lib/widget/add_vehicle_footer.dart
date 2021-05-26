import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/garage_bloc/bloc.dart';
import 'package:garage_app/bloc/garage_bloc/event.dart';
import 'package:garage_app/util/vin_validator.dart';

class AddVehicleFooter extends StatefulWidget {
  @override
  _AddVehicleFooterState createState() => _AddVehicleFooterState();
}

class _AddVehicleFooterState extends State<AddVehicleFooter> {
  final _color = Colors.blueGrey[50];
  static const _containerHeight = 120.0;
  static const _padding = 8.0;
  static const _text = 'Add vehicle';
  bool _isValid = false;
  late TextEditingController _textEditingController;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        padding: EdgeInsets.all(_padding),
        height: _containerHeight,
        color: _color,
        child: Column(children: [
          TextFormField(
            controller: _textEditingController,
            style: TextStyle(color: _isValid ? Colors.black : Colors.red),
            onChanged: (String value) {
              setState(() {
                _isValid = formKey.currentState!.validate();
              });
            },
            validator: (value) {
              if (value != null && !validateVin(value)) {
                return 'Invalid Vin Number';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: _isValid
                ? () {
                    BlocProvider.of<GarageBloc>(context).add(
                        AddVehicleToGarageEvent(_textEditingController.text));
                  }
                : null,
            child: Container(
              padding: EdgeInsets.all(_padding),
              child: Text(
                _text,
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
