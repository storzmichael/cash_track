import 'package:cash_track/src/core/application/navigation_provider.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/events/presentation/screens/event_screen.dart';
import 'package:cash_track/src/features/events/presentation/screens/favorites_screen.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';
import 'package:cash_track/src/features/settings/presentation/setting_screen.dart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppHome extends StatelessWidget {
  const AppHome({super.key});

  final List<Widget> screens = const [
    EventScreen(),
    FavoritesScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black, // Farbe der oberen Border
              width: 0.07, // Breite der Border
            ),
          ),
        ),
        child: Consumer<LanguageProvider>(
          // Consumer zum Zugriff auf den LanguageProvider
          builder: (context, languageProvider, child) {
            return BottomNavigationBar(
              currentIndex: navigationProvider.currentIndex, // Verwendet den aktuellen Index aus dem Provider
              onTap: (index) {
                navigationProvider.setCurrentIndex(index); // Aktualisiert den Index über den Provider
              },
              showSelectedLabels: true, // Zeigt Labels für das ausgewählte Item
              showUnselectedLabels: false, // Versteckt Labels für nicht ausgewählte Items
              items: [
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.event), // Beispiel-Icon für den Event-Screen
                  icon: Icon(Icons.event_outlined), // Standard-Icon für den Event-Screen
                  label: textFiles[languageProvider.language]![0], // Label für den Event-Screen
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.favorite), // Beispiel-Icon für den Favoriten-Screen
                  icon: Icon(Icons.favorite_outline), // Standard-Icon für den Favoriten-Screen
                  label: textFiles[languageProvider.language]![1], // Label für den Favoriten-Screen
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(Icons.settings), // Beispiel-Icon für den Einstellungen-Screen
                  icon: Icon(Icons.settings_outlined), // Standard-Icon für den Einstellungen-Screen
                  label: textFiles[languageProvider.language]![49], // Label für den Einstellungen-Screen
                ),
              ],
            );
          },
        ),
      ),
      body: screens[navigationProvider.currentIndex], // Zeigt den aktuell ausgewählten Screen
    );
  }
}
