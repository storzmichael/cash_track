import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/application/button_funktions.dart';
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
    final languageProvider = Provider.of<LanguageProvider>(context);
    final String language = languageProvider.language;

    final TextEditingController codeController = TextEditingController();
    final TextEditingController eventNameController = TextEditingController();

    final eventTextfieldDatas = getEventTextfieldDatas(context);

    // ValueNotifier für den Button-Status
    ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

    // Listener für die Textfelder
    void _updateButtonState() {
      isButtonEnabled.value = eventNameController.text.isNotEmpty && codeController.text.isNotEmpty;
    }

    // Füge Listener zu den TextEditingController hinzu
    eventNameController.addListener(_updateButtonState);
    codeController.addListener(_updateButtonState);

    return Column(
      children: [
        // Event Name:
        CustomTextField(
          eventTextfieldItem: eventTextfieldDatas[0],
          controller: eventNameController,
          onChanged: (value) {
            _updateButtonState(); // Status aktualisieren
          },
        ),
        const SizedBox(height: 12),

        // Code
        CustomTextField(
          eventTextfieldItem: eventTextfieldDatas[3],
          controller: codeController,
          onChanged: (value) {
            _updateButtonState(); // Status aktualisieren
          },
        ),
        const SizedBox(height: 32),

        // Generiere neuen Code
        BigButton(
          buttonName: textFiles[language]![43],
          onPressed: () {
            String newCode = generateRandomCode(8);
            codeController.text = newCode;
            _updateButtonState(); // Button-Status nach Code-Generierung aktualisieren
          },
        ),
        const Expanded(child: SizedBox()),

        // Erstelle neues Event
        ValueListenableBuilder<bool>(
          valueListenable: isButtonEnabled,
          builder: (context, isEnabled, child) {
            return BigButton(
              buttonName: textFiles[language]![44],
              onPressed: isEnabled
                  ? () {
                      Navigator.pushReplacementNamed(context, "/createProducts");
                      //speichern in event liste (als dokument)
                    }
                  : null, // Button deaktiviert
            );
          },
        ),
        SizedBox(height: bottomSafeArea),
      ],
    );
  }
}
