import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  hintColor: primeryColor,
  textTheme: GoogleFonts.poppinsTextTheme(
    // Hier wird die Poppins-Schriftart geladen
    const TextTheme(
      bodySmall: TextStyle(fontSize: 12),
      bodyMedium: TextStyle(fontSize: 15),
      headlineSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // for small buttons
      labelMedium: TextStyle(fontSize: 16), // for symbols
      labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // for buttons
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: lightThemeList[0],
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lightThemeList[1],
    selectedItemColor: Colors.black,
    unselectedItemColor: whiteColor,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primeryColor,
    ),
  ),
);
