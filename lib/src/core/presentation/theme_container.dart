import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class ThemeContainer extends StatelessWidget {
  final bool isDark;
  final Widget? child;
  const ThemeContainer({super.key, this.isDark = true, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
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
