import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class OutlinedBigButton extends StatelessWidget {
  final String buttonName; // Text für das Button-Label
  final VoidCallback onPressed; // Callback-Funktion, die beim Drücken des Buttons aufgerufen wird
  final Color backgroundColor; // Hintergrundfarbe des Buttons (Standard: transparent)
  final Color borderColor; // Randfarbe des Buttons (Standard: primeryColor)
  final Color textColor; // Textfarbe des Buttons (Standard: schwarz)
  final double borderRadius; // Eckenradius des Buttons (Standard: borderRadiusLargeButton)
  final double height; // Höhe des Buttons (Standard: double.infinity)
  final double width; // Breite des Buttons (Standard: double.infinity)
  final bool fontInBold; // Schriftart (fett oder normal, Standard: fett)
  final double borderWidth; // Randbreite des Buttons (Standard: 2.0)
  final int maxLines; // Maximale Anzahl an Textzeilen (Standard: 1)

  const OutlinedBigButton({
    super.key,
    required this.buttonName, // Benötigtes Button-Label
    required this.onPressed, // Benötigte Callback-Funktion
    this.backgroundColor = Colors.transparent, // Standardhintergrund: transparent
    this.borderColor = primeryColor, // Standardrandfarbe: primeryColor
    this.textColor = Colors.black, // Standardtextfarbe: schwarz
    this.borderRadius = borderRadiusLargeButton, // Standardeckenradius: borderRadiusLargeButton
    this.height = double.infinity, // Standardhöhe: double.infinity
    this.width = double.infinity, // Standardbreite: double.infinity
    this.fontInBold = true, // Standardmäßig fetter Text
    this.borderWidth = 2.0, // Standardrandbreite: 2.0
    this.maxLines = 1, // Standard: 1 Zeile Text
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // Setze die Höhe des Buttons
      width: width, // Setze die Breite des Buttons
      child: OutlinedButton(
        onPressed: onPressed, // Aktion des Buttons
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor, // Setze die Hintergrundfarbe
          side: BorderSide(color: borderColor, width: borderWidth), // Randfarbe und -breite
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius), // Eckenrundung des Buttons
          ),
          padding: const EdgeInsets.all(5), // Padding innerhalb des Buttons
        ),
        child: Center(
          child: Text(
            buttonName, // Button-Text
            textAlign: TextAlign.center, // Zentriere den Text
            maxLines: maxLines, // Begrenze die Anzahl der Textzeilen
            overflow: TextOverflow.ellipsis, // Verhindere Textüberlauf
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: textColor, // Setze die Textfarbe
                  fontWeight: fontInBold ? FontWeight.bold : FontWeight.normal, // Setze die Schriftstärke
                ),
          ),
        ),
      ),
    );
  }
}
