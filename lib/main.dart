import 'package:cash_track/src/config/theme_data.dart';
import 'package:cash_track/src/core/application/navigation_provider.dart';
import 'package:cash_track/src/core/presentation/app_home.dart';
import 'package:cash_track/src/features/events/application/product_provider.dart';
import 'package:cash_track/src/features/events/presentation/screens/create_event_screen.dart';
import 'package:cash_track/src/features/events/presentation/screens/create_product_screen.dart.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';
import 'package:cash_track/src/features/order/presentation/order_screen.dart';
import 'package:cash_track/src/features/registration-login/presentation/login_screen.dart';

import 'package:cash_track/src/features/registration-login/presentation/registration_screen.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';
import 'package:cash_track/src/features/settings/presentation/language_screen.dart';
import 'package:cash_track/src/features/settings/presentation/setting_screen.dart.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(); // Firebase initialisieren
  } catch (e) {
    print("Firebase Initialization Error: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        // NavigationProvider bereitstellen
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        // ThemeDataProvider bereitstellen
      ],
      child: const MainApp(),
    ),
  );
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
        "/order": (context) => OrderScreen(),
        "/createProducts": (context) => const CreateProductScreen(),
        "/createEvent": (context) => const CreateEventScreen(),
        "/registration": (context) => const RegistrationScreen(),
        "/language": (context) => const LanguageScreen(),
        "/settings": (context) => const SettingScreen()
      },
    );
  }
}
