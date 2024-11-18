import 'package:cash_track/src/features/settings/application/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/data/lang/app_text.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  // Hilfsmethode zum Erstellen eines ListTile-Widgets mit Symbol, Titel und einer Aktion
  Widget _buildListTile(
    BuildContext context, {
    required IconData icon, // Icon, das vor dem Titel angezeigt wird
    required String title, // Titel des ListTiles
    required VoidCallback onTap, // Aktion, die bei einem Tap ausgeführt wird
    Color color = Colors.black, // Farbe des Icons (Standard: Schwarz)
  }) {
    return ListTile(
      leading: Icon(icon, color: color), // Das Icon für das ListTile
      title: Text(title), // Der Titel des ListTile
      onTap: onTap, // Aktion, die beim Tippen auf das ListTile ausgeführt wird
    );
  }

  // Hilfsmethode zum Erstellen einer horizontalen Trennlinie (Divider)
  Widget _buildDivider() {
    return const Divider(
      height: 0.1, // Minimale Höhe des Dividers
      color: Colors.white, // Farbe des Dividers (weiß)
    );
  }

  @override
  Widget build(BuildContext context) {
    // Zugriff auf den LanguageProvider, um die aktuelle Sprache zu verwalten
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          textFiles[languageProvider.language]![
              58], // Titel für die Spracheinstellungen, dynamisch basierend auf der gewählten Sprache
        ),
      ),
      body: Stack(
        children: [
          const ThemeContainer(), // Ein Container für das Hintergrund-Design oder Theme
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding für das ListView
            child: ListView(
              children: [
                // ListTile für Deutsch, beim Tippen wird die Sprache auf Deutsch gesetzt
                _buildListTile(
                  context,
                  icon: Icons.language, // Das Sprach-Icon
                  title: 'Deutsch', // Titel für Deutsch
                  onTap: () {
                    languageProvider.setLanguage('Deutsch'); // Setzt die Sprache auf Deutsch
                  },
                ),
                _buildDivider(), // Divider zwischen den ListTiles

                // ListTile für Englisch, beim Tippen wird die Sprache auf Englisch gesetzt
                _buildListTile(
                  context,
                  icon: Icons.language, // Das Sprach-Icon
                  title: 'English', // Titel für Englisch
                  onTap: () {
                    languageProvider.setLanguage('English'); // Setzt die Sprache auf Englisch
                  },
                ),
                _buildDivider(), // Divider zwischen den ListTiles

                // Weitere Einstellungen könnten hier hinzugefügt werden
              ],
            ),
          ),
        ],
      ),
    );
  }
}
