import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Der LanguageProvider verwaltet die Spracheinstellungen der App
class LanguageProvider with ChangeNotifier {
  String _language = 'Deutsch'; // Standard-Spracheinstellung

  // Getter für die aktuelle Sprache
  String get language => _language;

  // Methode zum Laden der Sprache aus den SharedPreferences
  Future<void> loadLanguage() async {
    // Zugriff auf SharedPreferences, um die gespeicherte Sprache zu laden
    final prefs = await SharedPreferences.getInstance();
    // Wenn keine Sprache gespeichert ist, wird der Standardwert 'English' verwendet
    _language = prefs.getString('language') ?? 'English';
    // Benachrichtige alle Listener, dass sich die Sprache geändert hat
    notifyListeners();
  }

  // Methode zum Setzen einer neuen Sprache und Speichern in SharedPreferences
  Future<void> setLanguage(String lang) async {
    // Zugriff auf SharedPreferences, um die neue Sprache zu speichern
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang); // Speichern der Sprache
    _language = lang; // Setzen der neuen Sprache
    // Benachrichtige alle Listener, dass sich die Sprache geändert hat
    notifyListeners();
  }
}
