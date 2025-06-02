import 'package:flutter/material.dart';

final ThemeData customLightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.white,
    secondary: Colors.white,
    surface: Colors.white,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.white),
  ),
);
