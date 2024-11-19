import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/presentation/layout_widgets/event_grid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart'; // Importiere den LanguageProvider
import 'package:shimmer/shimmer.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  // SignOut-Funktion, die den Benutzer abmeldet und zur Startseite navigiert
  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Abmelden vom Firebase-Auth
      Navigator.of(context).pushReplacementNamed("/"); // Navigiere zur Startseite
    } catch (e) {
      // Zeige eine Snackbar bei einem Fehler
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${textFiles[language]![56]}: $e')),
      );
    }
  }

  // Logo mit Shimmer-Effekt
  Widget _logo() {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 150,
            width: 320,
            child: Image(
              image: AssetImage('assets/logo/logo.png'), // Logo-Bild
              fit: BoxFit.fitHeight,
            ),
          ),
          SizedBox(
            child: Shimmer.fromColors(
              period: const Duration(milliseconds: 3000), // Shimmer-Effekt-Dauer
              loop: 1, // Shimmer nur einmal wiederholen
              baseColor: Colors.black, // Basisfarbe für den Shimmer
              highlightColor: Colors.grey, // Hervorhebungsfarbe für den Shimmer
              child: const Text(
                'CashTrack', // Text mit Shimmer-Effekt
                style: TextStyle(fontFamily: 'RubikOne', fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Sprachabhängiger Text, abhängig vom aktuellen Sprachprovider
          Consumer<LanguageProvider>(
            builder: (context, languageProvider, child) {
              return Text(
                textFiles[languageProvider.language]![21], // Dynamischer Text je nach Sprache
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den aktuellen Sprachprovider

    return Scaffold(
      appBar: AppBar(
        actions: [
          // Logout-Button in der AppBar
          IconButton(
            onPressed: () {
              _signOut(context); // Beim Drücken wird die _signOut-Methode aufgerufen
            },
            icon: Icon(
              Icons.logout_outlined, // Logout-Symbol
              color: Colors.red, // Rote Farbe für den Logout-Button
            ),
          )
        ],
        automaticallyImplyLeading: false, // Verhindert die Zurück-Navigation
        title: Text(
          textFiles[languageProvider.language]![0], // Dynamischer Titel der AppBar basierend auf der Sprache
          style: Theme.of(context).textTheme.labelLarge, // Stil des Titels
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
                  begin: Alignment.topCenter, // Startpunkt des Farbverlaufs oben
                  end: Alignment.bottomCenter, // Endpunkt des Farbverlaufs unten
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40.0, sitesPadding, 40.0, sitesPadding), // Innenabstand
                child: Column(
                  children: [
                    _logo(), // Zeige das Logo mit Shimmer-Effekt
                    const SizedBox(height: 32), // Abstand zwischen Logo und EventGrid
                    const EventGrid(), // Grid mit Veranstaltungen
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
