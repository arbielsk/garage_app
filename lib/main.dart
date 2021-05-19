import 'package:flutter/material.dart';
import 'package:garage_app/widget/garage_route.dart';
import 'package:garage_app/widget/vehicle_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: GarageRoute(),
      ),
      routes: <String, WidgetBuilder>{
        // '/vehicleScreen': (BuildContext context) => VehicleScreen(),
      },
    );
  }
}
