import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

// Ein Container, der einen thematischen Hintergrund mit einem Farbverlauf bereitstellt
class ThemeContainer extends StatelessWidget {
  final bool isDark; // Bestimmt, ob das dunkle Thema verwendet wird
  final Widget? child; // Das Kind-Widget, das im Container platziert wird

  const ThemeContainer({super.key, this.isDark = false, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.none, // Keine Beschneidungslogik für überlappende Kind-Widgets
      decoration: BoxDecoration(
        gradient: LinearGradient(
          // Wenn `isDark` true ist, verwende dunkle Theme-Farben; andernfalls helle Theme-Farben
          colors: isDark ? darkThemeList : lightThemeList,
          begin: Alignment.topCenter, // Farbverlauf beginnt oben in der Mitte
          end: Alignment.bottomCenter, // Farbverlauf endet unten in der Mitte
        ),
      ),
      child: child, // Platziert das Kind-Widget innerhalb des Containers
    );
  }
}
