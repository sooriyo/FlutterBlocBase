import 'package:flutter/material.dart';
import '../constants/theme_constants.dart';

ThemeData lightTheme() => ThemeData(
  primarySwatch: Colors.blue,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: ThemeConstants.accentColor,
    brightness: Brightness.light,
  ),
  brightness: Brightness.light,
);

ThemeData darkTheme() => ThemeData(
  primarySwatch: Colors.blue,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: ThemeConstants.accentColor,
    brightness: Brightness.dark,
  ),
  brightness: Brightness.dark,
);