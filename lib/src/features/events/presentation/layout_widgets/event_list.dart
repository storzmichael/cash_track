import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/application/event_functions.dart';
import 'package:cash_track/src/features/events/data/event_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // Dekoriert den Container mit der Hintergrundfarbe und abgerundeten Ecken
        decoration: BoxDecoration(
          color: textFieldColor, // Hintergrundfarbe für das Event-List-Container
          borderRadius: BorderRadius.circular(borderRadiusSmallButton), // Abgerundete Ecken
        ),
        child: Consumer<EventFunctions>(
          builder: (context, eventFunctions, child) {
            // Zugriff auf die Event-Daten über eventFunctions
            final events = eventDatas; // Die ursprüngliche Liste

            return ListView.builder(
              // ListView zur Anzeige der Events
              itemCount: events.length, // Anzahl der Einträge in der Event-Datenliste
              shrinkWrap:
                  true, // Schaltet das Schrumpfen der Liste ein, sodass sie nur so viel Platz wie benötigt einnimmt
              itemBuilder: (BuildContext context, int index) {
                final event = events[index];

                return ListTile(
                  title: Text(
                    event.eventTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('${textFiles[language]![95]}: ${event.eventDate}'),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Leere Funktion, Aktion bei Klick kann später hinzugefügt werden
                  },
                  onLongPress: () {
                    // Aufruf der deleteEvent-Methode aus dem Provider
                    eventFunctions.deleteEvent(event.eventTitle); // Aufruf der deleteEvent-Methode
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
