import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/core/domain/nav_items.dart';
import 'package:flutter/material.dart';

// List of navigation items for the bottom navigation bar
List<NavigationItem> navigationItemData = [
  NavigationItem(
    activeIcon: Icons.event_available, // Active icon when the event screen is selected
    icon: Icons.event_outlined, // Default icon for the event screen
    label: textFiles[language]![0], // Label for the event screen, pulled from the language file
  ),
  NavigationItem(
    activeIcon: Icons.favorite, // Active icon when the favorites screen is selected
    icon: Icons.favorite_border, // Default icon for the favorites screen
    label: textFiles[language]![1], // Label for the favorites screen, pulled from the language file
  ),
  NavigationItem(
    activeIcon: Icons.person, // Active icon when the profile screen is selected
    icon: Icons.person_outline, // Default icon for the profile screen
    label: textFiles[language]![2], // Label for the profile screen, pulled from the language file
  ),
];
