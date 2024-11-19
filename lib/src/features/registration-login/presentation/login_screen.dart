import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/app_home.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/registration-login/domain/password_reset_service.dart';
import 'package:cash_track/src/features/registration-login/presentation/shimmer_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Importiere Provider
import 'login_text_field.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? _errorMassage = ''; // Variable für Fehlermeldungen

  final TextEditingController _emailController = TextEditingController(); // Controller für das E-Mail-Feld
  final TextEditingController _passwordController = TextEditingController(); // Controller für das Passwort-Feld

  // Funktion zum Anmelden mit E-Mail und Passwort
  Future<void> _signInWithEmailandPassword() async {
    // Überprüfen, ob E-Mail oder Passwort leer sind
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMassage = textFiles[language]![69]; // Fehlertext für leere Eingaben
      });
      _errorAlert(); // Zeigt die Fehlermeldung an
      return;
    }

    try {
      // Versuch, sich mit Firebase anzumelden
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Wenn die Anmeldung erfolgreich war, weiter zur Startseite
      if (userCredential.user != null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AppHome()), // Home-Seite nach erfolgreichem Login
          (route) => false, // Entfernt alle vorherigen Routen
        );
      }
    } on FirebaseAuthException catch (e) {
      // Fehler bei der Anmeldung (z.B. falsche E-Mail oder Passwort)
      setState(() {
        _errorMassage = e.message; // Fehlernachricht aus Firebase
      });
      _errorAlert(); // Zeigt die Fehlermeldung an
    } catch (e) {
      // Allgemeiner Fehler
      setState(() {
        _errorMassage = '${textFiles[language]![70]}: $e'; // Unerwarteter Fehler
      });
      _errorAlert(); // Zeigt die Fehlermeldung an
    }
  }

  // Funktion, um eine Fehlermeldung anzuzeigen
  void _errorAlert() {
    if (_errorMassage != null && _errorMassage!.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(textFiles[language]![54]), // Fehlerdialog-Titel
            content: Text(
              _errorMassage!,
              style: const TextStyle(fontSize: 13, color: alertColor), // Fehlermeldung in roter Farbe
            ),
            actions: <Widget>[
              TextButton(
                child: Text(textFiles[language]![55]), // Dialog-Button
                onPressed: () {
                  Navigator.of(context).pop(); // Schließt den Dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Widget für das Logo
  Widget _logo() {
    return const ShimmerLogo(); // Das Logo mit Schimmer-Effekt
  }

  // Widget für das E-Mail-Eingabefeld
  Widget _emailTextField() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return LoginTextField(
      labelName: textFiles[languageProvider.language]![22], // E-Mail-Label
      controller: _emailController,
      prefixIcon: const Icon(Icons.person_2_outlined), // E-Mail-Symbol
    );
  }

  // Widget für das Passwort-Eingabefeld
  Widget _passwordTextField() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return LoginTextField(
      labelName: textFiles[languageProvider.language]![23], // Passwort-Label
      isPassword: true, // Passwortfeld
      controller: _passwordController,
      prefixIcon: const Icon(Icons.lock_outline_rounded), // Schloss-Symbol
    );
  }

  // Widget für den Login-Button
  Widget _loginButton() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return BigButton(
      onPressed: _signInWithEmailandPassword, // Login-Funktion wird beim Drücken aufgerufen
      buttonName: textFiles[languageProvider.language]![20], // "Login"-Button-Text
    );
  }

  // Widget für den Registrieren-Button
  Widget _registerButton() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, "/registration"); // Navigation zur Registrierungsseite
      },
      child: Text(
        textFiles[languageProvider.language]![27], // Registrierung-Button-Text
        style: Theme.of(context).textTheme.labelMedium, // Textstil
      ),
    );
  }

  // Widget für den "Passwort vergessen"-Button
  Widget _passwordForgotButton() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return TextButton(
      onPressed: () {
        showPasswordResetDialog(
          context, // Dialog für Passwort-Zurücksetzen anzeigen
        );
      },
      child: Text(
        textFiles[languageProvider.language]![84], // Text für Passwort zurücksetzen
        style: Theme.of(context).textTheme.labelMedium, // Textstil
      ),
    );
  }

  // Widget für einen Test-Button (für Entwicklungszwecke)
  Widget _testButton() {
    return BigButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, "/appHome"); // Navigation zur Home-Seite
      },
      buttonName: 'test', // Test-Button
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // Verhindert Überlappen mit der Tastatur
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightThemeList[0], // Farbverlauf für den Hintergrund
                    lightThemeList[1],
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(bottomPadding, sitesPadding, bottomPadding, sitesPadding),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom, // Passt die Polsterung für die Tastatur an
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100), // Abstand nach oben
                      _logo(), // Logo anzeigen
                      const SizedBox(height: 50), // Abstand nach unten
                      _emailTextField(), // E-Mail Textfeld
                      const SizedBox(height: 8), // Abstand
                      _passwordTextField(), // Passwort Textfeld
                      const SizedBox(height: 16), // Abstand
                      _loginButton(), // Login-Button
                      Row(
                        children: [
                          _passwordForgotButton(), // Passwort vergessen Button
                          Expanded(child: SizedBox()), // Verhindert Überlappen
                          _registerButton(), // Registrierungs-Button
                        ],
                      ),
                      Expanded(
                        child: SizedBox(), // Platz für weitere Widgets
                      ),
                      //_testButton(), // Test-Button (wird nicht angezeigt)
                      const SizedBox(height: bottomSafeArea), // Abstand nach unten
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
