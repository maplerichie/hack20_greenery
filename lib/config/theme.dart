import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.green,
  primaryColor: Colors.green[700],
  primaryColorLight: Colors.green,
  buttonTheme: ButtonThemeData(
    padding: EdgeInsets.symmetric(vertical: 16),
    disabledColor: Colors.white.withOpacity(0.1),
  ),
  cursorColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
      // focusedBorder: InputBorder.none,
      // border: InputBorder.none,
      ),
);
