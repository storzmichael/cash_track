import 'package:cash_track/firebase_options.dart';
import 'package:cash_track/src/config/theme_data.dart';
import 'package:cash_track/src/core/application/navigation_provider.dart';
import 'package:cash_track/src/core/presentation/app_home.dart';
import 'package:cash_track/src/features/cashout/presentation/paid_product_screen.dart';
import 'package:cash_track/src/features/events/application/event_functions.dart';
import 'package:cash_track/src/features/events/application/product_provider.dart';
import 'package:cash_track/src/features/events/presentation/layout_widgets/event_list.dart';
import 'package:cash_track/src/features/events/presentation/screens/create_category.dart';
import 'package:cash_track/src/features/events/presentation/screens/create_event_screen.dart';
import 'package:cash_track/src/features/order/application/order_provider.dart';
import 'package:cash_track/src/features/order/presentation/order_screen.dart';
import 'package:cash_track/src/features/registration-login/application/login_provider.dart';
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
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Firebase initialisieren
  } catch (e) {
    print("Firebase Initialization Error: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => OrderProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => EventFunctions()),
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
        "/createEvent": (context) => const CreateEventScreen(),
        "/registration": (context) => const RegistrationScreen(),
        "/language": (context) => const LanguageScreen(),
        "/settings": (context) => const SettingScreen(),
        "/paid": (context) => PaidProductsScreen(),
        "/createCategory": (context) => const CreateCategoryScreen(),
      },
    );
  }
}
