import 'package:flutter/material.dart';

class NavigationItem {
  final IconData activeIcon;
  final IconData icon;
  final String label;

  const NavigationItem({
    required this.activeIcon,
    required this.icon,
    required this.label,
  });
}
