import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  hintColor: Colors.orange,
  fontFamily: 'SFProRounded',
  textTheme: const TextTheme(
    bodySmall: TextStyle(fontSize: 12),
    bodyMedium: TextStyle(fontSize: 15),

    headlineSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

    labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // for small buttons
    labelMedium: TextStyle(fontSize: 16), // for symbols
    labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // for buttons
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color.fromARGB(255, 255, 255, 255),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 153, 153, 153),
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.white,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: orangeColor,
    ),
  ),
);
