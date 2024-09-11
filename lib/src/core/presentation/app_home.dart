import 'package:cash_track/src/data/nav_item_data.dart';
import 'package:cash_track/src/features/events/presentation/screens/event_screen.dart';
import 'package:cash_track/src/features/events/presentation/screens/favorites_screen.dart';
import 'package:cash_track/src/features/profil/presentation/profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    const ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark, // Changes status bar text color to dark
        title: Text(
          navigationItemData[currentIndex].label, // Sets the title according to the current screen
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            // TODO: Navigation to settings screen
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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

      // Shows the currently selected screen from the list
      body: screens[currentIndex],
    );
  }
}
