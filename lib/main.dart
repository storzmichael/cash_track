import 'package:cash_track/src/config/theme_data.dart';
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
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 153, 153, 153),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            //     LinearGradient(
            //   colors: [
            //     Color.fromARGB(255, 158, 158, 158),
            //     Color.fromARGB(255, 56, 56, 56),
            //   ],
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            // ),
          ),
          child: const SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProductGrid(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
