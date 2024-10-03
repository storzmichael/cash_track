import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class ButtonCategoryCustom extends StatelessWidget {
  final String categoryTitle; // Titel der Kategorie, der auf dem Button angezeigt wird
  final VoidCallback onPressed; // Callback-Funktion, die bei Klick auf den Button ausgeführt wird
  final Color backgroundColor; // Hintergrundfarbe des Buttons
  final Color textColor; // Textfarbe des Buttons
  final double borderRadius; // Radius der abgerundeten Ecken des Buttons
  final double height; // Höhe des Buttons
  final double width; // Breite des Buttons
  final bool fontInBold; // Bestimmt, ob der Text fett dargestellt wird
  final Widget? child; // Optionales Kind-Widget, falls zusätzliche Inhalte angezeigt werden sollen
  final int maxLines; // Maximale Anzahl der Textzeilen auf dem Button

  const ButtonCategoryCustom({
    super.key,
    required this.categoryTitle, // Der Titel der Kategorie ist erforderlich
    required this.onPressed, // Die Aktion bei Knopfdruck ist erforderlich
    this.backgroundColor = greenColor, // Standard-Hintergrundfarbe ist grün
    this.textColor = Colors.white, // Standard-Textfarbe ist weiß
    this.borderRadius = borderRadiusSmallButton, // Standardradius für abgerundete Ecken
    this.height = double.infinity, // Standardmäßig die volle verfügbare Höhe
    this.width = 104, // Standardbreite des Buttons
    this.fontInBold = false, // Standardmäßig ist der Text nicht fett
    this.child, // Optionales Kind-Widget, Standard ist null
    this.maxLines = 2, // Standardmäßig maximal 2 Textzeilen
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // Setzt die Höhe des Buttons
      width: width, // Setzt die Breite des Buttons
      child: ElevatedButton(
        onPressed: onPressed, // Setzt die Funktion, die bei Knopfdruck aufgerufen wird
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Hintergrundfarbe des Buttons
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius), // Setzt die abgerundeten Ecken
          ),
          padding: const EdgeInsets.symmetric(horizontal: 5), // Innenabstand des Buttons
        ),
        child: Center(
          child: Text(
            categoryTitle, // Zeigt den Titel der Kategorie an
            textAlign: TextAlign.center, // Zentrierte Textausrichtung
            maxLines: maxLines, // Maximale Anzahl der Zeilen
            overflow: TextOverflow.ellipsis, // Textüberlauf wird mit Punkten angezeigt
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: textColor, // Setzt die Textfarbe
                  fontWeight: fontInBold ? FontWeight.bold : FontWeight.normal, // Setzt die Schriftstärke
                ),
          ),
        ),
      ),
    );
  }
}
