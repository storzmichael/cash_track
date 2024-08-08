import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: 'SFProRounded',
  textTheme: const TextTheme(
    bodySmall: TextStyle(fontSize: 12),
    bodyMedium: TextStyle(fontSize: 15),

    headlineSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),

    labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // for small buttons
    labelMedium: TextStyle(fontSize: 16), // for symbols
    labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // for buttons
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.transparent,
    selectedItemColor: Colors.black,
    unselectedItemColor: Colors.white,
  ),
  appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),
);
