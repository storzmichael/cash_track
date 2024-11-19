import 'package:cash_track/src/config/button_varibals.dart';
import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/features/events/domain/event_textfield_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  // Controller für das Textfeld, um den Text zu verwalten
  final TextEditingController? controller;

  // Ein benutzerdefiniertes Objekt, das die Textfeld-Konfiguration enthält
  final EventTextfieldItem eventTextfieldItem;

  // Definiert den Tastaturtyp für die Eingabe (Standard: Text)
  final TextInputType keyboardType;

  // Optionaler Eingabe-Formatter, um die Eingabe zu beschränken (z.B. nur Zahlen)
  final TextInputFormatter? inputFormatter;

  // Funktion, die aufgerufen wird, wenn sich der Text ändert
  final void Function(String)? onChanged;

  final bool isFocused;

  // Konstruktor zur Initialisierung des CustomTextField-Widgets
  const CustomTextField({
    super.key,
    this.controller,
    required this.eventTextfieldItem,
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
    this.onChanged,
    this.isFocused = true, // Flag, ob das Textfeld fokussiert ist
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: textFieldColor, // Hintergrundfarbe des Textfeldes
        borderRadius: BorderRadius.circular(borderRadiusSmallButton), // Eckenrundung
      ),
      height: textFieldheight, // Höhe des Textfeldes
      width: double.infinity, // Das Textfeld soll die gesamte Breite einnehmen
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: textPadding), // Padding innerhalb des Containers
        child: Center(
          child: TextFormField(
            autofocus: isFocused, // Das Textfeld wird beim Erstellen automatisch fokussiert
            controller: controller, // Der Controller zum Verwalten des Textes
            keyboardType: keyboardType, // Der Tastaturtyp (z.B. Text, Zahl)
            inputFormatters:
                inputFormatter != null ? [inputFormatter!] : null, // Input-Formatter anwenden, wenn vorhanden
            decoration: InputDecoration(
              labelStyle: const TextStyle(fontWeight: FontWeight.bold), // Stil für das Label
              hintText: eventTextfieldItem.eventTextfieldHintText, // Hinweistext aus dem EventTextfieldItem
              hintStyle: const TextStyle(color: Colors.white), // Stil des Hinweistextes
              border: InputBorder.none, // Kein Rahmen um das Textfeld
              isCollapsed: true, // Das Textfeld soll nicht zusätzlich Platz einnehmen
            ),
            textAlignVertical: TextAlignVertical.center, // Vertikale Ausrichtung des Textes
            onChanged: onChanged, // Callback-Funktion, die bei Änderung des Textes aufgerufen wird
          ),
        ),
      ),
    );
  }
}
