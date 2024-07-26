import 'package:cash_track/src/features/events/presentation/create_event_screen.dart';
import 'package:cash_track/src/features/events/presentation/edit_event_screen.dart';
import 'package:flutter/material.dart';

void navigateToCreateEventScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const CreateEventScreen()),
  );
}

void navigateToEditEventScreen(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const EditEventScreen()),
  );
}
