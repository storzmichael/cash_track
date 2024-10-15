import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider with ChangeNotifier {
  String _language = 'English';

  String get language => _language;

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    _language = prefs.getString('language') ?? 'English'; // Standardwert
    notifyListeners();
  }

  Future<void> setLanguage(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', lang);
    _language = lang;
    notifyListeners();
  }
}
