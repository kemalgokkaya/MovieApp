import 'package:flutter/material.dart';

final ThemeData customLightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.black,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.black,
    secondary: Colors.black,
    surface: Colors.black,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.black),
  ),
);
