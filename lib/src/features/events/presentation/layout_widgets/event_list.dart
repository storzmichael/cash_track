import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/features/events/data/event_data.dart';

import 'package:cash_track/src/features/events/presentation/single_widgets/event_txt_field.dart';
import 'package:flutter/material.dart';

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
        child: ListView.builder(
          // ListView zur Anzeige der Events
          itemCount: eventDatas.length, // Anzahl der Einträge in der Event-Datenliste
          shrinkWrap: true, // Schaltet das Schrumpfen der Liste ein, sodass sie nur so viel Platz wie benötigt einnimmt
          itemBuilder: (BuildContext context, int index) {
            return EventTxtField(
              // Erzeugt ein Widget für jedes Event, das in der Liste angezeigt wird
              eventItem: eventDatas[index], // Übergibt das Event-Item an das EventTxtField-Widget
            );
          },
        ),
      ),
    );
  }
}
