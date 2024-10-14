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
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    final String language = languageProvider.language; // Aktuelle Sprache abrufen

    final TextEditingController codeController = TextEditingController();
    final TextEditingController eventNameController = TextEditingController();
    final TextEditingController creatorController = TextEditingController();

    // Hier rufst du die eventTextfieldDatas-Funktion auf
    final eventTextfieldDatas = getEventTextfieldDatas(context);

    return Column(
      children: [
        // Event Name:
        CustomTextField(
          eventTextfieldItem: eventTextfieldDatas[0],
          controller: eventNameController,
          onChanged: (value) {},
        ),
        const SizedBox(height: 12),

        // Ersteller
        CustomTextField(
          eventTextfieldItem: eventTextfieldDatas[2],
          controller: creatorController,
          onChanged: (value) {},
        ),
        const SizedBox(height: 32),

        // Code
        CustomTextField(
          eventTextfieldItem: eventTextfieldDatas[3],
          controller: codeController,
          onChanged: (value) {},
        ),
        const SizedBox(height: 12),

        // Generiere neuen Code
        BigButton(
          buttonName: textFiles[language]![43],
          onPressed: () {
            String newCode = generateRandomCode(8);
            codeController.text = newCode;
          },
        ),
        const Expanded(child: SizedBox()),

        // Erstelle neues Event
        BigButton(
          buttonName: textFiles[language]![44],
          onPressed: () {
            Navigator.pushReplacementNamed(context, "/createProducts");
          },
        ),
        SizedBox(height: bottomSafeArea),
      ],
    );
  }
}
