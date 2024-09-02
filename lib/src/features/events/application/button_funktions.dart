import 'dart:math';

import 'package:cash_track/src/features/events/presentation/screens/create_event_screen.dart';
import 'package:cash_track/src/features/events/presentation/screens/edit_event_screen.dart';

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

String generateRandomCode(int length) {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random rnd = Random();

  return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}
