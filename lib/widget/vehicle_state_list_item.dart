import 'package:flutter/material.dart';

class VehicleStateListItem extends StatelessWidget {
  final String stateVal;
  VehicleStateListItem({
    Key? key,
    required this.stateVal,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          stateVal,
          style: textTheme.subtitle1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
