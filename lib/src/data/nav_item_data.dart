import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/core/domain/nav_items.dart';
import 'package:flutter/material.dart';

/// Liste der Navigationselemente für die untere Navigationsleiste
List<NavigationItem> navigationItemData = [
  NavigationItem(
    activeIcon: Icons.event_available, // Aktives Icon für den Event-Bildschirm
    icon: Icons.event_outlined, // Standard-Icon für den Event-Bildschirm
    label: textFiles[language]![0], // Beschriftung für den Event-Bildschirm, aus der Sprachdatei geladen
  ),
  NavigationItem(
    activeIcon: Icons.favorite, // Aktives Icon für den Favoriten-Bildschirm
    icon: Icons.favorite_border, // Standard-Icon für den Favoriten-Bildschirm
    label: textFiles[language]![1], // Beschriftung für den Favoriten-Bildschirm, aus der Sprachdatei geladen
  ),
  NavigationItem(
    activeIcon: Icons.settings, // Aktives Icon für den Profil- oder Einstellungs-Bildschirm
    icon: Icons.settings, // Standard-Icon für den Profil- oder Einstellungs-Bildschirm
    label: textFiles[language]![49], // Beschriftung für den Profil-Bildschirm, aus der Sprachdatei geladen
  ),
];
