import 'package:flutter/material.dart';

final ThemeData customDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.white,

  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.dark(
    primary: Colors.white,
    secondary: Colors.white,
    surface: const Color.fromARGB(255, 255, 255, 255),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
    bodyMedium: TextStyle(color: Colors.white),
  ),
);
