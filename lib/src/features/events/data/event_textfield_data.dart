import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/domain/event_textfield_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart'; // Importiere den LanguageProvider

List<EventTextfieldItem> getEventTextfieldDatas(BuildContext context) {
  final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
  final String language = languageProvider.language; // Aktuelle Sprache abrufen

  return [
    // collection of data
    EventTextfieldItem(
      eventTextfieldHintText: textFiles[language]![66],
    ),
    EventTextfieldItem(
      eventTextfieldHintText: textFiles[language]![23],
    ),
    EventTextfieldItem(
      eventTextfieldHintText: textFiles[language]![67],
    ),
    EventTextfieldItem(
      eventTextfieldHintText: textFiles[language]![68],
    ),
  ];
}
