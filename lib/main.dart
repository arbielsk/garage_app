import 'package:flutter/material.dart';
import 'package:garage_app/widget/garage_route.dart';

void main() {
  runApp(MyApp());
}

final mainScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: mainScaffoldMessengerKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: GarageRoute(),
      ),
    );
  }
}
