import 'package:flutter/material.dart';
import 'package:garage_app/model/vehicle.dart';

class VehicleListItem extends StatelessWidget {
  final Vehicle vehicle;

  static const _height = 120.0;

  VehicleListItem({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
    );
  }
}
