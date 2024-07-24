import 'package:cash_track/src/config/theme_data.dart';
import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/events/presentation/event_grid.dart';
import 'package:cash_track/src/features/order/presentation/product_grid.dart';
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
      home: const Scaffold(
        body: Stack(
          children: [
            ThemeContainer(
              isDark: false,
            ),
            Center(
                child: Padding(
              padding: EdgeInsets.all(16.0),
              child: EventGrid(),
            )),
          ],
        ),
      ),
    );
  }
}
