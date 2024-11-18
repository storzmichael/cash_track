import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/application/event_functions.dart';
import 'package:cash_track/src/features/events/data/event_textfield_data.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/general_widgets/presentation/custom_txt_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';

class TextFieldEvent extends StatefulWidget {
  const TextFieldEvent({super.key});

  @override
  _TextFieldEventState createState() => _TextFieldEventState();
}

class _TextFieldEventState extends State<TextFieldEvent> {
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController eventDateController = TextEditingController();

  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    // Listener, der den Button-Status basierend auf der Eingabe im Textfeld aktualisiert
    eventNameController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = eventNameController.text.isNotEmpty && eventDateController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    eventNameController.dispose();
    eventDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Holt den LanguageProvider, um die Sprache des Texts zu bekommen
    final languageProvider = Provider.of<LanguageProvider>(context);
    final String language = languageProvider.language;

    // Holt die Event-Textfeld-Daten, die das Layout und die Labels enthalten
    final eventTextfieldDatas = getEventTextfieldDatas(context);

    return Column(
      children: [
        // Event Name Eingabefeld
        CustomTextField(
          eventTextfieldItem: eventTextfieldDatas[0], // Holen des ersten Textfeldes für den Eventnamen
          controller: eventNameController, // Setze den Controller für das Textfeld
          onChanged: (value) {
            _updateButtonState(); // Update den Button-Status bei Textänderung
          },
        ),
        const SizedBox(height: 12), // Abstand zwischen den Elementen
        CustomTextField(
          eventTextfieldItem: eventTextfieldDatas[1], // Holen des zweiten Textfeldes für das Eventdatum
          controller: eventDateController, // Setze den Controller für das Textfeld
          onChanged: (value) {
            _updateButtonState(); // Update den Button-Status bei Textänderung
          },
        ),
        const SizedBox(height: 12), // Abstand zwischen den Elementen

        // Erstelle neues Event Button, der nur aktiv ist, wenn der Text im Feld nicht leer ist
        BigButton(
          buttonName: textFiles[language]![44], // Button-Text aus der Sprachdatei
          onPressed: isButtonEnabled
              ? () {
                  EventFunctions().createEvent(eventNameController.text, eventDateController.text);
                  // Navigiere zum nächsten Bildschirm, wenn der Button aktiv ist
                  Navigator.pushNamed(context, "/createCategory");
                }
              : null, // Button nur aktiv, wenn Eingabe vorhanden ist
        ),
        SizedBox(
            height: bottomSafeArea), // Sicherstellen, dass der Button nicht hinter der unteren Bildschirmkante landet
      ],
    );
  }
}
