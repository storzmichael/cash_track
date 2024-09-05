import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/core/data/lang/app_text.dart';
import 'package:cash_track/src/core/domain/nav_items.dart';
import 'package:flutter/material.dart';

List<NavigationItem> navigationItemData = [
  // collection of data
  NavigationItem(
    activeIcon: Icons.event_available,
    icon: Icons.event_outlined,
    label: textFiles[language]![0], // Event
  ),
  NavigationItem(
    activeIcon: Icons.favorite,
    icon: Icons.favorite_border,
    label: textFiles[language]![1], // Favoriten
  ),
  NavigationItem(
    activeIcon: Icons.person,
    icon: Icons.person_outline,
    label: textFiles[language]![2], // Profil
  ),
];
