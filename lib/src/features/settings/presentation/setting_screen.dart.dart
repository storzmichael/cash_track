import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

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
      color: whiteColor, // Farbe des Dividers (weiß)
    );
  }

  @override
  Widget build(BuildContext context) {
    // Zugriff auf den LanguageProvider, um die aktuelle Sprache zu verwalten
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Verhindert die Anzeige des Zurück-Buttons
        title: Text(
          textFiles[languageProvider.language]![
              49], // Titel für die Einstellungen, dynamisch basierend auf der gewählten Sprache
          style: Theme.of(context).textTheme.labelLarge, // Stil für den Titel
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              // Dekoration für den Hintergrund, mit einem Farbverlauf
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightThemeList[0], // Erste Farbe des Farbverlaufs
                    lightThemeList[1], // Zweite Farbe des Farbverlaufs
                  ],
                  begin: Alignment.topCenter, // Beginn des Farbverlaufs oben
                  end: Alignment.bottomCenter, // Ende des Farbverlaufs unten
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding für die ListView
                child: ListView(
                  children: [
                    // ListTile für Profil
                    _buildListTile(
                      context,
                      icon: Icons.person, // Profil-Icon
                      title: textFiles[languageProvider.language]![2], // Titel für "Profil"
                      onTap: () {
                        // Hier kann eine Navigationslogik zum Profil-Screen eingefügt werden
                      },
                    ),
                    _buildDivider(), // Divider zwischen den ListTiles

                    // ListTile für Datenschutz
                    _buildListTile(
                      context,
                      icon: Icons.lock, // Datenschutz-Icon
                      title: textFiles[languageProvider.language]![57], // Titel für "Datenschutz"
                      onTap: () {
                        // Hier kann eine Navigationslogik zu den Datenschutz-Einstellungen eingefügt werden
                      },
                    ),
                    _buildDivider(), // Divider zwischen den ListTiles

                    // ListTile für Sprache
                    _buildListTile(
                      context,
                      icon: Icons.language, // Sprach-Icon
                      title: textFiles[languageProvider.language]![58], // Titel für "Sprache"
                      onTap: () {
                        // Navigiert zur Spracheinstellung-Seite
                        Navigator.pushNamed(context, "/language");
                      },
                    ),
                    _buildDivider(), // Divider zwischen den ListTiles

                    // ListTile für Chats
                    _buildListTile(
                      context,
                      icon: Icons.devices, // Chats-Icon
                      title: textFiles[languageProvider.language]![59], // Titel für "Chats"
                      onTap: () {
                        // Hier kann eine Navigationslogik zu den Chat-Einstellungen eingefügt werden
                      },
                    ),
                    _buildDivider(), // Divider zwischen den ListTiles

                    // ListTile für Hilfe
                    _buildListTile(
                      context,
                      icon: Icons.help, // Hilfe-Icon
                      title: textFiles[languageProvider.language]![60], // Titel für "Hilfe"
                      onTap: () {
                        // Hier kann eine Navigationslogik zur Hilfe-Seite eingefügt werden
                      },
                    ),
                    _buildDivider(), // Divider zwischen den ListTiles
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
