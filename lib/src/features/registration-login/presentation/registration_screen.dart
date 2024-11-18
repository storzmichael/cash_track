import 'package:cash_track/src/config/config.dart';
import 'package:cash_track/src/config/config_colors.dart';
import 'package:cash_track/src/core/presentation/app_home.dart';
import 'package:cash_track/src/data/lang/app_text.dart';
import 'package:cash_track/src/features/general_widgets/presentation/big_button.dart';
import 'package:cash_track/src/features/registration-login/presentation/shimmer_logo.dart';
import 'package:cash_track/src/features/registration-login/presentation/widgets/abg_checkbox_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cash_track/src/features/settings/application/language_provider.dart';
import 'login_text_field.dart';

// RegistrationScreen ist das Hauptwidget für den Registrierungsbildschirm der App
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

// State-Klasse für den Registrierungsbildschirm
class _RegistrationScreenState extends State<RegistrationScreen> {
  String? _errorMassage = ''; // Variable für Fehlermeldungen

  final TextEditingController _emailController = TextEditingController(); // Controller für das Email-Feld
  final TextEditingController _passwordController = TextEditingController(); // Controller für das Passwort-Feld

  // Funktion zum Erstellen eines Benutzers mit Email und Passwort
  Future<void> _createUserWithEmailandPassword() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      // Überprüfung, ob Email und Passwort eingegeben wurden
      setState(() {
        _errorMassage = textFiles[language]![50]; // Fehlertext für leere Felder
      });
      _errorAlert(); // Fehlerdialog anzeigen
      return;
    }

    try {
      // Überprüfen, ob die E-Mail bereits mit einem Konto verknüpft ist
      final signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(_emailController.text);

      if (signInMethods.isNotEmpty) {
        setState(() {
          _errorMassage = textFiles[language]![51]; // Fehlertext für bereits vorhandene E-Mail
        });
        _errorAlert(); // Fehlerdialog anzeigen
        return;
      }

      // Benutzer mit der E-Mail und dem Passwort erstellen
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Erfolgreiche Registrierung, weiter zur Hauptseite
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AppHome()),
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      // Fehler bei der Firebase-Authentifizierung
      setState(() {
        _errorMassage = e.message ?? textFiles[language]![52]; // Fehlernachricht aus Firebase
      });
      _errorAlert(); // Fehlerdialog anzeigen
    } catch (e) {
      // Allgemeiner Fehler
      setState(() {
        _errorMassage = '${textFiles[language]![52]}: $e'; // Allgemeiner Fehlertext
      });
      _errorAlert(); // Fehlerdialog anzeigen
    }
  }

  // Dialog zur Anzeige von Fehlermeldungen
  void _errorAlert() {
    if (_errorMassage != null && _errorMassage!.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(textFiles[language]![54]), // Dialogtitel
            content: Text(
              _errorMassage!,
              style: const TextStyle(fontSize: 13, color: alertColor), // Stil der Fehlermeldung
            ),
            actions: <Widget>[
              TextButton(
                child: Text(textFiles[language]![55]), // Text für die Schließen-Schaltfläche
                onPressed: () {
                  Navigator.of(context).pop(); // Schließen des Dialogs
                },
              ),
            ],
          );
        },
      );
    }
  }

  // Widget für das Logo (Shimmer-Effekt)
  Widget _logo() {
    return const ShimmerLogo();
  }

  // Widget für das Email-Eingabefeld
  Widget _emailTextField() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return LoginTextField(
      labelName: textFiles[languageProvider.language]![22], // Dynamischer Label-Text basierend auf der Sprache
      controller: _emailController,
      prefixIcon: const Icon(Icons.person_2_outlined), // Symbol für das Email-Feld
    );
  }

  // Widget für das Passwort-Eingabefeld
  Widget _passwordTextField() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return LoginTextField(
      labelName: textFiles[languageProvider.language]![23], // Dynamischer Label-Text basierend auf der Sprache
      isPassword: true,
      controller: _passwordController,
      prefixIcon: const Icon(Icons.lock_outline_rounded), // Symbol für das Passwort-Feld
    );
  }

  // Widget für den Registrierungs-Button
  Widget _registerButton() {
    final languageProvider = Provider.of<LanguageProvider>(context); // Zugriff auf den LanguageProvider
    return BigButton(
      onPressed: _createUserWithEmailandPassword, // Button führt die Registrierung durch
      buttonName: textFiles[languageProvider.language]![35], // Dynamischer Button-Text basierend auf der Sprache
    );
  }

  // Der build()-Methode, die das Layout des Screens aufbaut
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(textFiles[language]![27]), // Titel der AppBar (Dynamisch)
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    lightThemeList[0],
                    lightThemeList[1],
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(bottomPadding, 0, bottomPadding, sitesPadding),
                child: Column(
                  children: [
                    const SizedBox(height: 0),
                    _logo(), // Logo mit Shimmer-Effekt
                    const SizedBox(height: 50),
                    _emailTextField(), // Email-Eingabefeld
                    const SizedBox(height: 8),
                    _passwordTextField(), // Passwort-Eingabefeld
                    const SizedBox(height: 16),
                    _registerButton(), // Registrierungs-Button
                    const SizedBox(height: 8),
                    AgbCheckboxField(agbText: 'hallo', agbLink: 'agbLink') // Checkbox für AGB
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
