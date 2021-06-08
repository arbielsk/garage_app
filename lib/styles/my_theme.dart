import 'package:flutter/material.dart';

final ThemeData myThemeData = ThemeData(
    primarySwatch: Colors.blue,
    textTheme: TextTheme(
      headline4: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 34.0,
        color: Colors.black54,
      ),
      subtitle2: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        color: Colors.black87,
      ),
      caption: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        color: Colors.black38,
      ),
    ),
    appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(padding: EdgeInsets.all(8)),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue.shade600,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    iconTheme: IconThemeData(size: 28.0));
