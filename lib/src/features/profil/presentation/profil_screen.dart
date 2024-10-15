import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/general_widgets/presentation/outlined_big_button.dart';
import 'package:cash_track/src/features/profil/presentation/circle_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importiere Provider
import 'package:cash_track/src/features/settings/application/language_provider.dart'; // Importiere den LanguageProvider

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider

    return Padding(
      padding: const EdgeInsets.all(sitesPadding), // Padding um den gesamten Inhalt
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Inhalt wird am Start (links) ausgerichtet
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Inhalt wird am Start (links) ausgerichtet
            children: [
              CircleAvatarWidget(), // Zeigt das Profilbild an
            ],
          ),
          const Expanded(
            child: SizedBox(
              height: 32, // Abstand nach oben für den Button
            ),
          ),
          OutlinedBigButton(
            buttonName: textFiles[languageProvider.language]![19], // Name des Buttons aus der Sprachdatei
            onPressed: () {
              // Hier kann eine Funktion für das Drücken des Buttons eingefügt werden
            },
          ),
        ],
      ),
    );
  }
}
