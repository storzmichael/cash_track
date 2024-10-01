import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/features/order/domain/product_item.dart';
import 'package:flutter/material.dart';

class ButtonProductCustom extends StatelessWidget {
  final ProductItem productItem; // Produktdaten, die auf dem Button angezeigt werden
  final VoidCallback onPressed; // Callback-Funktion, die bei Klick auf den Button ausgeführt wird
  final Color backgroundColor; // Hintergrundfarbe des Buttons
  final Color textColor; // Textfarbe des Buttons
  final double borderRadius; // Radius der abgerundeten Ecken des Buttons
  final double height; // Höhe des Buttons
  final double width; // Breite des Buttons
  final bool fontInBold; // Bestimmt, ob der Text fett dargestellt wird
  final int maxLines; // Maximale Anzahl der Textzeilen auf dem Button

  const ButtonProductCustom({
    super.key,
    required this.productItem, // Erforderlich: Das Produkt, das dargestellt wird
    required this.onPressed, // Erforderlich: Die Funktion, die bei Knopfdruck ausgeführt wird
    this.backgroundColor = productColor, // Standardfarbe des Buttons
    this.textColor = Colors.black, // Standardtextfarbe
    this.borderRadius = borderRadiusSmallButton, // Standardradius der Ecken
    this.height = 60, // Standardhöhe des Buttons
    this.width = 80, // Standardbreite des Buttons
    this.fontInBold = false, // Standardmäßig kein fetter Text
    this.maxLines = 2, // Standardmäßig maximal 2 Zeilen Text
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, // Höhe des Buttons
      width: width, // Breite des Buttons
      child: ElevatedButton(
        onPressed: onPressed, // Setzt die Funktion, die bei Knopfdruck ausgeführt wird
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Hintergrundfarbe des Buttons
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius), // Abgerundete Ecken
          ),
          padding: const EdgeInsets.all(5), // Innenabstand
        ),
        child: Center(
          child: Text(
            productItem.productTitle, // Zeigt den Produktnamen an
            textAlign: TextAlign.center, // Zentrierter Text
            maxLines: maxLines, // Maximale Anzahl der Zeilen
            overflow: TextOverflow.ellipsis, // Textüberlauf wird abgeschnitten und mit Punkten dargestellt
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: textColor, // Textfarbe
                  fontWeight: fontInBold ? FontWeight.bold : FontWeight.normal, // Schriftstärke
                ),
          ),
        ),
      ),
    );
  }
}
