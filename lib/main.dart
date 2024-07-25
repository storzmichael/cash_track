import 'package:cash_track/src/config/theme_data.dart';
import 'package:cash_track/src/core/presentation/app_home.dart';
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
      home: AppHome(),
    );
  }
}
