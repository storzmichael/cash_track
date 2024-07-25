import 'package:cash_track/src/features/events/domain/event_button_item.dart';

import 'package:flutter/material.dart';

List<EventButtonItem> eventButtonDatas = [
  // collection of data
  const EventButtonItem(
    eventButtonTitle: "Neues Event",
    eventButtonIcon: Icons.add,
  ),
  const EventButtonItem(
    eventButtonTitle: "Share",
    eventButtonIcon: Icons.share,
  ),
  const EventButtonItem(
    eventButtonTitle: "Join Event",
    eventButtonIcon: Icons.play_arrow_outlined,
  ),
  const EventButtonItem(
    eventButtonTitle: "QR-Code",
    eventButtonIcon: Icons.qr_code_scanner_rounded,
  ),
];
