import 'package:cash_track/src/core/domain/nav_items.dart';
import 'package:flutter/material.dart';

List<NavigationItem> navigationItemData = [
  // collection of data
  const NavigationItem(
    activeIcon: Icons.event_available,
    icon: Icons.event_outlined,
    label: 'Event',
  ),
  const NavigationItem(
    activeIcon: Icons.favorite,
    icon: Icons.favorite_border,
    label: 'Favoriten',
  ),
  const NavigationItem(
    activeIcon: Icons.person,
    icon: Icons.person_outline,
    label: 'Profil',
  ),
];
