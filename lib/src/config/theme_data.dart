import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Definition des Light-Themes für die Anwendung
ThemeData lightTheme = ThemeData(
  hintColor: primeryColor, // Farbe für Hinweise (z. B. in Eingabefeldern)
  textTheme: GoogleFonts.poppinsTextTheme(
    // Lädt die Schriftart "Poppins" für den Text in der gesamten App
    const TextTheme(
      bodySmall: TextStyle(fontSize: 12), // Textgröße für kleinere Texte
      bodyMedium: TextStyle(fontSize: 15), // Textgröße für mittlere Texte
      headlineSmall: TextStyle(fontSize: 15, fontWeight: FontWeight.bold), // Fettgedruckte Überschrift in kleiner Größe
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), // Fettgedruckte große Überschrift
      labelSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), // Für kleine Schaltflächen
      labelMedium: TextStyle(fontSize: 16), // Für Symbole oder mittlere Labels
      labelLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Für große Schaltflächen
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: lightThemeList[0], // Hintergrundfarbe der App-Leiste
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lightThemeList[1], // Hintergrundfarbe der unteren Navigationsleiste
    selectedItemColor: Colors.black, // Farbe für ausgewählte Elemente
    unselectedItemColor: whiteColor, // Farbe für nicht ausgewählte Elemente
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primeryColor, // Textfarbe für TextButtons
    ),
  ),
);
