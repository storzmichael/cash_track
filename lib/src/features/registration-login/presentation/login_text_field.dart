import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final String labelName; // Bezeichnung des Textfelds
  final bool isPassword; // Gibt an, ob es sich um ein Passwortfeld handelt
  final TextEditingController controller; // Controller für das Textfeld
  final Color borderColor; // Farbe des Rahmens des Textfelds
  final Color focusedBorderColor; // Farbe des Rahmens, wenn das Textfeld den Fokus hat
  final Color errorBorderColor; // Farbe des Rahmens bei einem Fehler
  final Color labelTextColor; // Farbe des Bezeichnungs-Textes
  final double borderRadius; // Radius für die Ecken
  final Color backgroundColor; // Hintergrundfarbe des Textfelds
  final double height; // Höhe des Textfeldes
  final Widget? prefixIcon; // Optionales Icon vor dem Hint-Text

  const LoginTextField({
    super.key,
    required this.labelName,
    this.isPassword = false,
    required this.controller,
    this.borderColor = Colors.red, // Standard-Rahmenfarbe
    this.focusedBorderColor = textFieldColor,
    this.errorBorderColor = alertColor,
    this.labelTextColor = whiteColor,
    this.borderRadius = 12,
    this.backgroundColor = textFieldColor, // Standard-Hintergrundfarbe
    this.height = 40, // Standard-Höhe des Textfeldes
    this.prefixIcon, // Optionales Icon
  });

  @override
  // ignore: library_private_types_in_public_api
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool _obscureText = true; // Steuert, ob der Text des Passwortfeldes verborgen ist

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: TextField(
        controller: widget.controller, // Controller für das Textfeld
        decoration: InputDecoration(
          filled: true, // Hintergrundfarbe aktivieren
          fillColor: widget.backgroundColor, // Hintergrundfarbe des Textfeldes
          border: OutlineInputBorder(
            borderSide: BorderSide(color: widget.borderColor), // Rahmenfarbe des Textfelds
            borderRadius: BorderRadius.circular(widget.borderRadius), // Abgerundete Ecken
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.focusedBorderColor), // Rahmenfarbe bei Fokus
            borderRadius: BorderRadius.circular(widget.borderRadius), // Abgerundete Ecken bei Fokus
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: widget.errorBorderColor), // Rahmenfarbe bei Fehler
            borderRadius: BorderRadius.circular(widget.borderRadius), // Abgerundete Ecken bei Fehler
          ),
          labelText: widget.labelName, // Bezeichnung des Textfelds
          labelStyle: TextStyle(color: widget.labelTextColor), // Stil der Bezeichnung
          floatingLabelStyle: TextStyle(color: widget.focusedBorderColor), // Stil der schwebenden Bezeichnung
          floatingLabelBehavior: FloatingLabelBehavior.never, // Label soll nicht in den oberen Bereich verschieben
          contentPadding: EdgeInsets.symmetric(
              vertical: (widget.height - 20) / 2, horizontal: 12), // Vertikale Zentrierung des Textes
          prefixIcon: widget.prefixIcon != null
              ? IconTheme(
                  data: IconThemeData(color: widget.labelTextColor), // Setzt die Farbe des Icons
                  child: widget.prefixIcon!,
                )
              : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    color: widget.labelTextColor,
                    _obscureText ? Icons.visibility : Icons.visibility_off, // Sichtbarkeit des Passworts steuern
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText; // Text anzeigen oder verbergen
                    });
                  },
                )
              : null,
        ),
        obscureText: widget.isPassword ? _obscureText : false, // Steuert, ob der Text verborgen ist
      ),
    );
  }
}
