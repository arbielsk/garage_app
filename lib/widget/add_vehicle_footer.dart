import 'package:flutter/material.dart';

class AddVehicleFooter extends StatelessWidget {
  static const _containerHeight = 120.0;
  static const _padding = 8.0;
  static const _text = 'Add vehicle';
  final _color = Colors.blueGrey[50];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_padding),
      height: _containerHeight,
      color: _color,
      child: Column(children: [
        TextField(),
        ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.all(8))),
          onPressed: () {
            print('tapped');
          },
          child: Text(
            _text,
          ),
        ),
      ]),
    );
  }
}
