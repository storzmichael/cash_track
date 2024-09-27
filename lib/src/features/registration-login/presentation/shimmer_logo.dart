import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLogo extends StatelessWidget {
  const ShimmerLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: logoheight, // Höhe des Logos
            width: logowidth, // Breite des Logos
            child: Image(
              image: AssetImage(appImagePath), // Logo-Bild
              fit: BoxFit.fitHeight, // Bildanpassung
            ),
          ),
          SizedBox(
            child: Shimmer.fromColors(
              period: const Duration(milliseconds: 3000), // Dauer des Shimmers
              loop: 3, // Anzahl der Shimmer-Wiederholungen
              baseColor: Colors.black, // Grundfarbe des Shimmers
              highlightColor: Colors.grey, // Highlight-Farbe des Shimmers
              child: const Text(
                appName, // App-Name
                style: TextStyle(fontFamily: 'RubikOne', fontSize: 24, fontWeight: FontWeight.bold), // Textstil
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            textFiles[language]![21], // Zusätzlicher Text aus der Sprachdatei
          ),
        ],
      ),
    );
  }
}
