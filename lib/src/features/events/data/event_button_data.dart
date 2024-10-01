import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/core/application/navigation_functions.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:flutter/material.dart';

import 'package:cash_track/src/features/events/domain/event_button_item.dart';

List<EventButtonItem> eventButtonDatas = [
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
