import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/presentation/layout_widgets/text_field_event.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark, // Setzt den Overlay-Stil auf dunkle Symbole
        title: Text(
          textFiles[language]![42], // Titel des Screens aus der Sprachdatei
          style: const TextStyle(fontWeight: FontWeight.bold), // Stilisierung des Titels
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightThemeList[0], // Erste Farbe des Farbverlaufs
                    lightThemeList[1], // Zweite Farbe des Farbverlaufs
                  ],
                  begin: Alignment.topCenter, // Start des Farbverlaufs oben
                  end: Alignment.bottomCenter, // Ende des Farbverlaufs unten
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(sitesPadding), // Padding um das Container-Element
                child: Center(
                  child: TextFieldEvent(), // Das TextFieldEvent-Widget, das das Eingabefeld für das Event enthält
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
