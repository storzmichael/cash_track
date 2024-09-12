import 'package:cash_track/src/config/theme_data.dart';

import 'package:cash_track/src/core/presentation/app_home.dart';
import 'package:cash_track/src/features/cashout/presentation/cashout_screen.dart';
import 'package:cash_track/src/features/events/presentation/screens/create_event_screen.dart';
import 'package:cash_track/src/features/events/presentation/screens/edit_event_screen.dart';

import 'package:cash_track/src/features/order/presentation/order_screen.dart';
import 'package:cash_track/src/features/registration-login/presentation/login_screen.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      routes: {
        "/": (context) => const LoginScreen(),
        "/appHome": (context) => const AppHome(),
        "/order": (context) => const OrderScreen(),
        "/cashout": (context) => const CashoutScreen(),
        "/editEvent": (context) => const EditEventScreen(),
        "/createEvent": (context) => const CreateEventScreen(),
      },
    );
  }
}
