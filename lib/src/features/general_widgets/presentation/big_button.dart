import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  final String buttonName; // Der Name des Buttons (Text, der angezeigt wird)
  final VoidCallback? onPressed; // Callback-Funktion, die beim Drücken des Buttons aufgerufen wird
  final Color backgroundColor; // Hintergrundfarbe des Buttons
  final Color textColor; // Textfarbe des Buttons
  final double borderRadius; // Die Rundung der Ecken des Buttons
  final bool fontInBold; // Bestimmt, ob der Text fett angezeigt wird
  final EdgeInsetsGeometry padding; // Padding innerhalb des Buttons
  final int maxLines; // Maximale Anzahl der Zeilen für den Text im Button

  // Konstruktor des BigButton mit optionalen Parametern
  const BigButton({
    super.key,
    required this.buttonName, // Der Name des Buttons (Pflichtparameter)
    required this.onPressed, // Die Funktion, die beim Drücken des Buttons aufgerufen wird (Pflichtparameter)
    this.backgroundColor = primeryColor, // Hintergrundfarbe (Standard: primeryColor)
    this.textColor = Colors.black, // Textfarbe (Standard: schwarz)
    this.borderRadius = borderRadiusLargeButton, // Rundung der Ecken (Standard: borderRadiusLargeButton)
    this.fontInBold = true, // Schriftstärke (Standard: fett)
    this.padding = const EdgeInsets.symmetric(
        horizontal: 5.0), // Padding innerhalb des Buttons (Standard: horizontaler Abstand von 5.0)
    this.maxLines = 1, // Maximale Anzahl der Textzeilen (Standard: 1)
  });

  @override
  Widget build(BuildContext context) {
    // Der Build-Method, der das UI-Widget für den Button zurückgibt
    return ElevatedButton(
      onPressed: onPressed, // Die Funktion, die beim Drücken des Buttons aufgerufen wird
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor, // Setzt die Hintergrundfarbe
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius), // Rundet die Ecken des Buttons
        ),
        padding: padding, // Setzt das Padding innerhalb des Buttons
      ),
      child: Center(
        // Zentriert den Text innerhalb des Buttons
        child: Text(
          buttonName, // Der Text des Buttons
          textAlign: TextAlign.center, // Der Text wird zentriert angezeigt
          maxLines: maxLines, // Limitiert die Anzahl der Textzeilen auf maxLines
          overflow: TextOverflow.ellipsis, // Definiert das Verhalten bei Textüberlauf (zeigt "..." an)
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: textColor, // Textfarbe des Buttons
                fontWeight: fontInBold ? FontWeight.bold : FontWeight.normal, // Bestimmt die Schriftstärke
              ),
        ),
      ),
    );
  }
}
