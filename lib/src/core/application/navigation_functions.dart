import 'package:flutter/material.dart';

void navigateToAppHome(BuildContext context) {
  Navigator.pushNamed(context, "/appHome");
}

void navigateToOrderScreen(BuildContext context) {
  Navigator.pushNamed(context, "/order");
}

void navigateToCashoutScreen(BuildContext context) {
  Navigator.pushNamed(context, "/cashout");
}

void navigateToEditEventScreen(BuildContext context) {
  Navigator.pushNamed(context, "/editEvent");
}

void navigateToCreateEventScreen(BuildContext context) {
  Navigator.pushNamed(context, "/createEvent");
}


// example
// navigateToEditEventScreen(context);