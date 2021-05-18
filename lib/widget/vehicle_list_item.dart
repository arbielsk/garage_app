import 'package:flutter/material.dart';
import 'package:garage_app/model/enum/ignition_status.dart';
import 'package:garage_app/model/enum/lock_status.dart';
import 'package:garage_app/model/enum/motor_status.dart';
import 'package:garage_app/model/vehicle.dart';
import 'package:garage_app/model/vehicle_state.dart';
import 'package:garage_app/widget/vehicle_screen.dart';

class VehicleListItem extends StatelessWidget {
  final Vehicle vehicle;

  static const _height = 120.0;
  static const _padding = 8.0;
  static const _iconSize = 60.0;
  static const _inkWellColor = Colors.yellow;
  static const _headerHorizontalSpacing = 16.0;

  VehicleListItem({
    Key? key,
    required this.vehicle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(_padding),
      height: _height,
      color: Colors.white,
      child: InkWell(
        splashColor: _inkWellColor,
        highlightColor: _inkWellColor,
         onTap: () => Navigator.of(context).push(MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return VehicleScreen(
                vehicleState: VehicleState(
                    engineStatus: EngineStatus.ON,
                    ignitionStatus: IgnitionStatus.OFF,
                    lockStatus: LockStatus.LOCKED),
                vehicle: vehicle);
          },
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.anchor,
                  size: _iconSize,
                ),
                SizedBox(
                  width: _headerHorizontalSpacing,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.displayName,
                      style: textTheme.headline4,
                    ),
                    Text(
                      vehicle.model,
                      style: textTheme.subtitle2,
                    ),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  vehicle.vin,
                  style: textTheme.caption,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
