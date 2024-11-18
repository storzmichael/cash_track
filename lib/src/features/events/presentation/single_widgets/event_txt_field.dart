import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/features/events/domain/event_item.dart';
import 'package:flutter/material.dart';

class EventTxtField extends StatelessWidget {
  final EventItem eventItem; // Das EventItem, das die Daten für den Textfeldinhalt enthält

  // Konstruktor des EventTxtField, der das EventItem erwartet
  const EventTxtField({super.key, required this.eventItem});

  @override
  Widget build(BuildContext context) {
    // Padding um das Widget herum, um Abstand vom Rand zu gewährleisten
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          textPadding, textPadding, textPadding, 0), // Padding-Werte aus der App-Konfiguration
      child: Column(
        children: [
          // Zeile, die den Titel des Events und das Datum nebeneinander anzeigt
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Verteilt den Raum gleichmäßig zwischen den Elementen
            crossAxisAlignment: CrossAxisAlignment.start, // Ordnet die Elemente am oberen Rand der Zeile aus
            children: [
              Text(eventItem.eventTitle), // Zeigt den Titel des Events an
              Text(eventItem.eventDate), // Zeigt das Datum des Events an
            ],
          ),
          const Divider(), // Trennt den Inhalt visuell ab
        ],
      ),
    );
  }
}
