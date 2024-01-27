import 'package:flutter/material.dart';

ThemeData buildAppTheme() {
  return ThemeData(
    primarySwatch: Colors.red,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: const Color(0xFF8B0000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF8B0000),
        foregroundColor: Colors.white,
      ),
    ),
  );
}
