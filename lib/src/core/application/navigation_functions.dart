import 'package:flutter/material.dart';

/// Navigationsfunktionen für verschiedene Bildschirme in der App

/// Navigiert zum Startbildschirm der App.
void navigateToAppHome(BuildContext context) {
  // Verwenden des Navigators, um zur Route "/appHome" zu wechseln
  Navigator.pushNamed(context, "/appHome");
}

/// Navigiert zum Bestellbildschirm.
void navigateToOrderScreen(BuildContext context) {
  // Verwenden des Navigators, um zur Route "/order" zu wechseln
  Navigator.pushNamed(context, "/order");
}

/// Navigiert zum Abrechnungsbildschirm.
void navigateToCashoutScreen(BuildContext context) {
  // Verwenden des Navigators, um zur Route "/cashout" zu wechseln
  Navigator.pushNamed(context, "/cashout");
}

/// Navigiert zum Bildschirm für das Bearbeiten von Produkten.
void navigateToCreateProductScreen(BuildContext context, int index) {
  // Verwenden des Navigators, um zur Route "/createProducts" zu wechseln
  Navigator.pushNamed(context, "/createProducts");
}

/// Navigiert zum Bildschirm für das Erstellen eines neuen Events.
void navigateToCreateEventScreen(BuildContext context) {
  // Verwenden des Navigators, um zur Route "/createEvent" zu wechseln
  Navigator.pushNamed(context, "/createEvent");
}


// Example:
// navigateToEditEventScreen(context);
