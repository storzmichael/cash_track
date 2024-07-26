import 'package:flutter/material.dart';
import 'package:cash_track/src/features/events/application/button_funktions.dart';
import 'package:cash_track/src/features/events/domain/event_button_item.dart';

List<EventButtonItem> eventButtonDatas = [
  EventButtonItem(
    eventButtonTitle: "Neues Event",
    eventButtonIcon: Icons.add,
    eventButtonOnPressed: (context) => navigateToCreateEventScreen(context),
  ),
  EventButtonItem(
    eventButtonTitle: "Share",
    eventButtonIcon: Icons.share,
    eventButtonOnPressed: (context) {},
  ),
  EventButtonItem(
    eventButtonTitle: "Join Event",
    eventButtonIcon: Icons.play_arrow_outlined,
    eventButtonOnPressed: (context) {},
  ),
  EventButtonItem(
    eventButtonTitle: "QR-Code",
    eventButtonIcon: Icons.qr_code_scanner_rounded,
    eventButtonOnPressed: (context) {},
  ),
];
