import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

// A container that provides a themed background with a gradient
class ThemeContainer extends StatelessWidget {
  final bool isDark; // Determines whether the dark theme is used
  final Widget? child; // The child widget that will be placed inside the container
  const ThemeContainer({super.key, this.isDark = false, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none, // No clipping behavior for child overflow
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // If isDark is true, use dark theme colors; otherwise, use light theme colors
          colors: isDark ? darkThemeList : lightThemeList,
          begin: Alignment.topCenter, // Gradient starts from the top center
          end: Alignment.bottomCenter, // Gradient ends at the bottom center
        ),
      ),
      child: child, // Places the child widget inside the container
    );
  }
}
