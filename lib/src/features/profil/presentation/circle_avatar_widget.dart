import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String? imageUrl; // Bild-URL, die angezeigt werden soll (optional)
  final String defaultImageUrl =
      'https://via.placeholder.com/150'; // Platzhalter-Bild, wenn keine Bild-URL vorhanden ist
  final double radius; // Radius des Kreises
  final Color backgroundColor; // Hintergrundfarbe des Avatars
  final Color iconColor; // Farbe des Icons, wenn kein Bild angezeigt wird
  final double iconSize; // Größe des Icons

  const CircleAvatarWidget({
    super.key,
    this.imageUrl, // Optional, falls ein benutzerdefiniertes Bild verwendet wird
    this.radius = 50, // Standardwert für den Radius
    this.backgroundColor = Colors.grey, // Standard-Hintergrundfarbe, falls kein Bild vorhanden ist
    this.iconColor = primeryColor, // Standardfarbe für das Icon
    this.iconSize = 70, // Standardgröße für das Icon
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius, // Setzt den Radius des Kreises
      backgroundColor: backgroundColor, // Hintergrundfarbe des Avatars
      backgroundImage: imageUrl != null
          ? NetworkImage(imageUrl!)
          : NetworkImage(defaultImageUrl), // Verwendet entweder das benutzerdefinierte Bild oder den Platzhalter
      onBackgroundImageError: (_, __) {}, // Fehlerbehandlung, falls das Laden des Bildes fehlschlägt
      child: imageUrl == null // Wenn kein Bild vorhanden ist, wird das Icon angezeigt
          ? Icon(
              Icons.person, // Standard-Icon (Person)
              size: iconSize, // Größe des Icons
              color: iconColor, // Farbe des Icons
            )
          : null, // Wenn ein Bild vorhanden ist, wird das Icon nicht angezeigt
    );
  }
}
