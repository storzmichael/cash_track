import 'package:cash_track/src/core/application/navigation_functions.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';
import 'package:cash_track/src/features/events/domain/event_button_item.dart';

List<EventButtonItem> getEventButtonDatas(BuildContext context) {
  final languageProvider = Provider.of<LanguageProvider>(context);
  final String language = languageProvider.language;

  return [
    EventButtonItem(
      eventButtonTitle: textFiles[language]![64],
      eventButtonIcon: Icons.add,
      eventButtonOnPressed: (context) => navigateToCreateEventScreen(context),
    ),
    EventButtonItem(
      eventButtonTitle: textFiles[language]![65],
      eventButtonIcon: Icons.start,
      eventButtonOnPressed: (context) {},
    ),
  ];
}
