import 'package:flutter/material.dart';

class VehicleStateListItem extends StatelessWidget {
  final String stateVal;
  VehicleStateListItem({
    Key? key,
    required this.stateVal,
  }) : super(key: key);

  final padding = EdgeInsets.all(16.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(stateVal,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subtitle1),
    );
  }
}
