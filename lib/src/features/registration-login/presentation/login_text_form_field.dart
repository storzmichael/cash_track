import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:flutter/material.dart';

class LoginTextFormField extends StatefulWidget {
  final String labelName; // Bezeichnung des Textfelds

  final bool isPassword; // Gibt an, ob es sich um ein Passwortfeld handelt
  final bool isUsername; // Gibt an, ob es sich um ein Benutzernamenfeld handelt

  final TextEditingController controller; // Controller für das Textfeld

  final Color borderColor; // Farbe des Rahmens des Textfelds
  final Color focusedBorderColor; // Farbe des Rahmens, wenn das Textfeld den Fokus hat
  final Color errorBorderColor; // Farbe des Rahmens bei einem Fehler
  final Color labelTextColor; // Farbe des Bezeichnungs-Textes

  const LoginTextFormField({
    super.key,
    required this.labelName,
    this.isUsername = false,
    this.isPassword = false,
    required this.controller,
    this.borderColor = greyColor,
    this.focusedBorderColor = primeryColor,
    this.errorBorderColor = alertColor,
    this.labelTextColor = blackColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _LoginTextFormFieldState createState() => _LoginTextFormFieldState();
}

class _LoginTextFormFieldState extends State<LoginTextFormField> {
  bool _obscureText = true; // Steuert, ob der Text des Passwortfeldes verborgen ist

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller, // Controller für das Textfeld
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: widget.borderColor), // Rahmenfarbe des Textfeldes
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.focusedBorderColor), // Rahmenfarbe bei Fokus
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: widget.errorBorderColor), // Rahmenfarbe bei Fehler
        ),
        labelText: widget.labelName, // Bezeichnung des Textfeldes
        labelStyle: TextStyle(color: widget.labelTextColor), // Stil der Bezeichnung
        floatingLabelStyle: TextStyle(color: widget.focusedBorderColor), // Stil der schwebenden Bezeichnung
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          // Überprüft, ob das Feld leer ist
          return '${textFiles[language]![28]} ${widget.labelName} ${textFiles[language]![29]}'; // Fehlermeldung, wenn das Feld leer ist
        }
        if (!widget.isPassword && !widget.isUsername) {
          final emailRegex =
              RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$'); // Regulärer Ausdruck für E-Mail-Validierung
          if (!emailRegex.hasMatch(value)) {
            return textFiles[language]![30]; // Fehlermeldung bei ungültiger E-Mail
          }
        }
        if (widget.isUsername) {
          if (value.length < 6) {
            // Überprüft die Länge des Benutzernamens
            return textFiles[language]![31]; // Fehlermeldung bei zu kurzem Benutzernamen
          }
        }
        {
          if (value.length < 6) {
            // Überprüft die Länge des Passworts
            return textFiles[language]![32]; // Fehlermeldung bei zu kurzem Passwort
          }
        }
        return null; // Keine Fehler, Validierung erfolgreich
      },
    );
  }
}
