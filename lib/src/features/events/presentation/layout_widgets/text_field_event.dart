import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/data/event_textfield_data.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/general_widgets/presentation/custom_txt_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';

class TextFieldEvent extends StatelessWidget {
  const TextFieldEvent({super.key});

  @override
  Widget build(BuildContext context) {
    // Holt den LanguageProvider, um die Sprache des Texts zu bekommen
    final languageProvider = Provider.of<LanguageProvider>(context);
    final String language = languageProvider.language;

    // Controller für das Event-Namen Textfeld
    final TextEditingController eventNameController = TextEditingController();

    // Holt die Event-Textfeld-Daten, die das Layout und die Labels enthalten
    final eventTextfieldDatas = getEventTextfieldDatas(context);

    // ValueNotifier für den Status des Buttons (aktiv oder deaktiviert)
    ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

    // Listener, der den Status des Buttons basierend auf der Eingabe im Textfeld aktualisiert
    void _updateButtonState() {
      isButtonEnabled.value = eventNameController.text.isNotEmpty;
    }

    // Füge den Listener zum Textfeld hinzu
    eventNameController.addListener(_updateButtonState);

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

        // Erstelle neues Event Button, der nur aktiv ist, wenn der Text im Feld nicht leer ist
        ValueListenableBuilder<bool>(
          valueListenable: isButtonEnabled, // Hört auf Änderungen im Button-Status
          builder: (context, isEnabled, child) {
            return BigButton(
                buttonName: textFiles[language]![44], // Button-Text aus der Sprachdatei
                onPressed: () {
                  // Navigiere zum nächsten Bildschirm, wenn der Button aktiv ist
                  Navigator.pushNamed(context, "/createCategory");
                });
          },
        ),
        SizedBox(
            height: bottomSafeArea), // Sicherstellen, dass der Button nicht hinter der unteren Bildschirmkante landet
      ],
    );
  }
}
