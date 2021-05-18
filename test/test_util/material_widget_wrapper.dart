import 'package:flutter/material.dart';

class MaterialWidgetWrapper extends StatelessWidget {
  final Widget child;

  MaterialWidgetWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          headline4: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 34.0,
            color: Colors.green,
          ),
          subtitle2: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 34.0,
            color: Colors.green,
          ),
          caption: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            fontSize: 34.0,
            color: Colors.green,
          ),
        ),
      ),
      home: Scaffold(
        body: Center(
          child: child,
        ),
      ),
    );
  }
}
