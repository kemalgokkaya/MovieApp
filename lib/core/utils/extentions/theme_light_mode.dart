import 'package:flutter/material.dart';

final ThemeData CustomLightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white12,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  colorScheme: ColorScheme.light(
    primary: Colors.white,
    secondary: Colors.white,
    background: Colors.white24,
    surface: Colors.white30,
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white10, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.white10),
  ),
);
