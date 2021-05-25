import 'package:flutter/material.dart';

class GarageScreenFrontLayer extends StatelessWidget {
  static const _padding = 8.0;
  static const _height = 120.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      width: double.infinity,
      color: Colors.blueGrey[50],
      padding: EdgeInsets.all(_padding),
      child: Column(
        children: [
          TextField(),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.all(_padding),
              ),
            ),
            onPressed: () => print('I was pressed'),
            child: Text('Add vehicle'),
          ),
        ],
      ),
    );
  }
}
