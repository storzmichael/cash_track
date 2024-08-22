import 'package:cash_track/src/core/data/nav_item_data.dart';
import 'package:cash_track/src/features/events/presentation/event_screen.dart';
import 'package:cash_track/src/features/events/presentation/favorites_screen.dart';
import 'package:cash_track/src/features/profil/presentation/profil_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
  } //List of screen from navigation bar

  final List<Widget> screens = [
    const EventScreen(),
    const FavoritesScreen(),
    const ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        title: Text(
          navigationItemData[currentIndex].label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(navigationItemData[0].activeIcon),
            icon: Icon(navigationItemData[0].icon),
            label: navigationItemData[0].label,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(navigationItemData[1].activeIcon),
            icon: Icon(navigationItemData[1].icon),
            label: navigationItemData[1].label,
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(navigationItemData[2].activeIcon),
            icon: Icon(navigationItemData[2].icon),
            label: navigationItemData[2].label,
          ),
        ],
      ),
      body: screens[currentIndex],
    );
  }
}
