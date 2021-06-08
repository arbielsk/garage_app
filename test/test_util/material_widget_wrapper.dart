import 'package:flutter/material.dart';
import 'package:garage_app/styles/my_theme.dart';

class MaterialWidgetWrapper extends StatelessWidget {
  final Widget child;

  MaterialWidgetWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: myThemeData,
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }
}
