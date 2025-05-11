import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade200,
    tertiary: Colors.white,
    inversePrimary: Colors.grey.shade900,
    scrim: const Color(0xFF000000),
    shadow: Colors.grey.shade200,
    error: const Color(0xffe90052),
  ),
  fontFamily: 'Roboto',
);
ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade600,
    secondary: const Color.fromARGB(255, 57, 57, 57),
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
    scrim: const Color(0xFF000000),
    shadow: Colors.grey.shade200,
    error: const Color(0xffe90052),
  ),
  fontFamily: 'Roboto',
);
