import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/presentation/layout_widgets/event_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart'; // Importiere den LanguageProvider

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  // Logo-Anzeige, hier mit der Bild-URL aus den App-Einstellungen
  Widget _logo() {
    return const Center(
      child: SizedBox(
        height: 150, // Höhe des Logos
        child: Image(
          image: AssetImage(appImagePath), // Der Pfad des App-Logos
          fit: BoxFit.fitHeight, // Skaliere das Bild, um es in den verfügbaren Raum zu passen
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den aktuellen LanguageProvider

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Verhindert die Zurück-Navigation
        title: Text(
          textFiles[languageProvider.language]![
              1], // Dynamischer Text für den Titel basierend auf der aktuellen Sprache
          style: Theme.of(context).textTheme.labelLarge, // Stil des AppBar-Titels
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
                  begin: Alignment.topCenter, // Startpunkt des Farbverlaufs
                  end: Alignment.bottomCenter, // Endpunkt des Farbverlaufs
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(sitesPadding), // Padding für den Inhalt
                child: Column(
                  children: [
                    _logo(), // Zeigt das App-Logo an
                    const SizedBox(height: 32), // Abstand zwischen Logo und Liste
                    const EventList(), // EventList zeigt eine Liste von Favoriten an
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
