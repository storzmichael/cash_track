import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/data/lang/app_text.dart';

import 'package:cash_track/src/core/presentation/theme_container.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/general_widgets/presentation/outlined_big_button.dart';
import 'package:cash_track/src/features/registration-login/presentation/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'login_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController(); // Controller für das E-Mail-Feld
  final TextEditingController passwordController = TextEditingController(); // Controller für das Passwortfeld
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Schlüssel für das Formular zur Validierung

  bool rememberMe = false; // Status für die "Angemeldet bleiben"-Checkbox
  final String correctPassword = '123'; // Korrektes Passwort für die Anmeldung

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark, // Farbgebung der System-UI-Überlagerung
        title: Text(
          textFiles[language]![20], // Titel des AppBars aus der Sprachdatei
          style: const TextStyle(fontWeight: FontWeight.bold), // Textstil für den Titel
        ),
      ),
      body: Stack(
        children: [
          const ThemeContainer(), // Hintergrund-Themencontainer
          Padding(
            padding: const EdgeInsets.fromLTRB(
                bottomPadding, sitesPadding, bottomPadding, sitesPadding), // Padding um den Inhalt
            child: Form(
              key: _formKey, // Schlüssel zur Validierung des Formulars
              child: Column(
                children: [
                  Center(
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
                              style: TextStyle(
                                  fontFamily: 'RubikOne', fontSize: 24, fontWeight: FontWeight.bold), // Textstil
                            ),
                          ),
                        ),
                        Text(
                          textFiles[language]![21], // Zusätzlicher Text aus der Sprachdatei
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32, // Abstand zwischen Logo und Formularfeldern
                  ),
                  LoginTextFormField(
                    labelName: textFiles[language]![22], // Label für das E-Mail-Feld
                    controller: emailController, // Controller für das E-Mail-Feld
                  ),
                  const SizedBox(
                    height: 12, // Abstand zwischen E-Mail- und Passwortfeld
                  ),
                  LoginTextFormField(
                    labelName: textFiles[language]![23], // Label für das Passwortfeld
                    isPassword: true, // Passwortfeld
                    controller: passwordController, // Controller für das Passwortfeld
                  ),
                  const SizedBox(
                    height: 20, // Abstand zwischen Passwortfeld und Anmeldebutton
                  ),
                  BigButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Formularvalidierung
                        if (passwordController.text == correctPassword) {
                          // Passwortüberprüfung
                          Navigator.pushNamed(context, "/apphome"); // Navigation zur Hauptseite
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(textFiles[language]![24])), // Fehlermeldung bei falschem Passwort
                          );
                        }
                      }
                    },
                    buttonName: textFiles[language]![20], // Name des Anmeldebuttons aus der Sprachdatei
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Abstand zwischen Checkbox und Passwort zurücksetzen
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe, // Status der "Angemeldet bleiben"-Checkbox
                            onChanged: (bool? value) {
                              setState(() {
                                rememberMe = value ?? false; // Status aktualisieren
                              });
                            },
                          ),
                          Text(
                            textFiles[language]![25], // Text für die "Angemeldet bleiben"-Option
                            style: Theme.of(context).textTheme.bodySmall, // Textstil
                          ),
                        ],
                      ),
                      Text(
                        textFiles[language]![26], // Text für "Passwort zurücksetzen"
                        style: Theme.of(context).textTheme.bodySmall, // Textstil
                      ),
                    ],
                  ),
                  const Expanded(
                    child: SizedBox(), // Platzhalter, um die Schaltflächen nach unten zu verschieben
                  ),
                  OutlinedBigButton(
                    buttonName: textFiles[language]![27], // Name des Buttons für die Registrierung aus der Sprachdatei
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegistrastionScreen()), // Navigation zur Registrierungsseite
                      );
                    },
                  ),
                  const SizedBox(height: 32) // Abstand am unteren Rand
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
