import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

// background color
class ThemeContainer extends StatelessWidget {
  final bool isDark;
  final Widget? child;
  const ThemeContainer({super.key, this.isDark = false, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark ? darkTheme : lightTheme,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
