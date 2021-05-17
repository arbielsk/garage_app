import 'package:flutter/material.dart';

class MaterialWidgetWrapper extends StatelessWidget {
  final Widget child;

  MaterialWidgetWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }
}
