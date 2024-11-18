import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/features/events/domain/event_button_item.dart';
import 'package:flutter/material.dart';

class EventButton extends StatelessWidget {
  final EventButtonItem eventButtonItem; // Das EventButtonItem, das die Daten für das Button enthält
  final Color backgroundColor; // Hintergrundfarbe des Buttons
  final Color textColor; // Textfarbe auf dem Button (derzeit nicht verwendet, da nur das Icon angezeigt wird)
  final double borderRadius; // Abrundung des Buttonrahmens
  final double height; // Höhe des Buttons
  final double width; // Breite des Buttons
  final bool fontInBold; // Gibt an, ob der Text fett sein soll (derzeit nicht verwendet)

  // Konstruktor, um die Button-Eigenschaften zu setzen
  const EventButton({
    super.key,
    required this.eventButtonItem,
    this.backgroundColor = primeryColor, // Standardfarbe ist primeryColor aus den App-Konfigurationen
    this.textColor = Colors.black, // Textfarbe (standardmäßig schwarz)
    this.borderRadius = borderRadiusSmallButton, // Standardmäßig kleine Rundung des Buttons
    this.height = 140, // Standardhöhe des Buttons
    this.width = 140, // Standardbreite des Buttons
    this.fontInBold = true, // Standardmäßig ist der Text fett
  });

  @override
  Widget build(BuildContext context) {
    // Der Button wird in einer SizedBox platziert, um Höhe und Breite zu definieren
    return SizedBox(
      height: height, // Höhe des Buttons
      width: width, // Breite des Buttons
      child: ElevatedButton(
        onPressed: () => eventButtonItem
            .eventButtonOnPressed(context), // OnPressed-Aktion des Buttons, ruft die Methode des EventButtonItems auf
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor, // Setzt die Hintergrundfarbe des Buttons
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius), // Rundet die Ecken des Buttons ab
          ),
          padding: const EdgeInsets.all(5), // Setzt das Padding innerhalb des Buttons
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Zentriert die Elemente im Button
            children: [
              // Zeigt das Icon des Buttons an, das aus dem EventButtonItem kommt
              Icon(
                eventButtonItem.eventButtonIcon, // Das Icon aus dem EventButtonItem
                color: Colors.black, // Farbe des Icons
                size: 40, // Größe des Icons
              ),
              const SizedBox(
                height: 5, // Abstand zwischen Icon und Text
              ),
              // Zeigt den Titel des Buttons an, der auch aus dem EventButtonItem kommt
              Text(
                eventButtonItem.eventButtonTitle, // Der Titel des Buttons
                textAlign: TextAlign.center, // Der Text wird zentriert
                maxLines: 1, // Der Text darf nur eine Zeile einnehmen
                overflow: TextOverflow.ellipsis, // Wenn der Text zu lang ist, wird er mit "..." abgeschnitten
                style: Theme.of(context).textTheme.labelLarge, // Setzt den Stil des Textes basierend auf dem App-Theme
              ),
            ],
          ),
        ),
      ),
    );
  }
}
