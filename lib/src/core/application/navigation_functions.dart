import 'package:flutter/material.dart';

// Function to navigate to the app's home screen
void navigateToAppHome(BuildContext context) {
  // Use the Navigator to push to the "/appHome" route
  Navigator.pushNamed(context, "/appHome");
}

// Function to navigate to the order screen
void navigateToOrderScreen(BuildContext context) {
  // Use the Navigator to push to the "/order" route
  Navigator.pushNamed(context, "/order");
}

// Function to navigate to the cashout screen
void navigateToCashoutScreen(BuildContext context) {
  // Use the Navigator to push to the "/cashout" route
  Navigator.pushNamed(context, "/cashout");
}

// Function to navigate to the edit event screen
void navigateToCreateProductScreen(BuildContext context) {
  // Use the Navigator to push to the "/editEvent" route
  Navigator.pushNamed(context, "/createProducts");
}

// Function to navigate to the create event screen
void navigateToCreateEventScreen(BuildContext context) {
  // Use the Navigator to push to the "/createEvent" route
  Navigator.pushNamed(context, "/createEvent");
}

// Example:
// navigateToEditEventScreen(context);
