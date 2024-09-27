import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/nav_item_data.dart';
import 'package:cash_track/src/features/events/presentation/screens/event_screen.dart';
import 'package:cash_track/src/features/events/presentation/screens/favorites_screen.dart';
import 'package:cash_track/src/features/settings/presentation/setting_screen.dart.dart';
import 'package:flutter/material.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int currentIndex = 0; // Current index of the bottom navigation bar

  @override
  void initState() {
    super.initState();
  }

  // List of screens that the bottom navigation bar will switch between
  final List<Widget> screens = [
    const EventScreen(),
    const FavoritesScreen(),
    const SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: blackColor, // Set the color of the border
              width: 0.07, // Set the width of the border
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex, // Highlights the currently selected item
          onTap: (index) {
            setState(() {
              currentIndex = index; // Updates the screen based on selected item
            });
          },
          showSelectedLabels: true, // Shows label for the selected item
          showUnselectedLabels: false, // Hides labels for unselected items
          items: [
            // Navigate to Event screen
            BottomNavigationBarItem(
              activeIcon: Icon(navigationItemData[0].activeIcon), // Active icon for event screen
              icon: Icon(navigationItemData[0].icon), // Default icon for event screen
              label: navigationItemData[0].label, // Label for event screen
            ),

            // Navigate to Favorites screen
            BottomNavigationBarItem(
              activeIcon: Icon(navigationItemData[1].activeIcon), // Active icon for favorites screen
              icon: Icon(navigationItemData[1].icon), // Default icon for favorites screen
              label: navigationItemData[1].label, // Label for favorites screen
            ),

            // Navigate to Profile screen
            BottomNavigationBarItem(
              activeIcon: Icon(navigationItemData[2].activeIcon), // Active icon for profile screen
              icon: Icon(navigationItemData[2].icon), // Default icon for profile screen
              label: navigationItemData[2].label, // Label for profile screen
            ),
          ],
        ),
      ),
      body: screens[currentIndex], // Shows the currently selected screen from the list
    );
  }
}
