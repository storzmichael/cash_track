import 'package:cash_track/src/features/registration-login/application/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/config/config_colors.dart';

// Das LoginTextField Widget stellt ein benutzerdefiniertes Textfeld für die Anmeldung dar
class LoginTextField extends StatelessWidget {
  // Erforderliche und optionale Parameter des Textfeldes
  final String labelName; // Labeltext für das Textfeld
  final bool isPassword; // Gibt an, ob das Textfeld ein Passwortfeld ist
  final TextEditingController controller; // Controller zur Steuerung des Textfeldes
  final Color labelTextColor; // Farbe des Labeltextes
  final double borderRadius; // Eckenradius des Textfeldes
  final Color backgroundColor; // Hintergrundfarbe des Textfeldes
  final double height; // Höhe des Textfeldes
  final Widget? prefixIcon; // Optionales Präfix-Icon im Textfeld

  const LoginTextField({
    super.key,
    required this.labelName,
    this.isPassword = false,
    required this.controller,
    this.labelTextColor = whiteColor,
    this.borderRadius = 12,
    this.backgroundColor = textFieldColor,
    this.height = 40,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    // Provider für Login-Verhalten (z.B. Passwortsichtbarkeit)
    final provider = Provider.of<LoginProvider>(context, listen: true);

    // Das Container-Widget hält das Textfeld mit abgerundeten Ecken und Hintergrundfarbe
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor, // Hintergrundfarbe des Textfeldes
        borderRadius: BorderRadius.circular(borderRadius), // Abgerundete Ecken
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius), // Sicherstellen, dass die Ecken abgerundet sind
        child: SizedBox(
          height: height, // Höhe des Textfeldes
          child: TextField(
            controller: controller, // Verwendeter TextEditingController
            obscureText: isPassword ? provider.obscureText : false, // Wenn Passwort, dann Sichtbarkeit steuern
            decoration: InputDecoration(
              filled: true, // Füllt das Textfeld
              fillColor: backgroundColor, // Hintergrundfarbe
              border: InputBorder.none, // Keine sichtbare Umrandung
              labelText: labelName, // Beschriftung des Textfeldes
              labelStyle: TextStyle(color: labelTextColor), // Stil der Beschriftung
              floatingLabelStyle: TextStyle(color: labelTextColor), // Stil der schwebenden Beschriftung
              floatingLabelBehavior: FloatingLabelBehavior.never, // Schwebende Beschriftung deaktivieren
              contentPadding: EdgeInsets.symmetric(
                vertical: (height - 20) / 2, // Vertikale Polsterung
                horizontal: 12, // Horizontale Polsterung
              ),
              prefixIcon: prefixIcon != null
                  ? IconTheme(
                      data: IconThemeData(
                          color:
                              labelTextColor), // Falls ein Präfix-Icon vorhanden ist, wird es mit der Textfarbe gefärbt
                      child: prefixIcon!, // Das Präfix-Icon
                    )
                  : null,
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        provider.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility, // Zeigt je nach Zustand das Sichtbarkeits-Icon an
                        color: labelTextColor,
                      ),
                      onPressed: provider.toggleObscureText, // Umkehren der Sichtbarkeit bei Klick
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
